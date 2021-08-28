import 'package:flutter/material.dart';

class CustomerFormScreen extends StatefulWidget {
  final String? data;

  const CustomerFormScreen({Key? key, this.data}) : super(key: key);
  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
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
