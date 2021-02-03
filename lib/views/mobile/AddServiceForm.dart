import 'dart:io';
import 'dart:ui';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/for_admin/AddServiceFormBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/widgets/Common.dart';
import 'package:scheduler/widgets/custom_filled_icons_icons.dart';

class AddServiceForm extends StatefulWidget {
  @override
  _AddServiceFormState createState() => _AddServiceFormState();
}

class _AddServiceFormState extends State<AddServiceForm> {
  int charLength = 0;
  List<Asset> images = [];

  _onChanged(String value) {
    setState(() {
      charLength = value.length;
    });
  }

  final _detailsController = TextEditingController();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  Future<void> loadAssets() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarTitle: "Select Images for service",
          allViewTitle: "All Photos",
          useDetailsView: true,
          startInAllView: true,
        ),
      );
    } on Exception catch (e) {
      e.toString();
    }
    if (!mounted) return;
    setState(() {
      images = resultList;
    });
  }

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
                                      name: value.name,
                                      type: value.type,
                                      category: value.category,
                                      cost: value.cost,
                                      timeRequired: value.timeRequired,
                                      imageURLs: value.imageURLs,
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
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        margin: EdgeInsets.all(20.0),
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          shadowColor: Colors.blueGrey.shade100,
                          elevation: 1,
                          clipBehavior: Clip.antiAlias,
                          color: Colors.white,
                          shape: SquircleBorder(radius: 60),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(2),
                                child: Material(
                                  clipBehavior: Clip.antiAlias,
                                  shape: SquircleBorder(radius: 60),
                                  child: Container(
                                    height: 260,
                                    width: MediaQuery.of(context).size.width,
                                    child: Consumer<AddServiceFormBloc>(
                                        builder: (context, value, _) {
                                      if (value.imageFiles.isNotEmpty) {
                                        return Image.file(
                                          value.imageFiles[0],
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                        );
                                      } else
                                        return Center(
                                          child: Text(
                                              "No Banner Image selected yet"),
                                        );
                                    }),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Consumer<AddServiceFormBloc>(
                                                    builder:
                                                        (context, value, _) {
                                                  return Text(
                                                    value.type,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors
                                                          .blueGrey.shade300,
                                                    ),
                                                  );
                                                }),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.8,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5),
                                                  child: Consumer<
                                                          AddServiceFormBloc>(
                                                      builder:
                                                          (context, value, _) {
                                                    return Text(
                                                      value.name,
                                                      textAlign:
                                                          TextAlign.start,
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                        color: Colors.blueGrey,
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Consumer<AddServiceFormBloc>(
                                                    builder:
                                                        (context, value, _) {
                                                  return Text(
                                                    "\$${value.cost}",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors
                                                          .blueGrey.shade700,
                                                    ),
                                                  );
                                                }),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 8.0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey.shade200,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        CustomFilledIcons
                                                            .fi_sr_shopping_bag_add,
                                                        size: 16,
                                                        color: Colors.blueGrey,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        "Add",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
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
                                        builder: (context, value, _) {
                                      return TextFormField(
                                        controller: _titleController,
                                        onChanged: (text) {
                                          value.name = text;
                                          value.update();
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
                      ),
                      Divider(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
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
                      ),
                      Divider(height: 20),
                      Consumer<AddServiceFormBloc>(
                        builder: (context, value, _) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: CupertinoButton.filled(
                              borderRadius: BorderRadius.circular(12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                  ),
                                  SizedBox(width: 10),
                                  Text(value.imageFiles.isEmpty
                                      ? "Add Images"
                                      : "Change Images")
                                ],
                              ),
                              onPressed: () async {
                                await loadAssets();
                                await value.getImageFilesFromAssets(images);
                              },
                            ),
                          );
                        },
                      ),
                      Consumer<AddServiceFormBloc>(
                        builder: (context, value, child) {
                          if (value.imageFiles.isEmpty)
                            return Container();
                          else
                            return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                "First image will be displayed in the service thumbnail previews and banners. You can reorder your selection by long pressing an image and dropping it where ever you like.",
                              ),
                            );
                        },
                      ),
                      Container(
                        height: 130,
                        child: Consumer<AddServiceFormBloc>(
                            builder: (context, value, _) {
                          if (value.imageFiles.isNotEmpty) {
                            return ReorderableListView(
                              onReorder: (oldIndex, newIndex) {
                                setState(
                                  () {
                                    if (newIndex > oldIndex) {
                                      newIndex -= 1;
                                    }
                                    final File item =
                                        value.imageFiles.removeAt(oldIndex);
                                    value.imageFiles.insert(newIndex, item);
                                  },
                                );
                              },
                              scrollDirection: Axis.horizontal,
                              children: value.imageFiles
                                  .mapIndex<Container>((file, index) {
                                return Container(
                                  height: 130,
                                  width: 170,
                                  key: ValueKey(index),
                                  margin: EdgeInsets.only(left: 5),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        height: 130,
                                        width: 170,
                                        child: Material(
                                          clipBehavior: Clip.hardEdge,
                                          shape: SquircleBorder(radius: 30),
                                          child: Image.file(
                                            file,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: CircleAvatar(
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                          child: IconButton(
                                            splashRadius: 1,
                                            onPressed: () {
                                              value.imageFiles.removeAt(index);
                                              value.update();
                                            },
                                            icon: Icon(Icons.close),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          } else {
                            return Center(child: Text("No Image selected yet"));
                          }
                        }),
                      ),
                      Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  child: Material(
                                    color: Colors.white70,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.hand_raised,
                                      color: Colors.blueGrey,
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
                                initialvalue: snapshot.type,
                                valueChanged: (val, index) {
                                  snapshot.type = val;
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
                      ),
                      Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  child: Material(
                                    color: Colors.white70,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      Icons.design_services,
                                      color: Colors.blueGrey,
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
                      ),
                      Divider(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  child: Material(
                                    color: Colors.white70,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.money_dollar_circle,
                                      color: Colors.blueGrey,
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
                                          snapshot.cost = text;
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
                      ),
                      Divider(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 45,
                                  width: 45,
                                  child: Material(
                                    color: Colors.white70,
                                    shape: SquircleBorder(
                                      radius: 30.0,
                                    ),
                                    child: Icon(
                                      CupertinoIcons.stopwatch,
                                      color: Colors.blueGrey,
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
                                  builder: (context, value, _) {
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
                                              if (value.timeRequired > 15) {
                                                value.timeRequired =
                                                    value.timeRequired - 15;
                                                value.update();
                                              }
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
                                                  value.timeRequired
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
                                              if (value.timeRequired < 360) {
                                                value.timeRequired =
                                                    value.timeRequired + 15;
                                                value.update();
                                              }
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
                      ),
                      Divider(height: 20),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
            Consumer<AddServiceFormBloc>(builder: (context, value, _) {
              if (value.isBusy) {
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
