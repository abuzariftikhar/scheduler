import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/ReservationsBloc.dart';
import 'package:scheduler/widgets/ForReservations.dart';

class ReservationsScreen extends StatefulWidget {
  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentsBloc(),
      child:
          Consumer<AppointmentsBloc>(builder: (context, snapshot, childWidget) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 60,
            title: Text(
              'Reservations',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            leading: BackButton(
              color: Colors.grey.shade700,
            ),
            centerTitle: true,
            elevation: 1,
            bottom: PreferredSize(
              preferredSize: Size(double.maxFinite, 40),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    HeaderTile(index: 0, title: 'Today'),
                    SizedBox(
                      width: 8,
                    ),
                    HeaderTile(index: 1, title: 'Upcoming'),
                    SizedBox(
                      width: 8,
                    ),
                    HeaderTile(index: 2, title: 'Completed'),
                    SizedBox(
                      width: 8,
                    ),
                    HeaderTile(index: 3, title: 'Cancelled'),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: AnimatedSwitcher(
            child: _getwidget(snapshot.index),
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.decelerate,
            reverseDuration: Duration(milliseconds: 1),
            transitionBuilder: (child, animation) {
              return ScaleTransition(
                child: child,
                scale: Tween<double>(begin: 1.05, end: 1.0).animate(animation),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _getwidget(int index) {
    Widget _widget;
    if (index == 0) {
      _widget = TodayView();
    }
    if (index == 1) {
      _widget = UpcomingView();
    }
    if (index == 2) {
      _widget = CompletedView();
    }
    if (index == 3) {
      _widget = CancelledView();
    }
    return _widget;
  }
}

class TodayView extends StatefulWidget {
  @override
  _TodayViewState createState() => _TodayViewState();
}

class _TodayViewState extends State<TodayView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsBloc>(
        builder: (context, snapshot, childWidget) {
      return RefreshIndicator(
        backgroundColor: Colors.white,
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 3), () {
            snapshot.update();
          });
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 2,
              title: Text(
                '15 Reservation Today',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 15,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(snapshot.listOfSchedule
                  .map<AppointmentTile>(
                    (e) => AppointmentTile(
                      status: e.status,
                      color: Colors.white,
                      title: e.customerName,
                      type: e.listOfType.map((e) => e.typeName).join(', '),
                      dateTime: '20-11-2020',
                    ),
                  )
                  .toList()),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 30),
            )
          ],
        ),
      );
    });
  }
}

class UpcomingView extends StatefulWidget {
  @override
  _UpcomingViewState createState() => _UpcomingViewState();
}

class _UpcomingViewState extends State<UpcomingView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsBloc>(
        builder: (context, snapshot, childWidget) {
      return Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  floating: true,
                  snap: true,
                  elevation: 1,
                  title: Text(
                    'November, 2020',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 31,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 10 : 0),
                            child: DateTile(
                              day: index + 1,
                            ),
                          );
                        },
                      ),
                    ),
                    preferredSize: Size(MediaQuery.of(context).size.width, 70),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '8 Reservations',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'November, ${(snapshot.day + 1).toString()} - 2020',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(snapshot.listOfSchedule
                      .map<AppointmentTile>(
                        (e) => AppointmentTile(
                          status: e.status,
                          color: Colors.white,
                          title: e.customerName,
                          type: e.listOfType.map((e) => e.typeName).join(', '),
                          dateTime: '20-11-2020',
                        ),
                      )
                      .toList()),
                )
              ],
            ),
          ),
        ],
      );
    });
  }
}

class CompletedView extends StatefulWidget {
  @override
  _CompletedViewState createState() => _CompletedViewState();
}

class _CompletedViewState extends State<CompletedView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsBloc>(
        builder: (context, snapshot, childWidget) {
      return CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            floating: true,
            elevation: 1,
            snap: true,
            title: Text(
              '56 Customers served this month',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(snapshot.listOfSchedule
                .map<CompletedTile>(
                  (e) => CompletedTile(
                    customerName: e.customerName,
                    type: e.listOfType.map((e) => e.typeName).join(', '),
                  ),
                )
                .toList()),
          )
        ],
      );
    });
  }
}

class CancelledView extends StatefulWidget {
  @override
  _CancelledViewState createState() => _CancelledViewState();
}

class _CancelledViewState extends State<CancelledView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(200)),
            child: Image.asset('assets/nothing.png'),
          ),
          Text('Nothing to show here')
        ],
      ),
    );
  }
}
