import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/views/mobile/BookServiceScreen.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String heroTag;
  final ServiceModel serviceModel;

  const ServiceDetailsScreen({
    Key key,
    @required this.serviceModel,
    @required this.heroTag,
  }) : super(key: key);
  @override
  _ServiceDetailsScreenState createState() => _ServiceDetailsScreenState();
}

class _ServiceDetailsScreenState extends State<ServiceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Hero(
    tag: widget.heroTag,
    child: Material(
      color: Colors.white,
      child: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                stretch: true,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                expandedHeight: MediaQuery.of(context).size.width / 1.2,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    widget.serviceModel.imageURL,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.scaleDown,
                    height: double.maxFinite,
                    width: double.maxFinite,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    color: Colors.grey.shade900,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 130, 20),
                          child: Text(
                            widget.serviceModel.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "\$${widget.serviceModel.cost}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    widget.serviceModel.detailText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 900,
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, animation,
                        secondartAnimation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(0, 1),
                          end: Offset(0, 0),
                        )
                            .chain(
                              CurveTween(curve: Curves.easeInOutCirc),
                            )
                            .animate(animation),
                        child: BookServiceScreen(),
                      );
                    },
                  ),
                );
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20.0),
                child: Material(
                  color: Colors.blueAccent,
                  shape: SquircleBorder(radius: 30),
                  child: Center(
                    child: Text(
                      "Book a Reservation",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
              child: CircleAvatar(
                backgroundColor: Colors.black38,
                foregroundColor: Colors.white,
                child: CloseButton(),
              ),
            ),
          )
        ],
      ),
    ),
        ),
      );
  }
}
