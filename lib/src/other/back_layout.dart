import 'package:flutter/material.dart';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:mdi/mdi.dart';


class BackLayout extends StatelessWidget {
  final Widget child;
  final Size size;

  BackLayout({required this.child, required this.size});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: child,
        ),
        isFullScreen(
          size,
          Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height),
        )
            ? getBackButton(
                Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
              )
            : Container()
      ],
    );
  }


  bool isFullScreen(Size currentSize, Size fullSize) {
  print("$fullSize == $currentSize");

  if (currentSize.height == fullSize.height &&
      fullSize.width == currentSize.width)
    return true;
  else
    return false;
}
getBackButton(Size size) {
  return PullableButton(size.width, size.height);
}

}

class PullableButton extends StatefulWidget {
  final double height, width;

  PullableButton(this.width, this.height);

  @override
  _PullableButtonState createState() => _PullableButtonState();
}

class _PullableButtonState extends State<PullableButton> {
  late double height, width;
  late double buttonWidth;
  Color _color = Colors.black;
  bool allowChangingValue = true;

  @override
  void initState() {
    height = widget.height;
    width = widget.width;
    buttonWidth = 0.175 * width;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      FeatureDiscovery.discoverFeatures(context, <String>['back']);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.1 * height,
      right: 0,
      child: GestureDetector(
        onHorizontalDragUpdate: (details) async {
          if (details.delta.dx < 0) {
            // print("-X local Position : " + details.localPosition.toString());
            buttonWidth = 0.3 * width;
            setState(() {});
            Navigator.pop(context);
          } else if (details.delta.dx > 0) {
            // print("+X local Position : " + details.localPosition.toString());
            buttonWidth = 0.175 * width;
            setState(() {});
          }

          if (details.delta.dy > 0) {
            // print("Dragginga in +Y direction");
          } else {
            //  print("Dragging in -Y direction");
          }
        },
        child: DescribedFeatureOverlay(
          barrierDismissible: false,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
          overflowMode: OverflowMode.wrapBackground,
          contentLocation: ContentLocation.above,
          title: Text("Swipe left to go back"),
          featureId: "back",
          tapTarget: Icon(Mdi.chevronDoubleLeft),
          child: Hero(
            tag: "herotagfor1",
            child: AnimatedContainer(
              duration: Duration(milliseconds: 150),
              curve: Curves.bounceInOut,
              height: 0.08 * height,
              width: buttonWidth,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0),
                ),
              ),
              child: Icon(
                Mdi.chevronDoubleLeft,
                color: Colors.grey,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  alterColor() {
    if (_color == Colors.black)
      _color = Colors.black.withOpacity(0.3);
    else
      _color = Colors.black;
  }
}



