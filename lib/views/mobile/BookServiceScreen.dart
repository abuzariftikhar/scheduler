import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/views/mobile/LandingScreen.dart';
import 'package:scheduler/widgets/custom_filled_icons_icons.dart';

import 'QuickEntryScreen.dart';

class BookServiceScreen extends StatefulWidget {
  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String date;

  Widget _getBookingScreen(int index) {
    Widget _widget = Container();
    if (index == 0) {
      _widget = BookingOverviewScreen();
    } else if (index == 1) {
      _widget = DateTimeSelectionScreen();
    } else if (index == 2) {
      _widget = PaymentMethodScreen();
    } else if (index == 3) {
      _widget = BookingSuccessScreen();
    }
    return _widget;
  }

  void initState() {
    date = formatter.format(DateTime.now());
    Provider.of<CartBloc>(context, listen: false).reset();
    Provider.of<CartBloc>(context, listen: false).loadHours();
    Provider.of<CartBloc>(context, listen: false).loadReservedHours(date);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Consumer<CartBloc>(builder: (context, value, _) {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 10),
                  transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(
                                  value.index > value.previousIndex ? 1 : -1,
                                  0,
                                ),
                                end: Offset(0, 0))
                            .chain(CurveTween(curve: Curves.easeOutCirc))
                            .animate(animation),
                        child: child,
                      ),
                  child: _getBookingScreen(value.index));
            }),
          ],
        ));
  }
}

class BookingTimeSelection extends StatefulWidget {
  @override
  _BookingTimeSelectionState createState() => _BookingTimeSelectionState();
}

class _BookingTimeSelectionState extends State<BookingTimeSelection> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [],
      ),
    );
  }
}

class SlotTile extends StatefulWidget {
  final String from;
  final String to;
  final int index;
  final bool isReserved;
  final Function onTap;

  const SlotTile({
    Key key,
    @required this.from,
    @required this.to,
    @required this.index,
    @required this.isReserved,
    @required this.onTap,
  }) : super(key: key);

  @override
  _SlotTileState createState() => _SlotTileState();
}

class _SlotTileState extends State<SlotTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartBloc>(builder: (context, value, _) {
      return GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.decelerate,
          decoration: BoxDecoration(
            color: value.currentSelection.contains(widget.index)
                ? Colors.blueAccent
                : value.reservedSlots.contains(widget.index)
                    ? Colors.blueGrey.shade100
                    : Colors.grey.shade100,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.from,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: value.currentSelection.contains(widget.index)
                      ? Colors.white
                      : value.reservedSlots.contains(widget.index)
                          ? Colors.blueGrey
                          : Colors.black,
                ),
              ),
              Text(
                "To",
                style: TextStyle(
                  color: value.currentSelection.contains(widget.index)
                      ? Colors.white
                      : value.reservedSlots.contains(widget.index)
                          ? Colors.blueGrey
                          : Colors.black,
                ),
              ),
              Text(
                widget.to,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: value.currentSelection.contains(widget.index)
                      ? Colors.white
                      : value.reservedSlots.contains(widget.index)
                          ? Colors.blueGrey
                          : Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                value.reservedSlots.contains(widget.index)
                    ? "reserved"
                    : "available",
              ),
            ],
          ),
        ),
      );
    });
  }
}

class BookingOverviewScreen extends StatefulWidget {
  @override
  _BookingOverviewScreenState createState() => _BookingOverviewScreenState();
}

