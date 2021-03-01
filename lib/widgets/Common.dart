import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';

class CustomDropdownList<T> extends StatefulWidget {
  final String initialvalue;
  final List<String> itemList;
  final double widgetWidth;
  final Color color;
  final void Function(T, int position) valueChanged;
  const CustomDropdownList({
    this.initialvalue,
    Key key,
    this.color = Colors.white,
    this.widgetWidth = 0,
    @required this.valueChanged,
    @required this.itemList,
  }) : super(key: key);
  @override
  _CustomDropdownListState createState() => _CustomDropdownListState();
}

class _CustomDropdownListState extends State<CustomDropdownList> {
  bool dropdownOpened = false;
  String val = "Please Select";
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final ScrollController _scrollController = ScrollController();

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
        builder: (context) => Positioned(
              width: size.width,
              child: CompositedTransformFollower(
                link: this._layerLink,
                showWhenUnlinked: false,
                offset: Offset(0.0, size.height + 2.0),
                child: Material(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  shape: SquircleBorder(
                    radius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    height: 170,
                    child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: Scrollbar(
                        controller: _scrollController,
                        isAlwaysShown: true,
                        child: ListView(
                            controller: _scrollController,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            children: widget.itemList
                                .mapIndex(
                                  (item, index) => Column(
                                    children: [
                                      ListTile(
                                        tileColor: Colors.white,
                                        title: Center(child: Text(item)),
                                        onTap: () {
                                          Future.delayed(
                                              Duration(milliseconds: 200), () {
                                            setState(() {
                                              val = item;
                                              dropdownOpened = false;
                                              widget.valueChanged(item, index);
                                            });
                                            this._overlayEntry.remove();
                                          });
                                        },
                                      ),
                                      Divider(height: 1),
                                    ],
                                  ),
                                )
                                .toList()),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }

  @override
  void initState() {
    if (widget.itemList.contains(widget.initialvalue)) {
      val = widget.initialvalue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Material(
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: SquircleBorder(
          radius: BorderRadius.circular(30),
        ),
        child: InkResponse(
          splashColor: Colors.blueAccent.withOpacity(0.1),
          onTap: () {
            if (!dropdownOpened) {
              setState(() {
                dropdownOpened = true;
              });
              this._overlayEntry = this._createOverlayEntry();
              Overlay.of(context).insert(this._overlayEntry);
            } else {
              setState(() {
                dropdownOpened = false;
              });
              this._overlayEntry.remove();
            }
          },
          child: Container(
            width: widget.widgetWidth == 0
                ? MediaQuery.of(context).size.width / 2.2
                : widget.widgetWidth,
            height: 60.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(val),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey,
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
