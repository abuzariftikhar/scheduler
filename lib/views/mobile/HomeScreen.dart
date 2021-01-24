import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/CartBloc.dart';
import 'package:scheduler/blocs/CustomerHomeBloc.dart';
import 'package:scheduler/blocs/for_admin/HomeBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';
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
  Widget _getHomeWidget(int index) {
    Widget _widget = Container();
    if (index == 0) {
      _widget = HomeLanding();
    } else if (index == 1) {
      _widget = HomeServices();
    } else if (index == 2) {
      _widget = HomeCart();
    } else if (index == 3) {
      _widget = HomeProfile();
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
                  reverseDuration: Duration(milliseconds: 100),
                  child: _getHomeWidget(value.index));
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
  final String heroTag;
  const HomeServiceTile({
    Key key,
    @required this.serviceItem,
    @required this.heroTag,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
        height: 125,
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Color(serviceItem.color).withOpacity(0.2),
          shape: SquircleBorder(
            radius: 30,
          ),
          child: Consumer<CustomerHomeBloc>(builder: (context, value, _) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, animation2) {
                      return ServiceDetailsView(
                        serviceItem: serviceItem,
                        heroTag: heroTag,
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
                          height: 125,
                          width: 98,
                          child: Material(
                            shape: SquircleBorder(
                              radius: 30,
                            ),
                            color: Colors.white,
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Container(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress),
                              ),
                              imageUrl: serviceItem.imageURL,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              height: 145,
                              width: 88,
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
                                    color: Color(serviceItem.color),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Color(serviceItem.color),
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
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$${serviceItem.cost}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(serviceItem.color),
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
                      color: Color(serviceItem.color),
                    ),
                  ],
                ),
              ),
            );
          }),
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
        SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 160,
            elevation: 1,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                height: 160,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 300, sigmaY: 300),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Material(
                              shape: SquircleBorder(radius: 30),
                              color: Colors.blueAccent.shade700,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  CustomFilledIcons.fi_sr_barber_shop,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Hi, Ahmed",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Welcome, What service would you like to try today?",
                              style: TextStyle(
                                color: Colors.grey.shade700,
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
            )),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Consumer<CustomerHomeBloc>(builder: (context, value, _) {
                return Container(
                  height: 330,
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
                            (e, i) => HomeServiceTile(
                              serviceItem: e,
                              heroTag: "service_details$i",
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
    return Hero(
      tag: widget.heroTag,
      child: Container(
        margin: EdgeInsets.all(
          20,
        ),
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Color(widget.serviceItem.color).withOpacity(0.2),
          shape: SquircleBorder(radius: 50),
          child: InkWell(
            splashColor: Color(widget.serviceItem.color).withOpacity(0.1),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, animation2) {
                    return ServiceDetailsView(
                      serviceItem: widget.serviceItem,
                      heroTag: widget.heroTag,
                    );
                  },
                ),
              );
            },
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: MediaQuery.of(context).size.width / 1.8,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: CachedNetworkImage(
                      imageUrl: widget.serviceItem.imageURL,
                      alignment: Alignment.bottomRight,
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Text(
                          widget.serviceItem.name,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color(widget.serviceItem.color),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.8,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.serviceItem.detailText,
                              textAlign: TextAlign.start,
                              maxLines: 8,
                              style: TextStyle(
                                shadows: [
                                  Shadow(
                                    blurRadius: 3,
                                    color: Colors.white,
                                  )
                                ],
                                color: Color(widget.serviceItem.color),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Material(
                              shape: SquircleBorder(radius: 30),
                              color: Color(widget.serviceItem.color),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 15.0),
                                child: Center(
                                  child: Text(
                                    "Book Service",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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
                  color: Color(0xfffff8f5),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Browse",
                            style: TextStyle(
                                color: Colors.grey.shade700,
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
                                color: Colors.grey,
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
                      SizedBox(width: 10),
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
              padding: const EdgeInsets.only(top: 20, left: 20, bottom: 10),
              child: Text(
                "Select your favorite ${value.filterTitle.toLowerCase()} service.",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
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
                    delegate: SliverChildListDelegate(value.servicesList
                        .mapIndex(
                          (e, i) => HomeServiceTile(
                            serviceItem: e,
                            heroTag: "service_details$i",
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
          type: MaterialType.transparency,
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
                  color: Color(0xfffff8f5),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cart",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Welcome, What service would you like to try today?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        Consumer<CartBloc>(builder: (context, value, _) {
          return SliverList(
            delegate: SliverChildListDelegate(value.cartItems
                .map((item) => QuickServiceTile(serviceItem: item))
                .toList()),
          );
        }),
      ],
    );
  }
}

class HomeProfile extends StatelessWidget {
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
                  color: Color(0xfffff8f5),
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, Ahmed",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Welcome, What service would you like to try today?",
                            style: TextStyle(
                                color: Colors.grey,
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
                        color: Color(0xfff6e7d6),
                        shape: SquircleBorder(radius: 50),
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
  final String heroTag;

  const ServiceDetailsView({
    Key key,
    @required this.serviceItem,
    @required this.heroTag,
  }) : super(key: key);
  @override
  _ServiceDetailsViewState createState() => _ServiceDetailsViewState();
}

class _ServiceDetailsViewState extends State<ServiceDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  leading: CloseButton(),
                  backgroundColor: Color(widget.serviceItem.color),
                  expandedHeight: MediaQuery.of(context).size.width,
                  elevation: 1,
                  stretch: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      height: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(widget.serviceItem.color),
                      ),
                      child: Stack(
                        children: [
                          PageView.builder(
                            itemBuilder: (context, index) {
                              return CachedNetworkImage(
                                imageUrl: widget.serviceItem.imageURL,
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                                height: 145,
                                width: 88,
                              );
                            },
                            itemCount: 10,
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
                                    color: Color(widget.serviceItem.color),
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
                                color: Color(widget.serviceItem.color),
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
                        color: Color(widget.serviceItem.color).withOpacity(0.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Material(
                          color:
                              Color(widget.serviceItem.color).withOpacity(0.1),
                          shape: SquircleBorder(radius: 40),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              widget.serviceItem.detailText,
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(widget.serviceItem.color),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Color(widget.serviceItem.color).withOpacity(0.5),
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
                                  color: Color(widget.serviceItem.color)
                                      .withOpacity(0.1),
                                  shape: SquircleBorder(radius: 40),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Icon(CustomFilledIcons.fi_sr_dollar,
                                        color: Color(widget.serviceItem.color)),
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
                                    color: Color(widget.serviceItem.color)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "\$${widget.serviceItem.cost}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(widget.serviceItem.color),
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
                                  color: Color(widget.serviceItem.color)
                                      .withOpacity(0.1),
                                  shape: SquircleBorder(radius: 40),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Icon(
                                        CustomFilledIcons.fi_sr_stopwatch,
                                        color: Color(widget.serviceItem.color)),
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
                                    color: Color(widget.serviceItem.color)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    "${widget.serviceItem.timeRequired.toString()} Minutes",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(widget.serviceItem.color),
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
                                  color: Color(widget.serviceItem.color)
                                      .withOpacity(0.1),
                                  shape: SquircleBorder(radius: 40),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Icon(
                                      CustomFilledIcons.fi_sr_badge,
                                      color: Color(widget.serviceItem.color),
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
                                    color: Color(widget.serviceItem.color)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: Text(
                                    widget.serviceItem.type,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color(widget.serviceItem.color),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                  shape: SquircleBorder(radius: 40),
                  clipBehavior: Clip.antiAlias,
                  color: Colors.transparent,
                  child: Consumer<CartBloc>(builder: (context, cartbloc, _) {
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: Color(widget.serviceItem.color)
                                .withOpacity(0.1),
                            onTap: () {
                              cartbloc.addtocart(widget.serviceItem);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 70,
                              color: Color(widget.serviceItem.color)
                                  .withOpacity(0.3),
                              child: Text(
                                "Book Now",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Color(widget.serviceItem.color),
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor:
                              Color(widget.serviceItem.color).withOpacity(0.7),
                          onTap: () {
                            String message =
                                cartbloc.addtocart(widget.serviceItem);
                            Fluttertoast.showToast(msg: message);
                          },
                          child: Container(
                            width: 150,
                            height: 70,
                            alignment: Alignment.center,
                            color: Color(widget.serviceItem.color)
                                .withOpacity(0.7),
                            child: Text(
                              "Add to Cart",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
