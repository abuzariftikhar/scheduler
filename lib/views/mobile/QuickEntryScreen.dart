import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';

class QuickEntryScreen extends StatefulWidget {
  @override
  _QuickEntryScreenState createState() => _QuickEntryScreenState();
}

class _QuickEntryScreenState extends State<QuickEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 180,
            stretch: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Text(
                      "Quick Entry",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ),
              collapseMode: CollapseMode.parallax,
              background: Image.asset(
                'assets/serve_customer_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // SliverToBoxAdapter(
          //   child: SingleImageBanner(
          //     title: "Scan QR code &\nServe Customer",
          //     description:
          //         'Quickly serve walking\ncustomer and add the\nreservation to the system.',
          //     imageURL: 'assets/qr_banner.png',
          //     routeto: ScanScreen(),
          //     buttonTitle: 'Scan now',
          //   ),
          // ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text(
                "Service List",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
          ),

          Consumer<CartBloc>(builder: (context, value, _) {
            return SliverList(
              delegate: SliverChildListDelegate(value.cartItems.map((e) {
                return QuickServiceTile(serviceItem: e);
              }).toList()),
            );
          }),
        ],
      ),
    );
  }
}

class QuickServiceTile extends StatefulWidget {
  final ServiceItem serviceItem;

  const QuickServiceTile({
    Key? key,
    required this.serviceItem,
  }) : super(key: key);
  @override
  _QuickServiceTileState createState() => _QuickServiceTileState();
}

class _QuickServiceTileState extends State<QuickServiceTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Consumer<CartBloc>(builder: (context, value, _) {
        return Material(
          elevation: 10,
          shadowColor: Colors.blueGrey.shade50.withOpacity(0.5),
          shape: SquircleBorder(
            radius: BorderRadius.circular(20),
          ),
          color: Colors.grey.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: Text(
                            widget.serviceItem.name,
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      value.durationToString(widget.serviceItem.timeRequired),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "\$${widget.serviceItem.cost}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(width: 5),
                    IconButton(
                      splashRadius: 10,
                      icon: Icon(
                        Icons.close,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        value.removeFromCart(widget.serviceItem);
                        // showSimpleNotification(
                        //   Text("${widget.serviceItem.name} removed from cart."),
                        // );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
