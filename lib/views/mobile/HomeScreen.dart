import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/AuthenticationBloc.dart';
import 'package:scheduler/blocs/BookingScreenBloc.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/blocs/CustomerHomeBloc.dart';
import 'package:scheduler/blocs/for_admin/HomeBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/views/mobile/BookServiceScreen.dart';
import 'package:scheduler/views/mobile/LandingScreen.dart';
import 'package:scheduler/views/mobile/QuickEntryScreen.dart';
import 'package:scheduler/widgets/ForHome.dart';
import 'package:scheduler/widgets/custom_filled_icons_icons.dart';
import 'package:scheduler/widgets/services_icons_icons.dart';

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
                  padding: const EdgeInsets.only(left: 20, bottom: 20, top: 10),
                  child: Text(
                    'Quick Access',
                    style: TextStyle(
                      fontSize: 24,
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
                                    iconData: item.iconData,
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
                    'Manage Store',
                    style: TextStyle(
                      fontSize: 24,
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
                                  iconData: item.iconData,
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
                    'Sales and Stats',
                    style: TextStyle(
                      fontSize: 24,
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
                          snapshot.listItem3
                              .map<Container>(
                                (item) => Container(
                                  child: HomeListTile(
                                    title: item.title,
                                    iconData: item.iconData,
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
  Widget _getHomeScreen(int index) {
    Widget _widget = Container();
    if (index == 0) {
      _widget = HomeLanding();
    } else if (index == 1) {
      _widget = HomeServices();
    } else if (index == 2) {
      _widget = HomeCart();
    } else if (index == 3) {
      _widget = HomeMyReservations();
    }
    return _widget;
  }

  @override
  void didChangeDependencies() {
    Provider.of<CustomerHomeBloc>(context, listen: false).loadHomeServices();
    Provider.of<CustomerHomeBloc>(context, listen: false)
        .loadServicesbyType("Hair Cutting");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Consumer<CustomerHomeBloc>(
            builder: (context, value, _) {
              return AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  reverseDuration: Duration(milliseconds: 10),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: value.index > value.previousIndex
                                  ? Offset(0.2, 0)
                                  : Offset(-0.2, 0),
                              end: Offset(0, 0))
                          .chain(CurveTween(curve: Curves.easeOutCirc))
                          .animate(animation),
                      child: child,
                    );
                  },
                  child: _getHomeScreen(value.index));
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomBar(),
          ),
        ],
      ),
    );
  }
}