class _BookingOverviewScreenState extends State<BookingOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              stretch: true,
              expandedHeight: 200,
              elevation: 1,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade100,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.2, 2),
                        child: Icon(
                          CustomFilledIcons.fi_sr_notebook,
                          size: 150,
                          color: Colors.white54,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40),
                            Text(
                              "Booking Overview",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Let's get your reservation ready.",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<CartBloc>(builder: (context, value, _) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Cost",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.blueGrey.shade700,
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            reverseDuration: Duration(milliseconds: 10),
                            transitionBuilder: (child, animation) =>
                                SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0.5, 0),
                                end: Offset(0, 0),
                              )
                                  .chain(CurveTween(curve: Curves.easeOutCirc))
                                  .animate(animation),
                              child: child,
                            ),
                            child: Text(
                              "\$${value.totalCost.toString()}",
                              key: ValueKey(value.totalCost),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Duration",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              color: Colors.blueGrey.shade700,
                            ),
                          ),
                          AnimatedSwitcher(
                            duration: Duration(milliseconds: 400),
                            reverseDuration: Duration(milliseconds: 10),
                            transitionBuilder: (child, animation) =>
                                SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0.5, 0),
                                end: Offset(0, 0),
                              )
                                  .chain(CurveTween(curve: Curves.easeOutCirc))
                                  .animate(animation),
                              child: child,
                            ),
                            child: Text(
                              value.durationToString(
                                  value.totalSlotsRequired * 15),
                              key: ValueKey(value.totalSlotsRequired),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                    ],
                  ),
                ),
              );
            }),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected services",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                      ),
                    ),
                    Text(
                      "Here is an overview of your selected services, If you want to add more services here you can go back and add them to your cart and start booking when you're ready.",
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<CartBloc>(builder: (context, value, _) {
              return SliverList(
                delegate: SliverChildListDelegate(value.cartItems
                    .map((item) => QuickServiceTile(serviceItem: item))
                    .toList()),
              );
            }),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
              ),
            ),
          ],
        ),
        Consumer<CartBloc>(builder: (context, value, _) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Button2(
                    onTap: () {
                      if (value.cartItems.isNotEmpty) {
                        value.previousIndex = value.index;
                        value.index++;
                        value.update();
                      } else {
                        showSimpleNotification(
                            Text(
                              "No item present in cart. please add items to continue booking process",
                            ),
                            background: Colors.redAccent,
                            duration: Duration(seconds: 3));
                      }
                    },
                    title: "Next",
                    titleColor: Colors.white,
                    iconData: Icons.arrow_forward_rounded,
                    backgroundColor: value.cartItems.isNotEmpty
                        ? Colors.blueAccent
                        : Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}

class DateTimeSelectionScreen extends StatefulWidget {
  @override
  _DateTimeSelectionScreenState createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String date;

  @override
  void initState() {
    date = formatter.format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          stretch: true,
          expandedHeight: 200,
          elevation: 1,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xfffadacb),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(1.2, 2),
                    child: Icon(
                      CustomFilledIcons.fi_sr_time_check,
                      size: 150,
                      color: Colors.white54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "Day & Time",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "When can you come to the shop?",
                          style: TextStyle(
                            color: Colors.brown.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Consumer<CartBloc>(builder: (context, value, _) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "You need ${value.totalSlotsRequired} Slots",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Please select a day and time for your reservation. If there is no slot available below, you can change the date to make a reservation on some other day.",
                    style: TextStyle(),
                  ),
                ],
              ),
            );
          }),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                            color: Colors.brown.shade400,
                            shape: SquircleBorder(
                              radius: 30.0,
                            ),
                            child: Icon(
                              CustomFilledIcons.fi_sr_calendar,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text("Choose a date"),
                      ],
                    ),
                    Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                              isScrollControlled: true,
                              elevation: 15,
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "Choose a day",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                    CalendarDatePicker(
                                      onDateChanged: (picked) {
                                        setState(() {
                                          date = formatter.format(picked);
                                        });
                                      },
                                      firstDate: DateTime.now(),
                                      initialDate: DateTime.parse(date),
                                      lastDate: DateTime.now().add(
                                        Duration(days: 365),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          OutlineButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.pop(context, date);
                                            },
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          MaterialButton(
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Text('OK',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                            onPressed: () {
                                              Navigator.pop(context, date);
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Material(
                          clipBehavior: Clip.antiAlias,
                          color: Colors.blueGrey.shade50,
                          shape: SquircleBorder(
                            radius: 30.0,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Center(child: Text(date)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 20,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Time Slots for $date",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Consumer<CartBloc>(builder: (context, value, _) {
          return SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final hourFrom = value.totalSlots.sublist(40, 93)[index];
                  final hourTo = value.totalSlots.sublist(40, 93)[index + 1];
                  return SlotTile(
                    index: index + 40,
                    from: hourFrom.format(context),
                    to: hourTo.format(context),
                    isReserved: false,
                    onTap: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      List<int> _selection = [];
                      _selection.clear();
                      for (var i = 0; i < value.requiredSlot; i++) {
                        _selection.add(index + i + 40);
                      }
                      if (index + 40 + value.requiredSlot <
                              value.totalSlots.length - 4 &&
                          !_selection.any((element) {
                            return value.reservedSlots.contains(element);
                          })) {
                        value.currentSelection = _selection;
                        value.update();
                        print(value.currentSelection);
                      } else {
                        showSimpleNotification(
                            Text(
                              (index + 40 + value.requiredSlot >
                                      value.totalSlots.sublist(40, 92).length +
                                          40)
                                  ? "Shop might be closed before we can serve you."
                                  : "We might be serving someone else in this time",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            background: Colors.redAccent,
                            position: NotificationPosition.bottom);
                      }
                    },
                  );
                },
                childCount: value.totalSlots.sublist(40, 92).length,
                addAutomaticKeepAlives: true,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                crossAxisCount: 4,
              ),
            ),
          );
        }),
        SliverToBoxAdapter(
          child: SizedBox(height: 100),
        ),
      ],
    );
  }
}

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          stretch: true,
          expandedHeight: 160,
          elevation: 1,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              height: 160,
              decoration: BoxDecoration(
                color: Color(0xfffadacb),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(1.2, 2),
                    child: Icon(
                      CustomFilledIcons.fi_sr_time_check,
                      size: 150,
                      color: Colors.white54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "Payment",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "How would you like pay for the services?",
                          style: TextStyle(
                            color: Colors.brown.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class BookingSuccessScreen extends StatefulWidget {
  @override
  _BookingSuccessScreenState createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          stretch: true,
          expandedHeight: 160,
          elevation: 1,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              height: 160,
              decoration: BoxDecoration(
                color: Color(0xfffadacb),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment(1.2, 2),
                    child: Icon(
                      CustomFilledIcons.fi_sr_time_check,
                      size: 150,
                      color: Colors.white54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 40),
                        Text(
                          "All Done",
                          style: TextStyle(
                            color: Colors.brown,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Reserveration is done and we've it in our registers.",
                          style: TextStyle(
                            color: Colors.brown.shade300,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
