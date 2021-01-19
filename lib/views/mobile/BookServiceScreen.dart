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
            expandedHeight: 150,
            pinned: true,
            leadingWidth: 60,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text("App Demo"),
              collapseMode: CollapseMode.parallax,
              background: Image.asset(
                'assets/order_bg.png',
                fit: BoxFit.contain,
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