class HomeServiceTile extends StatelessWidget {
  final ServiceItem serviceItem;
  const HomeServiceTile({
    Key key,
    @required this.serviceItem,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
      height: 130,
      child: Material(
        elevation: 6,
        shadowColor: Colors.blueGrey.shade50.withOpacity(0.5),
        clipBehavior: Clip.antiAlias,
        color: Colors.grey.shade100,
        shape: SquircleBorder(
          radius: 30,
        ),
        child: Consumer<CustomerHomeBloc>(builder: (context, value, _) {
          return InkWell(
            splashColor: Colors.white24,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, animation2) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(0, 1), end: Offset(0, 0))
                            .chain(CurveTween(
                              curve: Curves.easeInOutCirc,
                            ))
                            .animate(animation),
                        child: ServiceDetailsView(
                          serviceItem: serviceItem,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 130,
                        width: 130,
                        child: Material(
                          shape: SquircleBorder(
                            radius: 30,
                          ),
                          color: Colors.white,
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            imageUrl: serviceItem.imageURLs[0],
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            height: 115,
                            width: 130,
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          height: 114,
                          width: 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                serviceItem.name,
                                style: TextStyle(
                                  color: Colors.blueGrey.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Consumer<CartBloc>(builder: (context, value, _) {
                                return Text(
                                  value.durationToString(
                                      serviceItem.timeRequired),
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Text(
                                      serviceItem.category == "Banner"
                                          ? "Best"
                                          : "${serviceItem.category}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "\$${serviceItem.cost}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ],
                  ),
                  Icon(
                    Icons.keyboard_arrow_right_rounded,
                    color: Colors.blueGrey,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class HomeServiceTile2 extends StatefulWidget {
  final ServiceItem serviceItem;

  const HomeServiceTile2({Key key, this.serviceItem}) : super(key: key);
  @override
  _HomeServiceTile2State createState() => _HomeServiceTile2State();
}

class _HomeServiceTile2State extends State<HomeServiceTile2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 170,
      child: Material(
        clipBehavior: Clip.hardEdge,
        elevation: 6,
        shadowColor: Colors.blueGrey.shade50.withOpacity(0.5),
        color: Colors.grey.shade100,
        shape: SquircleBorder(radius: 30),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, animation2) {
                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position:
                          Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                              .chain(CurveTween(
                                curve: Curves.easeInOutCirc,
                              ))
                              .animate(animation),
                      child: ServiceDetailsView(
                        serviceItem: widget.serviceItem,
                      ),
                    ),
                  );
                },
              ),
            );
          },
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: EdgeInsets.fromLTRB(20, 20, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.serviceItem.type,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          widget.serviceItem.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.blueGrey.shade800,
                          ),
                        ),
                        Consumer<CartBloc>(builder: (context, value, _) {
                          return Text(
                            value.durationToString(
                                widget.serviceItem.timeRequired),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          );
                        }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Consumer<CartBloc>(builder: (context, value, _) {
                          return GestureDetector(
                            onTap: () {
                              bool result = value.addtocart(widget.serviceItem);
                              showSimpleNotification(
                                Text(
                                  result
                                      ? "${widget.serviceItem.name} already present in cart."
                                      : "${widget.serviceItem.name} added to cart.",
                                ),
                              );
                            },
                            child: Container(
                              width: 100,
                              margin: EdgeInsets.only(top: 5),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                  )
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    CustomFilledIcons.fi_sr_shopping_bag_add,
                                    size: 16,
                                    color: Colors.blueGrey,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Add",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        Text(
                          "\$${widget.serviceItem.cost}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 160,
                width: MediaQuery.of(context).size.width / 2.5,
                padding: EdgeInsets.all(2),
                child: Material(
                  shape: SquircleBorder(
                    radius: 30,
                  ),
                  color: Colors.white,
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: widget.serviceItem.imageURLs[0],
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width / 2.3,
                    width: 130,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeLanding extends StatefulWidget {
  @override
  _HomeLandingState createState() => _HomeLandingState();
}

class _HomeLandingState extends State<HomeLanding> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 50),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 36,
                  ),
                ),
                Consumer<AuthenticationBloc>(builder: (context, value, _) {
                  return GestureDetector(
                    onTap: () {
                      value.signOut();
                      Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: (context, animation, animation2) {
                        return FadeTransition(
                          opacity: animation,
                          child: LandingScreen(),
                        );
                      }));
                    },
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Colors.blueGrey.shade50,
                      ),
                      child: Image.asset("assets/avatar.png"),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            child: Material(
              shape: SquircleBorder(radius: 20),
              color: Colors.blueGrey.shade50,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(CupertinoIcons.search),
                  SizedBox(width: 10),
                  Text("Search")
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Consumer<CustomerHomeBloc>(builder: (context, value, _) {
                return Container(
                  height: 420,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return HomeCaroselTile(
                        serviceItem: value.bannerList[index],
                        heroTag: "carosel_tag$index",
                      );
                    },
                    itemCount: value.bannerList.length,
                  ),
                );
              })
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, bottom: 10),
            child: Text(
              "Trending Services",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28,
              ),
            ),
          ),
        ),
        Consumer<CustomerHomeBloc>(
          builder: (context, value, child) {
            if (!value.isLoading) {
              if (value.servicesList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                      elevation: 1,
                      shape: SquircleBorder(radius: 50),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 160,
                              width: 160,
                              child: Image.asset("assets/nothing.png"),
                            ),
                            Text(
                              "Nothing found here!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      value.trendingList
                          .mapIndex(
                            (e, i) => HomeServiceTile2(
                              serviceItem: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                );
              }
            } else {
              return SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 400,
          ),
        )
      ],
    );
  }
}

class HomeCaroselTile extends StatefulWidget {
  final ServiceItem serviceItem;
  final String heroTag;

  const HomeCaroselTile({
    Key key,
    @required this.serviceItem,
    @required this.heroTag,
  }) : super(key: key);

  @override
  _HomeCaroselTileState createState() => _HomeCaroselTileState();
}

