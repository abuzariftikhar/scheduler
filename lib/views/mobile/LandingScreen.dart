import 'package:flutter/material.dart';

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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset('assets/landing.png'),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ButtonLanding(
                                title: 'Sign in',
                                titleColor: Colors.white,
                                backgroundColor: Colors.black,
                                function: () {
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
                              ButtonLanding(
                                title: 'Sign up',
                                titleColor: Colors.white,
                                backgroundColor: Colors.grey.shade800,
                                function: () {
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
                              ButtonLanding(
                                title: 'Continue as Guest user',
                                titleColor: Colors.black,
                                backgroundColor: Colors.grey.shade200,
                              ),
                            ],
                          ),
                        ],
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

class ButtonLanding extends StatefulWidget {
  final String title;
  final Color titleColor;
  final Color backgroundColor;
  final VoidCallback function;
  const ButtonLanding({
    Key key,
    @required this.title,
    @required this.titleColor,
    @required this.backgroundColor,
    this.function,
  }) : super(key: key);
  @override
  _ButtonLandingState createState() => _ButtonLandingState();
}

class _ButtonLandingState extends State<ButtonLanding> {
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: widget.function,
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
        child: AnimatedContainer(
          padding: EdgeInsets.all(10),
          height: 40,
          duration: Duration(milliseconds: 100),
          decoration: BoxDecoration(
            color: pressed
                ? widget.backgroundColor.withOpacity(0.5)
                : widget.backgroundColor,
            borderRadius: BorderRadius.circular(18),
          ),
          curve: Curves.easeInOutCirc,
          child: Center(
              child: Text(
            widget.title,
            style: TextStyle(color: widget.titleColor),
          )),
        ),
      ),
    );
  }
}
