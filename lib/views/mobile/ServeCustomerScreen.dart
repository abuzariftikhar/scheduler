import 'package:flutter/material.dart';
import 'package:scheduler/widgets/ForHome.dart';

import 'ScanQrScreen.dart';

class ServeCustomerScreen extends StatefulWidget {
  @override
  _ServeCustomerScreenState createState() => _ServeCustomerScreenState();
}

class _ServeCustomerScreenState extends State<ServeCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            pinned: true,
            leadingWidth: 60,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(80)),
                child: Text("Serve Customer", style: TextStyle(color: Colors.black),),
              ),
              collapseMode: CollapseMode.parallax,
              background: Image.asset(
                'assets/serve_customer_bg.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SingleImageBanner(
              title: "Scan QR code &\nServe Customer",
              description:
                  'Quickly serve walking\ncustomer and add the\nreservation to the system.',
              imageURL: 'assets/qr_banner.png',
              routeto: ScanScreen(),
              buttonTitle: 'Scan now',
            ),
          ),
        ],
      ),
    );
  }
}