class _HomeCaroselTileState extends State<HomeCaroselTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Material(
          elevation: 6,
          shadowColor: Colors.blueGrey.shade50.withOpacity(0.5),
          clipBehavior: Clip.antiAlias,
          color: Colors.blueGrey.shade50,
          shape: SquircleBorder(radius: 30),
          child: InkWell(
            splashColor: Colors.white24,
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, animation2) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                                begin: Offset(0, 1), end: Offset(0, 0))
                            .chain(CurveTween(
                              curve: Curves.easeInOutCirc,
                            ))
                            .animate(animation),
                        child: ServiceDetailsView(
                          serviceItem: widget.serviceItem,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Material(
                    clipBehavior: Clip.antiAlias,
                    shape: SquircleBorder(radius: 30),
                    child: Container(
                      height: 260,
                      width: MediaQuery.of(context).size.width,
                      child: CachedNetworkImage(
                        imageUrl: widget.serviceItem.imageURLs[0],
                        alignment: Alignment.bottomCenter,
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.serviceItem.type,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.blueGrey.shade300,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.8,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      widget.serviceItem.name,
                                      textAlign: TextAlign.start,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.blueGrey.shade800,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$${widget.serviceItem.cost}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueGrey.shade700,
                                    ),
                                  ),
                                  Consumer<CartBloc>(
                                      builder: (context, value, _) {
                                    return GestureDetector(
                                      onTap: () async {
                                        bool result =
                                            value.addtocart(widget.serviceItem);
                                        showSimpleNotification(
                                          Text(
                                            result
                                                ? "${widget.serviceItem.name} already present in cart."
                                                : "${widget.serviceItem.name} added to cart.",
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 8.0),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 10,
                                            )
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              CustomFilledIcons
                                                  .fi_sr_shopping_bag_add,
                                              size: 16,
                                              color: Colors.blueGrey,
                                            ),
                                            SizedBox(width: 8),
                                            Text(
                                              "Add",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeServices extends StatefulWidget {
  @override
  _HomeServicesState createState() => _HomeServicesState();
}

class _HomeServicesState extends State<HomeServices> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                  color: Colors.blueAccent.shade100,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(1.2, 2),
                      child: Icon(
                        CustomFilledIcons.fi_sr_asterisk,
                        size: 150,
                        color: Colors.white54,
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
                            "Browse",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Services",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "All the best in-class services at your finger tips.",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
            child: Text(
              "Service Type",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 28,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: 60,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      HomeServiceFilter(
                        index: 0,
                        title: "Hair Cutting",
                        iconData: ServicesIcons.scissors,
                      ),
                      HomeServiceFilter(
                        index: 1,
                        title: "Hair Dying",
                        iconData: ServicesIcons.hair_dye,
                      ),
                      HomeServiceFilter(
                        index: 2,
                        title: "Nail Treatment",
                        iconData: ServicesIcons.nail_polish,
                      ),
                      HomeServiceFilter(
                        index: 3,
                        title: "Skin Treatment",
                        iconData: ServicesIcons.face_mask,
                      ),
                      HomeServiceFilter(
                        index: 4,
                        title: "Waxing Services",
                        iconData: ServicesIcons.wax,
                      ),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Consumer<CustomerHomeBloc>(builder: (context, value, _) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 15),
              child: Text(
                "Select your favorite ${value.filterTitle.toLowerCase()} service.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
          );
        }),
        Consumer<CustomerHomeBloc>(
          builder: (context, value, child) {
            if (!value.isLoading) {
              if (value.servicesList.isEmpty) {
                return SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 160,
                        width: 160,
                        child: Image.asset("assets/nothing.png"),
                      ),
                    ),
                  ),
                );
              } else {
                return SliverPadding(
                  padding: EdgeInsets.zero,
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(value.servicesList
                        .mapIndex(
                          (e, i) => HomeServiceTile(
                            serviceItem: e,
                          ),
                        )
                        .toList()),
                  ),
                );
              }
            } else {
              return SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
          ),
        )
      ],
    );
  }
}

class HomeServiceFilter extends StatelessWidget {
  final int index;
  final String title;
  final IconData iconData;

