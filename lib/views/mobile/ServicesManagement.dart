import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/for_admin/ServicesManagerBloc.dart';
import 'package:scheduler/views/mobile/AddServiceForm.dart';
import 'package:scheduler/widgets/ForServiceManager.dart';
import 'package:scheduler/widgets/custom_icons_icons.dart';

class ServicesManagementScreen extends StatefulWidget {
  @override
  _ServicesManagementScreenState createState() =>
      _ServicesManagementScreenState();
}

class _ServicesManagementScreenState extends State<ServicesManagementScreen> {
  @override
  void didChangeDependencies() {
    Provider.of<ServicesManagerBloc>(context, listen: false)
        .loadAllServices("currentUser");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 60,
        actions: [
          IconButton(
            splashRadius: 20,
            padding: EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 20,
            ),
            color: Colors.black,
            icon: Icon(
              Icons.search_rounded,
            ),
            onPressed: () {},
          ),
        ],
        title: Text(
          'Reservations',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: BackButton(
          color: Colors.grey.shade700,
        ),
        centerTitle: true,
        elevation: 1,
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, 40),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Consumer<ServicesManagerBloc>(builder: (context, value, _) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  FiltersTile(
                    index: 0,
                    title: 'All Services',
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  FiltersTile(index: 1, title: "Hair Cutting"),
                  SizedBox(
                    width: 8,
                  ),
                  FiltersTile(index: 2, title: 'Hair Dying'),
                  SizedBox(
                    width: 8,
                  ),
                  FiltersTile(index: 3, title: 'Nail Treatment'),
                  SizedBox(
                    width: 20,
                  ),
                  FiltersTile(index: 4, title: 'Skin Treatment'),
                  SizedBox(
                    width: 20,
                  ),
                  FiltersTile(index: 5, title: 'Waxing Services'),
                  SizedBox(
                    width: 20,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        child: Material(
          elevation: 3,
          color: Colors.blueAccent,
          clipBehavior: Clip.antiAlias,
          shape: SquircleBorder(radius: BorderRadius.circular(40),),
          child: InkWell(
            splashColor: Colors.white24,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder:
                      (BuildContext context, animation, secondartAnimation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(0, 1),
                        end: Offset(0, 0),
                      )
                          .chain(
                            CurveTween(curve: Curves.decelerate),
                          )
                          .animate(animation),
                      child: AddServiceForm(),
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    CustomIcons.fi_rr_apps_add,
                    size: 16,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Add Service",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ServicesManagerBloc>(
        builder: (context, value, child) {
          if (!value.isLoading) {
            if (value.servicesList.isEmpty) {
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height - 200,
                width: MediaQuery.of(context).size.width,
                child: Material(
                  shape: SquircleBorder(radius: BorderRadius.circular(50),),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: Image.asset("assets/nothing.png"),
                        ),
                        Text(
                          "Nothing found here!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: Text(
                      value.servicesList.length != 1
                          ? "${value.servicesList.length} services found"
                          : "${value.servicesList.length} service found",
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(20),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(value.servicesList
                          .mapIndex(
                            (e, i) => ServiceTile(
                                serviceModel: e, heroTag: "service$i"),
                          )
                          .toList()),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      height: 60,
                    ),
                  )
                ],
              );
            }
          } else {
            return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height - 100,
              width: MediaQuery.of(context).size.width,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
