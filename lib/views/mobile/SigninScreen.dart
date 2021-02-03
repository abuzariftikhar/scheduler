import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/AuthenticationBloc.dart';
import 'package:scheduler/views/mobile/HomeScreen.dart';
import 'package:scheduler/views/mobile/SignupScreen.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

class SignIn extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
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
                    Text("Don't have an account  "),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ));
                      },
                      child: Text(
                        "Register now",
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
                    'Sign in',
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
                  padding: const EdgeInsets.only(left: 35, bottom: 10),
                  child: Text(
                    "Welcome back. Type your credentials and start using scheduler.",
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
                  shape: SquircleBorder(radius: 30),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Consumer<AuthenticationBloc>(
                        builder: (context, value, _) {
                      return TextFormField(
                        focusNode: _emailFocus,
                        controller: emailController,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (text) {
                          value.signInError = "";
                          value.update();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(CustomIcons.fi_rr_portrait),
                          hintText: 'Email',
                          border: InputBorder.none,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                width: MediaQuery.of(context).size.width,
                child: Material(
                  color: Colors.blueGrey.shade50,
                  shape: SquircleBorder(radius: 30),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Consumer<AuthenticationBloc>(
                        builder: (context, value, _) {
                      return TextFormField(
                        focusNode: _passwordFocus,
                        controller: passwordController,
                        onChanged: (text) {
                          value.signInError = "";
                          value.update();
                        },
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          prefixIcon: Icon(CustomIcons.fi_rr_lock),
                          hintText: 'Password',
                          border: InputBorder.none,
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Consumer<AuthenticationBloc>(
                builder: (context, value, _) {
                  if (value.signInError == "") {
                    return Container();
                  } else
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 10,
                      ),
                      child: Text(
                        value.signInError,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                },
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
                          child: Text('Sign in'),
                          onPressed: () async {
                            bool successful =
                                await value.signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);
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
      ),
    );
  }
}
