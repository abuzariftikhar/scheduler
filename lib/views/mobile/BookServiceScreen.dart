import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/BookingScreenBloc.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/services/payment_methods/PaypalPayment.dart';
import 'package:scheduler/views/mobile/LandingScreen.dart';
import 'package:scheduler/widgets/custom_filled_icons_icons.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

import 'QuickEntryScreen.dart';

class BookServiceScreen extends StatefulWidget {
  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String? date;

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

  // Future<bool> _onBackPressed(BuildContext context) {
  //   return showDialog(
  //       barrierColor: Colors.blueGrey.withOpacity(0.95),
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Row(
  //             children: [
  //               Icon(
  //                 CustomFilledIcons.fi_sr_exclamation,
  //                 size: 18,
  //                 color: Colors.orange,
  //               ),
  //               SizedBox(width: 5),
  //               Text('Exit'),
  //             ],
  //           ),
  //           content: Text("Do you wish to cancel booking?"),
  //           actions: <Widget>[
  //             TextButton(
  //                 child: Text('NO'),
  //                 onPressed: () => Navigator.pop(context, false)),
  //             TextButton(
  //                 child: Text('Yes'),
  //                 onPressed: () => Navigator.pop(context, true))
  //           ],
  //         );
  //       });
  // }

  void initState() {
    date = formatter.format(DateTime.now());
    Provider.of<BookingScreenBloc>(context, listen: false).reset();
    Provider.of<BookingScreenBloc>(context, listen: false).makeTimeSlots();
    // Provider.of<CartBloc>(context, listen: false).loadReservedHours(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Consumer<BookingScreenBloc>(builder: (context, value, _) {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 400),
                  reverseDuration: Duration(milliseconds: 10),
                  transitionBuilder: (child, animation) => SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(
                                  value.widgetIndex > value.previousIndex
                                      ? 1
                                      : -1,
                                  0,
                                ),
                                end: Offset(0, 0))
                            .chain(CurveTween(curve: Curves.easeOutCirc))
                            .animate(animation),
                        child: child,
                      ),
                  child: _getBookingScreen(value.widgetIndex));
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
  final VoidCallback onTap;

  const SlotTile({
    Key? key,
    required this.from,
    required this.to,
    required this.index,
    required this.isReserved,
    required this.onTap,
  }) : super(key: key);

  @override
  _SlotTileState createState() => _SlotTileState();
}

