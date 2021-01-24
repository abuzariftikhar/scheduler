import 'dart:ui';

import 'package:flutter/material.dart';

class BookServiceScreen extends StatefulWidget {
  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            stretch: true,
            backgroundColor: Colors.white,
            expandedHeight: 180,
            pinned: true,
            elevation: 1,
            leading: CloseButton(
              color: Colors.grey,
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: ClipRRect(
                borderRadius: BorderRadius.circular(80),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(80),
                    ),
                    child: Text(
                      "Book Services",
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
                'assets/booking-bg.jpg',
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1000,
            ),
          )
        ],
      ),
    );
  }
}
