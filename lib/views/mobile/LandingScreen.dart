import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/widgets/custom_filled_icons_icons.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

import 'SigninScreen.dart';
import 'SignupScreen.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    animation = Tween<double>(begin: 1.5, end: 1)
        .chain(CurveTween(curve: Curves.easeInOutCirc))
        .animate(controller);
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, snapshot) {
          return Transform.scale(
            scale: animation.value,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/landing_bg.jpg',
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.cover,
                      )),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 150),
                        Material(
                          elevation: 5,
                          clipBehavior: Clip.antiAlias,
                          shape: SquircleBorder(radius: 50),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Colors.blueAccent.shade100,
                                Colors.blueAccent
                              ], begin: Alignment.topCenter),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Icon(
                              CustomFilledIcons.fi_sr_barber_shop,
                              color: Colors.white70,
                              size: 64,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Scheduler",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRect(
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        color: Colors.white70,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Button1(
                                    title: 'Sign in',
                                    titleColor: Colors.white,
                                    iconData: CustomIcons.fi_rr_sign_in,
                                    backgroundColor: Colors.black,
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          PageRouteBuilder(pageBuilder:
                                              (context, aniamtion, animtion2) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: SignIn(),
                                        );
                                      }));
                                    },
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Button1(
                                    title: 'Sign up',
                                    titleColor: Colors.white,
                                    iconData: CustomIcons.fi_rr_mobile,
                                    backgroundColor: Colors.blueGrey.shade700,
                                    onTap: () {
                                      Navigator.pushReplacement(context,
                                          PageRouteBuilder(pageBuilder:
                                              (context, aniamtion, animtion2) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: SignUp(),
                                        );
                                      }));
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Button1(
                                    title: 'Continue as Guest user',
                                    titleColor: Colors.blueGrey,
                                    iconData: CustomIcons.fi_rr_rocket,
                                    iconColor: Colors.blueGrey,
                                    backgroundColor: Colors.grey.shade200,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class Button1 extends StatefulWidget {
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final VoidCallback onTap;
  final IconData iconData;
  final Color iconColor;
  const Button1({
    Key key,
    @required this.title,
    @required this.titleColor,
    @required this.iconData,
    @required this.backgroundColor,
    this.iconColor = Colors.white,
    this.onTap,
  }) : super(key: key);
  @override
  _Button1State createState() => _Button1State();
}

class _Button1State extends State<Button1> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) {
          setState(() {
            pressed = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            pressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            pressed = false;
          });
        },
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: SquircleBorder(radius: 20),
          child: AnimatedContainer(
            padding: EdgeInsets.all(10),
            height: 60,
            duration: Duration(milliseconds: 300),
          
            decoration: BoxDecoration(
              color: pressed
                  ? widget.backgroundColor.withOpacity(0.5)
                  : widget.backgroundColor,
            ),
            curve: Curves.ease,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.iconData,
                  color: widget.iconColor,
                ),
                SizedBox(width: 10),
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

class Button2 extends StatefulWidget {
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final VoidCallback onTap;
  final IconData iconData;
  final Color iconColor;
  const Button2({
    Key key,
    @required this.title,
    @required this.titleColor,
    @required this.iconData,
    @required this.backgroundColor,
    this.iconColor = Colors.white,
    this.onTap,
  }) : super(key: key);
  @override
  _Button2State createState() => _Button2State();
}

class _Button2State extends State<Button2> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (details) {
          setState(() {
            pressed = true;
          });
        },
        onTapUp: (details) {
          setState(() {
            pressed = false;
          });
        },
        onTapCancel: () {
          setState(() {
            pressed = false;
          });
        },
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: SquircleBorder(radius: 20),
          child: AnimatedContainer(
            padding: EdgeInsets.all(10),
            height: 60,
            duration: Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color: pressed
                  ? widget.backgroundColor.withOpacity(0.5)
                  : widget.backgroundColor,
            ),
            curve: Curves.ease,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: widget.titleColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  widget.iconData,
                  color: widget.iconColor,
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