class _SlotTileState extends State<SlotTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingScreenBloc>(builder: (context, value, _) {
      return GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: value.currentTimelineSelection.contains(widget.index)
                ? Colors.blueAccent
                : value.occupiedTimeline.contains(widget.index)
                    ? Colors.blueGrey.shade100
                    : Colors.grey.shade100,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                width: 4,
                color: Colors.black,
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    widget.to,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          value.currentTimelineSelection.contains(widget.index)
                              ? Colors.white
                              : value.occupiedTimeline.contains(widget.index)
                                  ? Colors.blueGrey
                                  : Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    widget.to,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          value.currentTimelineSelection.contains(widget.index)
                              ? Colors.white
                              : value.occupiedTimeline.contains(widget.index)
                                  ? Colors.blueGrey
                                  : Colors.black,
                    ),
                  ),
                ],
              ),
              Text(
                value.occupiedTimeline.contains(widget.index)
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
                    color: Colors.blueAccent,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.2, 2),
                        child: Icon(
                          CustomFilledIcons.fi_sr_notebook,
                          size: 150,
                          color: Colors.white30,
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
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Let's get your reservation ready.",
                              style: TextStyle(
                                color: Colors.white70,
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
        Consumer<BookingScreenBloc>(builder: (context, value, _) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Button2(
                    onTap: () {
                      if (Provider.of<CartBloc>(context).cartItems.isNotEmpty) {
                        value.previousIndex = value.widgetIndex;
                        value.widgetIndex++;
                        value.update();
                      } else {
                        Flushbar(
                          title: "Cart Empty",
                          message: "Add items to cart to continue.",
                          duration: Duration(seconds: 3),
                          animationDuration: Duration(milliseconds: 300),
                          isDismissible: true,
                          flushbarPosition: FlushbarPosition.TOP,
                          icon: Icon(
                            Icons.warning,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                          shouldIconPulse: true,
                        )..show(context);
                      }
                    },
                    title: "Next",
                    titleColor: Colors.white,
                    iconData: Icons.arrow_forward_rounded,
                    backgroundColor:
                        Provider.of<CartBloc>(context).cartItems.isNotEmpty
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
  String? date;

  @override
  void initState() {
    date = formatter.format(DateTime.now());
    super.initState();
  }

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
                    color: Colors.blueAccent,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.2, 2),
                        child: Icon(
                          CustomFilledIcons.fi_sr_time_check,
                          size: 150,
                          color: Colors.white30,
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
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "When can you come to the shop?",
                              style: TextStyle(
                                color: Colors.white70,
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
                        "You need ${value.durationToString(value.totalSlotsRequired * 15)}",
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
                                color: Colors.blueAccent,
                                shape: SquircleBorder(
                                  radius: BorderRadius.circular(30),
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
                            Text(
                              "Choose a date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          height: 60.0,
                          width: MediaQuery.of(context).size.width / 2.2,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height /
                                          3,
                                      child: CupertinoDatePicker(
                                        onDateTimeChanged: (newdate) {
                                          setState(() {
                                            date = formatter.format(newdate);
                                          });
                                        },
                                        use24hFormat: false,
                                        minimumDate: DateTime.now(),
                                        initialDateTime: DateTime.now(),
                                        maximumDate: DateTime.now()
                                            .add(Duration(days: 365)),
                                        mode: CupertinoDatePickerMode.date,
                                      ));
                                },
                              );
                            },
                            child: Material(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.blueGrey.shade50,
                              shape: SquircleBorder(
                                radius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Text(
                                    date!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
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
                    ),
                    Text(
                      "Each of time slot is of 15 minutes. You can choose from the available slots that suits your needs.",
                    ),
                  ],
                ),
              ),
            ),
            Consumer<BookingScreenBloc>(builder: (context, value, _) {
              return SliverPadding(
                padding: EdgeInsets.all(20),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final hourFrom = value.totalTimeSlots.sublist(
                          value.shopOpeningTimeIndex,
                          value.shopClosingTimeIndex)[index];
                      final hourTo = value.totalTimeSlots.sublist(
                          value.shopOpeningTimeIndex,
                          value.shopClosingTimeIndex)[index + 1];
                      return SlotTile(
                        index: index + value.shopOpeningTimeIndex,
                        from: hourFrom.format(context),
                        to: hourTo.format(context),
                        isReserved: false,
                        onTap: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          List<int> _selection = [];
                          _selection.clear();
                          for (var i = 0; i < value.totalSlotsRequired; i++) {
                            _selection
                                .add(index + i + value.shopOpeningTimeIndex);
                          }
                          if (index +
                                      value.shopOpeningTimeIndex +
                                      value.totalSlotsRequired <
                                  value.totalTimeSlots.length - 4 &&
                              !_selection.any((element) {
                                return value.occupiedTimeline.contains(element);
                              })) {
                            value.currentTimelineSelection = _selection;
                            value.update();
                            print(value.currentTimelineSelection);
                          } else {
                            bool result = index +
                                    40 +
                                    value.totalSlotsRequired >
                                value.totalTimeSlots.sublist(40, 92).length +
                                    40;
                            Flushbar(
                              title: "Please Choose some other slot",
                              message: result
                                  ? "Shop might be closed before we can serve you."
                                  : "We might be serving someone else in this time.",
                              duration: Duration(seconds: 3),
                              animationDuration: Duration(milliseconds: 300),
                              isDismissible: true,
                              flushbarPosition: FlushbarPosition.TOP,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              icon: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Icon(
                                  result ? Icons.warning : Icons.done,
                                ),
                              ),
                              shouldIconPulse: true,
                            )..show(context);
                          }
                        },
                      );
                    },
                    childCount: value.totalTimeSlots
                        .sublist(value.shopOpeningTimeIndex,
                            value.shopClosingTimeIndex)
                        .length,
                    addAutomaticKeepAlives: true,
                  ),
                ),
              );
            }),
            SliverToBoxAdapter(
              child: SizedBox(height: 100),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Consumer<BookingScreenBloc>(builder: (context, value, _) {
                return Row(
                  children: [
                    Button1(
                      onTap: () {
                        value.previousIndex = value.widgetIndex;
                        value.widgetIndex--;
                        value.update();
                      },
                      title: "Back",
                      titleColor: Colors.white,
                      iconData: Icons.arrow_back_rounded,
                      backgroundColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 12),
                    Button2(
                      onTap: () {
                        if (value.currentTimelineSelection.isNotEmpty) {
                          value.previousIndex = value.widgetIndex;
                          value.widgetIndex++;
                          value.update();
                        } else {
                          Flushbar(
                            title: "No time slot selected!",
                            message:
                                "Please Choose some other slot a time slot to proceed with booking process.",
                            duration: Duration(seconds: 3),
                            animationDuration: Duration(milliseconds: 300),
                            isDismissible: true,
                            flushbarPosition: FlushbarPosition.TOP,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            icon: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.timer_outlined),
                            ),
                            shouldIconPulse: true,
                          )..show(context);
                        }
                      },
                      title: "Next",
                      titleColor: Colors.white,
                      iconData: Icons.arrow_forward_rounded,
                      backgroundColor: value.currentTimelineSelection.isNotEmpty
                          ? Colors.blueAccent
                          : Colors.grey.shade300,
                    ),
                  ],
                );
              }),
            ),
          ),
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
                    color: Colors.blueAccent,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.2, 2),
                        child: Icon(
                          CustomFilledIcons.fi_sr_time_check,
                          size: 150,
                          color: Colors.white30,
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
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "How would you like pay for the services?",
                              style: TextStyle(
                                color: Colors.white70,
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
            Consumer<BookingScreenBloc>(builder: (context, value, _) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          PaymentButton(
                            index: 0,
                            title: "Cash at shop",
                            titleColor: Colors.white,
                            iconData: FontAwesomeIcons.dollarSign,
                            backgroundColor: Colors.blueAccent,
                            onTap: () {
                              value.paymentIndex = 0;
                              value.update();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          PaymentButton(
                            index: 1,
                            title: "Stripe",
                            titleColor: Colors.white,
                            iconData: FontAwesomeIcons.stripeS,
                            backgroundColor: Colors.blueAccent,
                            onTap: () {
                              value.paymentIndex = 1;
                              value.widgetIndex++;
                              value.update();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          PaymentButton(
                            index: 2,
                            title: "Paypal",
                            titleColor: Colors.white,
                            iconData: FontAwesomeIcons.paypal,
                            backgroundColor: Colors.blueAccent,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      PaypalPayment(
                                    onFinish: (number) async {
                                      // payment done
                                      // showSimpleNotification(
                                      //   Text(
                                      //     "Payment via Paypal is successful.",
                                      //   ),
                                      //   background: Colors.green,
                                      // );
                                      value.paymentIndex = 1;
                                      value.widgetIndex++;
                                      value.update();

                                      print('order id: ' + number);
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Consumer<BookingScreenBloc>(builder: (context, value, _) {
                return Row(
                  children: [
                    Button1(
                      onTap: () {
                        value.previousIndex = value.widgetIndex;
                        value.widgetIndex--;
                        value.update();
                      },
                      title: "Back",
                      titleColor: Colors.white,
                      iconData: Icons.arrow_back_rounded,
                      backgroundColor: Colors.blueAccent,
                    ),
                    SizedBox(width: 12),
                    Button2(
                      onTap: () {
                        if (value.currentTimelineSelection.isNotEmpty) {
                          value.previousIndex = value.widgetIndex;
                          value.widgetIndex++;
                          value.update();
                        } else {
                          // showSimpleNotification(
                          //   Text(
                          //     "Please choose a time slot to continue the booking process!",
                          //   ),
                          //   background: Colors.amber.shade900,
                          //   duration: Duration(seconds: 3),
                          // );
                        }
                      },
                      title: "Next",
                      titleColor: Colors.white,
                      iconData: Icons.arrow_forward_rounded,
                      backgroundColor: value.currentTimelineSelection.isNotEmpty
                          ? Colors.blueAccent
                          : Colors.grey.shade300,
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}

class BookingSuccessScreen extends StatefulWidget {
  @override
  _BookingSuccessScreenState createState() => _BookingSuccessScreenState();
}

class _BookingSuccessScreenState extends State<BookingSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.2, 2),
                        child: Icon(
                          CustomFilledIcons.fi_sr_trophy,
                          size: 150,
                          color: Colors.white30,
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
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Reserveration is done and we have it in our registers.",
                              style: TextStyle(
                                color: Colors.white70,
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
              child: Container(
                height: 500,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Lottie.asset(
                        "assets/lotte_animations/done.json",
                        controller: _controller,
                        onLoaded: (composition) {
                          // Configure the AnimationController with the duration of the
                          // Lottie file and start the animation.
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                    ),
                    Text(
                      "Service reservation is successful",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Button1(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  title: "Navigate to Home",
                  titleColor: Colors.white,
                  iconData: CustomIcons.fi_rr_home,
                  backgroundColor: Colors.blueAccent,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
