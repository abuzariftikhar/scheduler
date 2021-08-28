import 'package:flutter/material.dart';

class SpalshPage extends StatefulWidget {
  const SpalshPage({Key? key}) : super(key: key);
  static const String route = "SplashPage";
  @override
  _SpalshPageState createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  @override
  void initState() {
    // Future.delayed(
    //   Duration(milliseconds: 2000),
    //   () {
    //     Navigator.pushReplacementNamed(context, ConsumerHomePage.route);
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
