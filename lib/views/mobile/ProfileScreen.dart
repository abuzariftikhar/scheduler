import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/AuthenticationBloc.dart';
import 'package:scheduler/widgets/custom_filled_icons_icons.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.grey,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.grey.shade700),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Hero(
                tag: "profilePic",
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90.0),
                    color: Colors.grey.shade100,
                  ),
                  child: Image.asset(
                    "assets/avatar.png",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Consumer<AuthenticationBloc>(builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    "Hi, ${value.auth.currentUser.displayName}",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              }),
              Divider(height: 8),
              InkWell(
                splashColor: Colors.grey.shade100,
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 200),
                          reverseTransitionDuration:
                              Duration(milliseconds: 200),
                          pageBuilder: (context, animation, animation2) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                      begin: Offset(1, 0), end: Offset(0, 0))
                                  .chain(CurveTween(curve: Curves.easeOutCirc))
                                  .animate(animation),
                              child: ProfileInfoScreen(),
                            );
                          }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.0),
                              color: Colors.blueGrey.shade50,
                            ),
                            child: Icon(
                              CustomIcons.fi_rr_portrait,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Change profile info",
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 8),
              InkWell(
                splashColor: Colors.grey.shade100,
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.0),
                              color: Colors.blueGrey.shade50,
                            ),
                            child: Icon(
                              CustomIcons.fi_rr_share,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Share this app",
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 8),
              InkWell(
                splashColor: Colors.grey.shade100,
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 200),
                          reverseTransitionDuration:
                              Duration(milliseconds: 200),
                          pageBuilder: (context, animation, animation2) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                      begin: Offset(1, 0), end: Offset(0, 0))
                                  .chain(CurveTween(curve: Curves.easeOutCirc))
                                  .animate(animation),
                              child: PrivacyPolicyScreen(),
                            );
                          }));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.0),
                              color: Colors.blueGrey.shade50,
                            ),
                            child: Icon(
                              CustomIcons.fi_rr_briefcase,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 8),
              InkWell(
                splashColor: Colors.grey.shade100,
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.0),
                              color: Colors.blueGrey.shade50,
                            ),
                            child: Icon(
                              CustomIcons.fi_rr_shop,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "About Store",
                            style: TextStyle(
                              color: Colors.blueGrey.shade700,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 8),
              InkWell(
                splashColor: Colors.grey.shade100,
                onTap: () {},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.0),
                              color: Colors.red.shade50,
                            ),
                            child: Icon(
                              CustomIcons.fi_rr_sign_out,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.blueGrey,
                      )
                    ],
                  ),
                ),
              ),
              Divider(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileInfoScreen extends StatefulWidget {
  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            stretch: true,
            expandedHeight: 160,
            elevation: 1,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(1.2, 2),
                      child: Icon(
                        CustomFilledIcons.fi_sr_portrait,
                        size: 150,
                        color: Colors.black12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            "Change",
                            style: TextStyle(
                                color: Colors.white60,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Personal Info",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Modify or update your personal information.",
                            style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 50)),
          SliverToBoxAdapter(
            child: InkWell(
              splashColor: Colors.grey.shade100,
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            color: Colors.blueGrey.shade50,
                          ),
                          child: Icon(
                            CustomIcons.fi_rr_letter_case,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Full name",
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Consumer<AuthenticationBloc>(builder: (context, value, _) {
                      return Text(
                        value.auth.currentUser.displayName,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              splashColor: Colors.grey.shade100,
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            color: Colors.blueGrey.shade50,
                          ),
                          child: Icon(
                            Icons.email_outlined,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Consumer<AuthenticationBloc>(builder: (context, value, _) {
                      return Text(
                        value.auth.currentUser.email,
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              splashColor: Colors.grey.shade100,
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            color: Colors.blueGrey.shade50,
                          ),
                          child: Icon(
                            CustomIcons.fi_rr_badge,
                            size: 18,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Verification status",
                          style: TextStyle(
                            color: Colors.blueGrey.shade700,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Consumer<AuthenticationBloc>(builder: (context, value, _) {
                      return Text(
                        value.auth.currentUser.emailVerified
                            ? "verified"
                            : "Not verified",
                        style: TextStyle(
                          color: Colors.blue.shade700,
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            stretch: true,
            expandedHeight: 160,
            elevation: 1,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 160,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(1.2, 2),
                      child: Icon(
                        CustomFilledIcons.fi_sr_briefcase,
                        size: 150,
                        color: Colors.black12,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "See How your email and other info are handled.",
                            style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
