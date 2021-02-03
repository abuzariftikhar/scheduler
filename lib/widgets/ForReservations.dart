import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/for_admin/AppointmentsBloc.dart';

class HeaderTile extends StatefulWidget {
  final int index;
  final String title;

  const HeaderTile({
    Key key,
    @required this.index,
    @required this.title,
  }) : super(key: key);
  @override
  _HeaderTileState createState() => _HeaderTileState();
}

class _HeaderTileState extends State<HeaderTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsBloc>(
        builder: (context, snapshot, childWidget) {
      return GestureDetector(
        onTap: () {
          snapshot.index = widget.index;
          snapshot.update();
        },
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: widget.index == snapshot.index
                ? Colors.blueAccent
                : Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
          ),
          child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: widget.index == snapshot.index
                    ? Colors.white
                    : Colors.grey.shade600,
              ),
              child: Text(widget.title)),
        ),
      );
    });
  }
}

class AppointmentTile extends StatefulWidget {
  final String title;
  final String type;
  final String dateTime;
  final Color color;
  final String status;

  const AppointmentTile({
    Key key,
    @required this.color,
    @required this.title,
    @required this.type,
    @required this.status,
    @required this.dateTime,
  }) : super(key: key);

  @override
  _AppointmentTileState createState() => _AppointmentTileState();
}

class _AppointmentTileState extends State<AppointmentTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            width: 110,
            child: Container(
              margin: EdgeInsets.all(5),
              child: Material(
                shape: SquircleBorder(radius: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: getStatusColor(widget.status).shade100,
                      ),
                      child: Text(
                        widget.status,
                        style: TextStyle(
                          color: getStatusColor(widget.status),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.black26,
                    ),
                    Text(
                      'Starts at',
                      style: TextStyle(color: Colors.black87),
                    ),
                    Text(
                      '10:30 AM',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      height: 5,
                      endIndent: 10,
                      indent: 10,
                    ),
                    Text(
                      'Ends at',
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      '11:30 AM',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, right: 10),
            height: 130,
            width: MediaQuery.of(context).size.width - 135,
            child: Material(
              shape: SquircleBorder(radius: 30),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.type,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.more_vert,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                  Divider(color: Colors.black26),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 5),
                          height: 75,
                          width: 75,
                          child: Material(
                            clipBehavior: Clip.antiAlias,
                            color: Colors.blueGrey.shade50,
                            shape: SquircleBorder(radius: 30),
                            child: Image.asset('assets/avatar.png'),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.person_outline,
                                  color: Colors.black,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.cleaning_services_rounded,
                                  color: Colors.black,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.type,
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: 12,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Male - 28 Years',
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  MaterialColor getStatusColor(String status) {
    switch (status) {
      case 'Served':
        return Colors.green;
        break;
      case 'Cancelled':
        return Colors.red;
        break;
      case 'Checked-in':
        return Colors.blue;
      case 'Served':
        return Colors.green;
        break;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.white;
    }
  }
}

class DateTile extends StatefulWidget {
  final int day;
  const DateTile({
    Key key,
    @required this.day,
  }) : super(key: key);
  @override
  _DateTileState createState() => _DateTileState();
}

class _DateTileState extends State<DateTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentsBloc>(
        builder: (context, snapshot, childWidget) {
      return GestureDetector(
        onTap: () {
          snapshot.day = widget.day - 1;
          snapshot.update();
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          alignment: Alignment.center,
          height: 60,
          width: 50,
          decoration: BoxDecoration(
              color: widget.day - 1 == snapshot.day
                  ? Colors.blueAccent
                  : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(80)),
          child: AnimatedDefaultTextStyle(
            duration: Duration(milliseconds: 200),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.day - 1 == snapshot.day
                  ? Colors.white
                  : Colors.grey.shade800,
            ),
            child: Text(widget.day.toString()),
          ),
        ),
      );
    });
  }
}

class CompletedTile extends StatefulWidget {
  final String customerName;
  final String type;

  const CompletedTile({
    Key key,
    @required this.customerName,
    @required this.type,
  }) : super(key: key);

  @override
  _CompletedTileState createState() => _CompletedTileState();
}

class _CompletedTileState extends State<CompletedTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      height: 165,
      child: Column(
        children: [
          Container(
            height: 40,
            color: Colors.blue.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wysiwyg_rounded, size: 16),
                SizedBox(
                  width: 5,
                ),
                Text(
                  widget.type,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${widget.customerName}',
                ),
                SizedBox(
                  height: 2,
                ),
                Row(
                  children: [
                    Text('Rating: '),
                    Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                    ),
                    Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                    ),
                    Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                    ),
                    Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                    ),
                    Icon(
                      Icons.star_rate_rounded,
                      size: 16,
                    ),
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Charged: \$35.99 + tax',
                ),
                Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text('Modify'),
                      ),
                    ),
                    Container(
                      color: Colors.black12,
                      width: 1,
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Text('Remove'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
