import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/AuthenticationBloc.dart';
import 'package:scheduler/views/mobile/SigninScreen.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

import 'HomeScreen.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final FocusNode _nameFocus = FocusNode();
    final FocusNode _emailFocus = FocusNode();
    final FocusNode _passwordFocus = FocusNode();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account  "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignIn(),
                              ));
                        },
                        child: Text(
                          "Sign in now",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IgnorePointer(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 35, bottom: 5),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IgnorePointer(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 35, bottom: 10, right: 35),
                    child: Text(
                      "Let's get started. Please provide following info and start using scheduler.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.blueGrey.shade50,
                    shape: SquircleBorder(
                      radius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        focusNode: _nameFocus,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CustomIcons.fi_rr_id_badge),
                          focusColor: Colors.blue,
                          hintText: 'Full Name',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.blueGrey.shade50,
                    shape: SquircleBorder(
                      radius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: TextField(
                        focusNode: _emailFocus,
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CustomIcons.fi_rr_portrait),
                          hintText: 'Email',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.blueGrey.shade50,
                    shape: SquircleBorder(
                      radius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: TextField(
                        focusNode: _passwordFocus,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.go,
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CustomIcons.fi_rr_lock),
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Consumer<AuthenticationBloc>(
                            builder: (context, value, _) {
                          return CupertinoButton.filled(
                            child: Text('Sign up'),
                            onPressed: () async {
                              bool successful =
                                  await value.registerWithEmailAndPassword(
                                emailController.text,
                                passwordController.text,
                                nameController.text,
                              );
                              if (successful) {
                                Navigator.pushReplacement(context,
                                    PageRouteBuilder(pageBuilder:
                                        (context, animation, animation2) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: HomeScreen(
                                      adminMode: false,
                                    ),
                                  );
                                }));
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Consumer<AuthenticationBloc>(builder: (context, value, _) {
              if (value.isBusy) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white24,
                  child: Center(child: CircularProgressIndicator()),
                );
              } else {
                return Container();
              }
            }),
          ],
        ));
  }
}
