import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/HomeBloc.dart';
import 'package:scheduler/widgets/ForHome.dart';

import 'ReservationsScreen.dart';
import 'ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  final bool adminMode;

  const HomeScreen({Key key, @required this.adminMode}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.adminMode ? AdminHome() : CustomerHome();
  }
}

class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Color(0xffededed),
        body: Consumer<HomeBloc>(builder: (context, snapshot, childWidget) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                stretch: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: IconButton(
                        splashRadius: 1,
                        icon: Icon(
                          Icons.account_circle_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (BuildContext context, animation,
                                  secondartAnimation) {
                                return SlideTransition(
                                  position: Tween<Offset>(
                                    begin: Offset(0, 1),
                                    end: Offset(0, 0),
                                  )
                                      .chain(
                                        CurveTween(curve: Curves.easeInOutCirc),
                                      )
                                      .animate(animation),
                                  child: ProfileScreen(),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
                backgroundColor: Colors.white,
                expandedHeight: 180,
                pinned: true,
                elevation: 1,
                leadingWidth: 60,
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
                          color: Colors.white38,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Text(
                          "Scheduler",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  collapseMode: CollapseMode.parallax,
                  background: Image.asset(
                    'assets/home_bg.jpg',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: SingleImageBanner(
                title: 'Appointments &\nReservations',
                description: "See all of your\nappointments &\nreservations.",
                imageURL: 'assets/homeBanner.png',
                routeto: ReservationsScreen(),
              )),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 20, top: 10),
                  child: Text(
                    'Manage Store',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 150,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [Container(width: 10)] +
                          snapshot.listItem
                              .map<Container>(
                                (item) => Container(
                                    child: HomeListTile(
                                  title: item.title,
                                  imageURL: item.imageURL,
                                  color: item.color,
                                  routeTo: item.routeTo,
                                )),
                              )
                              .toList() +
                          [
                            Container(
                              width: 10,
                            )
                          ],
                    ),
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Quick Access',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 150,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [Container(width: 10)] +
                          snapshot.listItem2
                              .map<Container>(
                                (item) => Container(
                                  child: HomeListTile(
                                    title: item.title,
                                    imageURL: item.imageURL,
                                    color: item.color,
                                    routeTo: item.routeTo,
                                  ),
                                ),
                              )
                              .toList() +
                          [
                            Container(
                              width: 10,
                            )
                          ],
                    ),
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Sales and Stats',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    height: 150,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [Container(width: 10)] +
                          snapshot.listItem
                              .map<Container>(
                                (item) => Container(
                                  child: HomeListTile(
                                    title: item.title,
                                    imageURL: item.imageURL,
                                    color: item.color,
                                    routeTo: item.routeTo,
                                  ),
                                ),
                              )
                              .toList() +
                          [
                            Container(
                              width: 10,
                            )
                          ],
                    ),
                  ),
                ]),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 60,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBloc>(
      create: (context) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Color(0xffecebf1),
        body: Consumer<HomeBloc>(builder: (context, snapshot, childWidget) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 150,
                pinned: true,
                elevation: 1,
                leadingWidth: 60,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80)),
                    child: Text(
                      "Scheduler",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  collapseMode: CollapseMode.pin,
                  background: Image.asset(
                    'assets/home_bg.jpg',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    alignment: Alignment.bottomRight,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SingleImageBanner(
                  description:
                      'Quickly create an account\nmake reservations even\nfaster.',
                  imageURL: 'assets/customerBanner.jpg',
                  routeto: null,
                  title: 'Register an\nAccount',
                  buttonTitle: 'Register Now',
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
