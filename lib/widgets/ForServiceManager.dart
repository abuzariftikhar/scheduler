import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/blocs/ServicesManagerBloc.dart';
import 'package:scheduler/models/ServiceModel.dart';
import 'package:scheduler/views/mobile/ServiceDetailsScreen.dart';

class ServiceTile extends StatefulWidget {
  final String heroTag;
  final ServiceModel serviceModel;
  const ServiceTile({
    Key key,
    @required this.serviceModel,
    @required this.heroTag,
  }) : super(key: key);
  @override
  _ServiceTileState createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (BuildContext context, animation, secondartAnimation) {
              return FadeTransition(
                  opacity: animation,
                  child: ServiceDetailsScreen(
                    serviceModel: widget.serviceModel,
                    heroTag: widget.heroTag,
                  ));
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 130,
        child: Hero(
          tag: widget.heroTag,
          child: Material(
              elevation: 1,
              clipBehavior: Clip.antiAlias,
              shape: SquircleBorder(
                radius: 30.0,
              ),
              child: Row(
                children: [
                  Material(
                    color: Colors.white,
                    shape: SquircleBorder(
                      radius: 30.0,
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      height: 124,
                      width: 94,
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        shape: SquircleBorder(
                          radius: 30.0,
                        ),
                        child: FadeInImage.assetNetwork(
                          fadeInCurve: Curves.easeIn,
                          placeholder: "assets/loading-animation.gif",
                          image: widget.serviceModel.imageURL,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                          height: 124,
                          width: 94,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width - 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            widget.serviceModel.name,
                            softWrap: true,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text("Type: ${widget.serviceModel.type}"),
                        Text("Badge: ${widget.serviceModel.badge}"),
                        Text(
                          "Cost: ${widget.serviceModel.cost}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class FiltersTile extends StatefulWidget {
  final int index;
  final String title;

  const FiltersTile({
    Key key,
    @required this.index,
    @required this.title,
  }) : super(key: key);
  @override
  _FiltersTileState createState() => _FiltersTileState();
}

class _FiltersTileState extends State<FiltersTile> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesManagerBloc>(
        builder: (context, snapshot, childWidget) {
      return GestureDetector(
        onTap: () {
          snapshot.index = widget.index;
          snapshot.update();
          if (widget.index == 0) {
            snapshot.loadAllServices("currentUser");
          } else {
            snapshot.loadServicesbyType(widget.title);
          }
        },
        child: AnimatedContainer(
          alignment: Alignment.center,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
          margin: EdgeInsets.only(bottom: 8),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: widget.index == snapshot.index
                ? Colors.blueAccent
                : Colors.grey.shade100,
            borderRadius: BorderRadius.all(Radius.elliptical(50, 50)),
          ),
          child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 200),
              style: TextStyle(
                color: widget.index == snapshot.index
                    ? Colors.white
                    : Colors.grey.shade700,
              ),
              child: Text(widget.title)),
        ),
      );
    });
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
