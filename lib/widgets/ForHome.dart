import 'dart:ui';

import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/CustomerHomeBloc.dart';

import 'custom_filled_icons_icons.dart';
import 'custom_icons_icons.dart';

class HomeListTile extends StatefulWidget {
  final String title;
  final IconData iconData;
  final Widget routeTo;

  const HomeListTile({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.routeTo,
  }) : super(key: key);
  @override
  _HomeListTileState createState() => _HomeListTileState();
}

class _HomeListTileState extends State<HomeListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            PageRouteBuilder(pageBuilder: (context, animation, animation2) {
          return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position:
                    Tween<Offset>(begin: Offset(0.09, 0), end: Offset(0, 0))
                        .chain(CurveTween(
                          curve: Curves.easeInOutCirc,
                        ))
                        .animate(animation),
                child: widget.routeTo,
              ));
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        width: 130,
        child: Material(
          color: Colors.white,
          shape: SquircleBorder(
            radius: 30,
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 125,
                  child: Material(
                    color: Colors.blueAccent.withOpacity(0.1),
                    shape: SquircleBorder(radius: 30),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          widget.iconData,
                          size: 36,
                          color: Colors.blueAccent,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 8),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
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

class SingleImageBanner extends StatefulWidget {
  final String title;
  final String description;
  final String imageURL;
  final Widget routeto;
  final String buttonTitle;

  const SingleImageBanner(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.imageURL,
      @required this.routeto,
      this.buttonTitle = 'View now'})
      : super(key: key);
  @override
  _SingleImageBannerState createState() => _SingleImageBannerState();
}

class _SingleImageBannerState extends State<SingleImageBanner> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: MediaQuery.of(context).size.width * 0.5,
          child: Material(
            borderOnForeground: true,
            elevation: 1,
            shadowColor: Colors.black54,
            color: Colors.white,
            shape: SquircleBorder(radius: 50),
            child: InkResponse(
              splashColor: Colors.grey.shade100,
              onTap: () {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, animation2) {
                  return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                          position: Tween<Offset>(
                                  begin: Offset(0.05, 0), end: Offset(0, 0))
                              .animate(animation),
                          child: widget.routeto));
                }));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          widget.description,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            child: Material(
                              shape: SquircleBorder(radius: 30),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    widget.buttonTitle,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt_rounded,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width / 2.2,
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: Image.asset(widget.imageURL)))
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomBottomBar extends StatefulWidget {
  @override
  _CustomBottomBarState createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.antiAlias,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          height: 60,
          color: Colors.white54,
          width: MediaQuery.of(context).size.width,
          child: Material(
            clipBehavior: Clip.none,
            type: MaterialType.transparency,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BBarIcon(
                  title: "Home",
                  iconData: CustomIcons.fi_rr_home,
                  selectedIcon: CustomFilledIcons.fi_sr_home,
                  index: 0,
                ),
                BBarIcon(
                  title: "Services",
                  iconData: CustomIcons.fi_rr_asterisk,
                  selectedIcon: CustomFilledIcons.fi_sr_asterisk,
                  index: 1,
                ),
                BBarIcon(
                  title: "Cart",
                  iconData: CustomIcons.fi_rr_shopping_bag,
                  selectedIcon: CustomFilledIcons.fi_sr_shopping_bag,
                  index: 2,
                ),
                BBarIcon(
                  title: "Reservations",
                  iconData: CustomIcons.fi_rr_notebook,
                  selectedIcon: CustomFilledIcons.fi_sr_notebook,
                  index: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BBarIcon extends StatefulWidget {
  final int index;
  final String title;
  final IconData iconData;
  final IconData selectedIcon;

  const BBarIcon({
    Key key,
    @required this.title,
    @required this.iconData,
    @required this.selectedIcon,
    @required this.index,
  }) : super(key: key);
  @override
  _BBarIconState createState() => _BBarIconState();
}

class _BBarIconState extends State<BBarIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CustomerHomeBloc>(builder: (context, value, _) {
        return InkResponse(
          onTap: () {
            value.previousIndex = value.index;
            value.index = widget.index;
            value.update();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: widget.index == value.index
                    ? Icon(
                        widget.selectedIcon,
                        key: Key("selected"),
                        color: Colors.blueAccent,
                      )
                    : Icon(
                        widget.iconData,
                        key: Key("unselected"),
                        color: Colors.grey,
                      ),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.index == value.index
                      ? Colors.blueAccent
                      : Colors.grey,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
