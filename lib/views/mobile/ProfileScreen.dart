import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            backgroundColor: Colors.white,
            expandedHeight: 180,
            pinned: true,
            elevation: 1,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                  child: CloseButton(
                color: Colors.black,
              )),
            ),
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(80)),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
                collapseMode: CollapseMode.parallax,
                background: Image.asset(
                  "assets/bg_generic.png",
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                )),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 800,
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () async {
                // String message =
                //     await context.read<AuthenticationService>().signOut();
                Fluttertoast.showToast(
                  msg: "Signing out",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black87,
                  textColor: Colors.white,
                );
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(20.0),
                child: Material(
                  color: Colors.redAccent,
                  shape: SquircleBorder(radius: 30),
                  child: Center(
                    child: Text(
                      "Log out",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