  const HomeServiceFilter({
    Key key,
    @required this.index,
    @required this.title,
    @required this.iconData,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerHomeBloc>(builder: (context, value, _) {
      return Container(
        margin: EdgeInsets.only(left: 15.0),
        height: 60,
        child: Material(
          clipBehavior: Clip.antiAlias,
          shape: SquircleBorder(radius: 40),
          child: InkWell(
            onTap: () {
              value.filterTitle = title;
              value.filterIndex = index;
              value.update();
              value.loadServicesbyType(title);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              color: index == value.filterIndex
                  ? Colors.blueAccent
                  : Colors.grey.shade200,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    height: 60,
                    width: 60,
                    child: Material(
                      color: Colors.white,
                      shape: SquircleBorder(radius: 40),
                      child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: index == value.filterIndex
                              ? Icon(
                                  iconData,
                                  key: Key("selected"),
                                  color: Colors.blueAccent,
                                )
                              : Icon(
                                  iconData,
                                  key: Key("unselected"),
                                  color: Colors.grey,
                                )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 300),
                      style: TextStyle(
                        color: index == value.filterIndex
                            ? Colors.white
                            : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                      child: Text(
                        title,
                      ),
                    ),
                  ),
                  SizedBox(width: 5)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class HomeCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
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
                    color: Colors.blueAccent.shade100,
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment(1.2, 2),
                        child: Icon(
                          CustomFilledIcons.fi_sr_shopping_bag,
                          size: 150,
                          color: Colors.white54,
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
                              "Cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "We'd love to give our best services just add them in here.",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Consumer<CartBloc>(builder: (context, value, _) {
              if (value.cartItems.isNotEmpty) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Cost",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              reverseDuration: Duration(milliseconds: 10),
                              transitionBuilder: (child, animation) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(0.5, 0),
                                  end: Offset(0, 0),
                                )
                                    .chain(
                                        CurveTween(curve: Curves.easeOutCirc))
                                    .animate(animation),
                                child: child,
                              ),
                              child: Text(
                                "\$${value.totalCost.toString()}",
                                key: ValueKey(value.totalCost),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Duration",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade700,
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 400),
                              reverseDuration: Duration(milliseconds: 10),
                              transitionBuilder: (child, animation) =>
                                  SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(0.5, 0),
                                  end: Offset(0, 0),
                                )
                                    .chain(
                                        CurveTween(curve: Curves.easeOutCirc))
                                    .animate(animation),
                                child: child,
                              ),
                              child: Text(
                                value.durationToString(
                                    value.totalSlotsRequired * 15),
                                key: ValueKey(value.totalSlotsRequired),
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else
                return SliverToBoxAdapter(
                  child: Container(),
                );
            }),
            Consumer<CartBloc>(builder: (context, value, _) {
              if (value.cartItems.isNotEmpty) {
                return SliverList(
                  delegate: SliverChildListDelegate(value.cartItems
                      .map((item) => QuickServiceTile(serviceItem: item))
                      .toList()),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Container(
                    alignment: Alignment.center,
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 230,
                          width: 230,
                          child: Image.asset("assets/nothing.png"),
                        ),
                        Text(
                          "Services you'll add to cart will appear here.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }),
            SliverToBoxAdapter(child: SizedBox(height: 150))
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70, left: 10, right: 10),
            child: Row(
              children: [
                Consumer<CartBloc>(builder: (context, value, _) {
                  if (value.cartItems.isNotEmpty) {
                    return Button2(
                      title: "Proceed to Booking",
                      titleColor: Colors.white,
                      iconData: Icons.arrow_forward_rounded,
                      backgroundColor: value.cartItems.isNotEmpty
                          ? Colors.blueAccent
                          : Colors.grey.shade300,
                      onTap: () {
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
                                      CurveTween(curve: Curves.decelerate),
                                    )
                                    .animate(animation),
                                child: ChangeNotifierProvider(
                                    create: (context) => BookingScreenBloc(),
                                    child: BookServiceScreen()),
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else
                    return Container();
                }),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class HomeMyReservations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
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
                  color: Colors.blueAccent.shade100,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment(1.2, 2),
                      child: Icon(
                        CustomFilledIcons.fi_sr_receipt,
                        size: 150,
                        color: Colors.white54,
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
                            "My Reservations",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "All of your reservations in one place.",
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: MediaQuery.of(context).size.width - 100,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(
                        20,
                      ),
                      height: MediaQuery.of(context).size.width - 100,
                      width: MediaQuery.of(context).size.width - 100,
                      child: Material(
                        color: Colors.blueGrey.shade50,
                        shape: SquircleBorder(radius: 50),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 40,
                                height: 50,
                                color: Colors.amber,
                                child: Stack(
                                  children: [],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Reservation Date",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          "Feburary 20, 2021",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.blueGrey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      height: 40,
                                      width: 1,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      color: Colors.blueGrey,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                        Text(
                                          "10 : 00 AM ",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900,
                                            color: Colors.blueGrey.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

extension ExtendedIterable<E> on Iterable<E> {
  /// Like Iterable<T>.map but callback have index as second argument
  Iterable<T> mapIndex<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  void forEachIndex(void f(E e, int i)) {
    var i = 0;
    this.forEach((e) => f(e, i++));
  }
}

class ServiceDetailsView extends StatefulWidget {
  final ServiceItem serviceItem;

  const ServiceDetailsView({
    Key key,
    @required this.serviceItem,
  }) : super(key: key);
  @override
  _ServiceDetailsViewState createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                leading: CloseButton(),
                backgroundColor: Colors.white,
                expandedHeight: 300,
                elevation: 1,
                stretch: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    height: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                    ),
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemBuilder: (context, index) {
                            String image = widget.serviceItem.imageURLs[index];
                            return CachedNetworkImage(
                              imageUrl: image,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount: widget.serviceItem.imageURLs.length,
                          physics: BouncingScrollPhysics(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              child: Text(
                                widget.serviceItem.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28,
                                  color: Colors.blueGrey.shade700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blueGrey,
                            ),
                            child: Text(
                              widget.serviceItem.category == "Banner"
                                  ? "Best"
                                  : widget.serviceItem.category,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey.shade50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Material(
                                color: Colors.blueGrey.withOpacity(0.1),
                                shape: SquircleBorder(radius: 40),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(
                                    CustomFilledIcons.fi_sr_dollar,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Service Price",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "\$${widget.serviceItem.cost}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.blueGrey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Material(
                                color: Colors.blueGrey.withOpacity(0.1),
                                shape: SquircleBorder(radius: 40),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(CustomFilledIcons.fi_sr_stopwatch,
                                      color: Colors.blueGrey),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Time Required",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "${widget.serviceItem.timeRequired.toString()} Minutes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.blueGrey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Material(
                                color: Colors.blueGrey.withOpacity(0.1),
                                shape: SquircleBorder(radius: 40),
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Icon(
                                    CustomFilledIcons.fi_sr_badge,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Service Type",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey.shade900,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  widget.serviceItem.type,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.blueGrey.shade700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey.shade50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Material(
                        color: Colors.blueGrey.withOpacity(0.1),
                        shape: SquircleBorder(radius: 40),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            widget.serviceItem.detailText,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey.shade700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(20),
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: Material(
                elevation: 8,
                shape: SquircleBorder(radius: 20),
                clipBehavior: Clip.antiAlias,
                color: Colors.transparent,
                child: Consumer<CartBloc>(builder: (context, cartbloc, _) {
                  return Row(
                    children: [
                      Expanded(
                        child: Consumer<CartBloc>(builder: (context, value, _) {
                          return InkWell(
                            splashColor: Colors.white24,
                            onTap: () {
                              bool result = value.addtocart(widget.serviceItem);
                              showSimpleNotification(
                                Text(
                                  result
                                      ? "${widget.serviceItem.name} already present in cart."
                                      : "${widget.serviceItem.name} added to cart.",
                                ),
                              );

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
                                            CurveTween(
                                                curve: Curves.decelerate),
                                          )
                                          .animate(animation),
                                      child: ChangeNotifierProvider(
                                          create: (context) =>
                                              BookingScreenBloc(),
                                          child: BookServiceScreen()),
                                    );
                                  },
                                ),
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,
                              color: Colors.blueAccent,
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      Consumer<CartBloc>(builder: (context, value, _) {
                        return InkWell(
                          splashColor: Colors.red,
                          onTap: () {
                            bool result = value.addtocart(widget.serviceItem);
                            showSimpleNotification(
                              Text(
                                result
                                    ? "${widget.serviceItem.name} already present in cart."
                                    : "${widget.serviceItem.name} added to cart.",
                              ),
                            );
                          },
                          child: Container(
                            width: 150,
                            height: 70,
                            alignment: Alignment.center,
                            color: Colors.blueAccent.shade100,
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
