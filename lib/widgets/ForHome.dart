import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';

class HomeListTile extends StatefulWidget {
  final String title;
  final String imageURL;
  final Color color;
  final Widget routeTo;

  const HomeListTile({
    Key key,
    @required this.title,
    @required this.imageURL,
    @required this.color,
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
          elevation: 0.5,
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
                    color: Colors.blueGrey.shade50,
                    shape: SquircleBorder(radius: 30),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset(
                        widget.imageURL,
                        fit: BoxFit.contain,
                      ),
                    ),
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
                            color: Colors.black,
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
