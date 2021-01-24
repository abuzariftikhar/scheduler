import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/for_admin/AddServiceFormBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/widgets/Common.dart';

class AddServiceForm extends StatefulWidget {
  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  Timer timer;
  int charLength = 0;
  Color dialogPickerColor = Colors.white;
  static const Color guidePrimary = Color(0xFF6200EE);
  static const Color guidePrimaryVariant = Color(0xFF3700B3);
  static const Color guideSecondary = Color(0xFF03DAC6);
  static const Color guideSecondaryVariant = Color(0xFF018786);
  static const Color guideError = Color(0xFFB00020);
  static const Color guideErrorDark = Color(0xFFCF6679);
  static const Color blueBlues = Color(0xFF174378);

  // Make a custom ColorSwatch to name map from the above custom colors.
  final Map<ColorSwatch<Object>, String> colorsNameMap =
      <ColorSwatch<Object>, String>{
    ColorTools.createPrimarySwatch(guidePrimary): 'Guide Purple',
    ColorTools.createPrimarySwatch(guidePrimaryVariant): 'Guide Purple Variant',
    ColorTools.createAccentSwatch(guideSecondary): 'Guide Teal',
    ColorTools.createAccentSwatch(guideSecondaryVariant): 'Guide Teal Variant',
    ColorTools.createPrimarySwatch(guideError): 'Guide Error',
    ColorTools.createPrimarySwatch(guideErrorDark): 'Guide Error Dark',
    ColorTools.createPrimarySwatch(blueBlues): 'Blue blues',
  };

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });
  }

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      color: dialogPickerColor,
      onColorChanged: (Color color) =>
          setState(() => dialogPickerColor = color),
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      wheelSubheading: Text(
        'Selected color and its shades',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: true,
        ColorPickerType.wheel: true,
      },
      customColorSwatchesAndNames: colorsNameMap,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }

  final _detailsController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddServiceFormBloc>(
      create: (context) => AddServiceFormBloc(),
      child: Scaffold(
        body: Stack(
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  elevation: 1,
                  pinned: true,
                  backgroundColor: Colors.white,
                  leading: CloseButton(
                    color: Colors.grey.shade700,
                  ),
                  title: Text(
                    "Add Services",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Consumer<AddServiceFormBloc>(
                            builder: (context, value, _) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              elevation: 1,
                              color: Colors.blueAccent,
                              shape: SquircleBorder(
                                radius: 20.0,
                              ),
                              child: InkResponse(
                                splashColor: Colors.white24,
                                onTap: () async {
                                  await value.uploadFile();
                                  bool result = await value.postService(
                                    ServiceItem(
                                      name: value.title,
                                      color: dialogPickerColor.value,
                                      type: value.serviceType,
                                      category: value.category,
                                      cost: value.price,
                                      timeRequired: value.timeRequired,
                                      imageURL: value.imageURL,
                                      detailText: value.detailsText,
                                    ),
                                  );
                                  if (result) Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 40,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Post",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        AspectRatio(
                          aspectRatio: 1.1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 30,
                                      color: Colors.black12,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width - 180,
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  shape: SquircleBorder(
                                    radius: 50.0,
                                  ),
                                  child: Stack(
                                    children: [
                                      Consumer<AddServiceFormBloc>(
                                          builder: (context, value, _) {
                                        return Container(
                                          child: value.imageFile == null
                                              ? Center(child: Text("No Image"))
                                              : Image.file(
                                                  File(value.imageFile.path),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  fit: BoxFit.cover,
                                                  height: double.maxFinite,
                                                  width: double.maxFinite,
                                                ),
                                        );
                                      }),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ClipRect(
                                          clipBehavior: Clip.antiAlias,
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 12.0, sigmaY: 12.0),
                                            child: Container(
                                              height: 70,
                                              width: double.maxFinite,
                                              color: Colors.black26,
                                              child: Stack(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .fromLTRB(
                                                        10, 10, 70, 10),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Consumer<
                                                              AddServiceFormBloc>(
                                                          builder: (context,
                                                              snapshot, _) {
                                                        return Text(
                                                          snapshot.title,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 12,
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: 2,
                                                              horizontal: 5,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                              color: Colors
                                                                  .amber
                                                                  .shade900,
                                                            ),
                                                            child: Text(
                                                              "Premium",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 11,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Consumer<
                                                                  AddServiceFormBloc>(
                                                              builder: (context,
                                                                  snapshot, _) {
                                                            return Text(
                                                              "\$${snapshot.price}",
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                fontSize: 16,
                                                              ),
                                                            );
                                                          }),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    CupertinoIcons.pencil,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text("Set a title"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 60.0,
                              child: Material(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                shape: SquircleBorder(
                                  radius: 30.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Center(
                                    child: Consumer<AddServiceFormBloc>(
                                        builder: (context, snapshot, _) {
                                      return TextFormField(
                                        controller: _titleController,
                                        onChanged: (text) {
                                          snapshot.title = text;
                                          snapshot.update();
                                        },
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: "Enter Some title",
                                          border: InputBorder.none,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text("Add description"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: Material(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                shape: SquircleBorder(
                                  radius: 30.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: Center(
                                    child: Consumer<AddServiceFormBloc>(
                                        builder: (context, snapshot, _) {
                                      return TextField(
                                        controller: _detailsController,
                                        onChanged: (text) {
                                          _onChanged(text);
                                          snapshot.detailsText = text;
                                        },
                                        maxLines: null,
                                        maxLength: 255,
                                        maxLengthEnforced: true,
                                        decoration: InputDecoration(
                                            counter: charLength == 0
                                                ? Container()
                                                : Text(
                                                    'characters left: ${255 - charLength}'),
                                            fillColor: Colors.white,
                                            filled: true,
                                            border: InputBorder.none,
                                            hintText:
                                                'Tap to enter a short description.'),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(height: 20),
                        Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.photo_album,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text("Set a Image"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Consumer<AddServiceFormBloc>(
                                        builder: (context, snapshot, _) {
                                      return GestureDetector(
                                        onTap: () async {
                                          snapshot
                                              .pickImage(ImageSource.gallery);
                                        },
                                        child: Container(
                                          width: 180,
                                          height: 50,
                                          child: Material(
                                            clipBehavior: Clip.antiAlias,
                                            color: Colors.green,
                                            shape: SquircleBorder(
                                              radius: 22.0,
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.upload_file,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    snapshot.imageURL != null
                                                        ? "Change Image"
                                                        : "Upload Image",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                    SizedBox(height: 10),
                                    Consumer<AddServiceFormBloc>(
                                        builder: (context, snapshot, _) {
                                      return GestureDetector(
                                        onTap: () async {
                                          snapshot.imageURL = null;
                                          snapshot.update();
                                        },
                                        child: Container(
                                          width: 180,
                                          height: 50,
                                          child: Material(
                                            clipBehavior: Clip.antiAlias,
                                            color: Colors.red,
                                            shape: SquircleBorder(
                                              radius: 22.0,
                                            ),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .delete_forever_outlined,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Remove Image",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                                Container(
                                  height: 110.0,
                                  child: Material(
                                    color: Colors.white,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 3, vertical: 3),
                                      height: 104,
                                      width: 84,
                                      child: Consumer<AddServiceFormBloc>(
                                          builder: (context, snapshot, _) {
                                        return Material(
                                          clipBehavior: Clip.antiAlias,
                                          color: Colors.white,
                                          shape: SquircleBorder(
                                            radius: 30.0,
                                          ),
                                          child: snapshot.imageFile == null
                                              ? Center(child: Text("No Image"))
                                              : Image.file(
                                                  File(snapshot.imageFile.path),
                                                  alignment:
                                                      Alignment.topCenter,
                                                  fit: BoxFit.cover,
                                                  height: double.maxFinite,
                                                  width: double.maxFinite,
                                                ),
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Material(
                                    color: Colors.blueAccent,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.hand_raised,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text("Select type"),
                              ],
                            ),
                            Consumer<AddServiceFormBloc>(
                                builder: (context, snapshot, _) {
                              return CustomDropdownList(
                                initialvalue: snapshot.serviceType,
                                valueChanged: (val, index) {
                                  snapshot.serviceType = val;
                                  snapshot.update();
                                },
                                itemList: [
                                  "Hair Cutting",
                                  "Hair Dying",
                                  "Waxing Service",
                                  "Nail Treatment",
                                  "Skin Treatment"
                                ],
                              );
                            }),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Material(
                                    color: Colors.green.shade600,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      Icons.design_services,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Text("In-App Category"),
                              ],
                            ),
                            Consumer<AddServiceFormBloc>(
                                builder: (context, snapshot, _) {
                              return CustomDropdownList(
                                initialvalue: snapshot.category,
                                valueChanged: (val, index) {
                                  snapshot.category = val;
                                  snapshot.update();
                                },
                                itemList: [
                                  "Best",
                                  "Banner",
                                  "Expert",
                                  "Premium",
                                  "Popular",
                                  "Top-Rated",
                                ],
                              );
                            }),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Material(
                                    color: Colors.blue.shade900,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.money_dollar_circle,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Set a Color"),
                              ],
                            ),
                            Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: InkWell(
                                onTap: () {
                                  colorPickerDialog();
                                },
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.white,
                                  shape: SquircleBorder(
                                    radius: 30.0,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Center(
                                        child: Row(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: 45,
                                          child: Material(
                                            color: dialogPickerColor,
                                            shape: SquircleBorder(
                                              radius: 30.0,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text("Choose a Color"),
                                      ],
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Material(
                                    color: Colors.blue.shade900,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.money_dollar_circle,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Set a price"),
                              ],
                            ),
                            Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Material(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.white,
                                shape: SquircleBorder(
                                  radius: 30.0,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Center(
                                    child: Consumer<AddServiceFormBloc>(
                                        builder: (context, snapshot, _) {
                                      return TextFormField(
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        controller: _priceController,
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                          decimal: true,
                                          signed: false,
                                        ),
                                        onChanged: (text) {
                                          snapshot.price = text;
                                        },
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          hintText: "",
                                          border: InputBorder.none,
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: Material(
                                    color: Colors.red.shade600,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.stopwatch,
                                      color: Colors.white,
                                      size: 22,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text("Time required"),
                              ],
                            ),
                            Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: Consumer<AddServiceFormBloc>(
                                  builder: (context, snapshot, _) {
                                return Material(
                                    clipBehavior: Clip.antiAlias,
                                    color: Colors.white,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              snapshot.timeRequired--;
                                              snapshot.update();
                                            },
                                            onTapDown:
                                                (TapDownDetails details) {
                                              timer = Timer.periodic(
                                                  Duration(milliseconds: 80),
                                                  (t) {
                                                snapshot.timeRequired--;
                                                snapshot.update();
                                              });
                                            },
                                            onTapUp: (TapUpDetails details) {
                                              timer.cancel();
                                            },
                                            onTapCancel: () {
                                              timer.cancel();
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              child: Material(
                                                color: Colors.grey.shade800,
                                                shape: SquircleBorder(
                                                  radius: 30.0,
                                                ),
                                                child: Transform.translate(
                                                  offset: Offset(0, -8),
                                                  child: Icon(
                                                    Icons.minimize,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  snapshot.timeRequired
                                                          .toString() +
                                                      "\nMinutes",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              snapshot.timeRequired++;
                                              snapshot.update();
                                            },
                                            onTapDown:
                                                (TapDownDetails details) {
                                              timer = Timer.periodic(
                                                  Duration(milliseconds: 80),
                                                  (t) {
                                                snapshot.timeRequired++;
                                                snapshot.update();
                                              });
                                            },
                                            onTapUp: (TapUpDetails details) {
                                              timer.cancel();
                                            },
                                            onTapCancel: () {
                                              timer.cancel();
                                            },
                                            child: Container(
                                              height: 45,
                                              width: 45,
                                              child: Material(
                                                color: Colors.grey.shade800,
                                                shape: SquircleBorder(
                                                  radius: 30.0,
                                                ),
                                                child: Icon(
                                                  CupertinoIcons.plus,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                              }),
                            ),
                          ],
                        ),
                        Divider(height: 20),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Consumer<AddServiceFormBloc>(builder: (context, value, _) {
              if (value.isPosting) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white30,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
