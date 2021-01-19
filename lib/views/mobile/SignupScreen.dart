import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scheduler/views/mobile/SigninScreen.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final FocusNode _nameFocus = FocusNode();
    final FocusNode _emailFocus = FocusNode();
    final FocusNode _passwordFocus = FocusNode();
    bool obscureText = true;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
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
                AnimatedContainer(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  alignment: Alignment.center,
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: TextField(
                    focusNode: _nameFocus,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      focusColor: Colors.blue,
                      labelText: 'Full Name',
                      hintText: 'John Doe',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  alignment: Alignment.center,
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.blueGrey.shade50,
                    shape: SquircleBorder(radius: 30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        focusNode: _emailFocus,
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'example@domain.com',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                  alignment: Alignment.center,
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    color: Colors.blueGrey.shade50,
                    shape: SquircleBorder(radius: 30),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        focusNode: _passwordFocus,
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.go,
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'More than 6 characters',
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
                        child: CupertinoButton.filled(
                          child: Text('Sign up'),
                          onPressed: () async {
                            Fluttertoast.showToast(
                              msg: "message",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade200,
                              textColor: Colors.grey.shade600,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
