import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';

class ServiceDetailsScreen extends StatefulWidget {
  final String heroTag;
  final ServiceItem serviceModel;

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
                child: Consumer<CartBloc>(builder: (context, value, _) {
                  return GestureDetector(
                    onTap: () {
                      String message = value.addtocart(widget.serviceModel);
                      Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey.shade200,
                        textColor: Colors.grey.shade600,
                      );
                      print(value.cartItems.length);
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width / 2,
                          margin: EdgeInsets.all(20.0),
                          child: Material(
                            elevation: 5,
                            color: Colors.blueAccent,
                            shape: SquircleBorder(radius: 40),
                            child: Center(
                              child: Text(
                                "Add to Booking List",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
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
