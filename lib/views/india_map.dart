import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:india_map/models/states_data.dart';
import 'package:random_string/random_string.dart';

class IndiaMap extends StatefulWidget {
  static const id = "mapOfIndia";
  @override
  _IndiaMapState createState() => _IndiaMapState();
}

class _IndiaMapState extends State<IndiaMap> {
  String imagePath = 'assets/IndiaMap.png';
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();
  bool useSnapshot = true;
  GlobalKey currentKey;

  final StreamController<Color> _stateController = StreamController<Color>();
  img.Image photo;

  @override
  void initState() {
    currentKey = useSnapshot ? paintKey : imageKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color prevSelectedColor;
    return Scaffold(
      appBar: AppBar(title: Text("Indian States")),
      body: StreamBuilder(
          initialData: Colors.green[500],
          stream: _stateController.stream,
          builder: (buildContext, snapshot) {
            Color selectedColor = snapshot.data ?? Colors.green;
            StateData selectedState;
            if (prevSelectedColor != selectedColor) {
              selectedState = IndianStates.singleWhere(
                  (state) => state.colour == selectedColor,
                  orElse: () => null);
              prevSelectedColor = selectedColor;
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                                selectedState == null
                                    ? 'Tap on a State'
                                    : '${selectedState.name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Courgette',
                                    color: Colors.black,
                                    fontSize: 10.0,
                                    decoration: TextDecoration.none),
                                    
                                  ),
                            SizedBox(height: 10.0),
                            Text(
                                selectedState == null
                                    ? ''
                                    : 'Capital : ${selectedState.capital}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Courgette',
                                    color: Colors.black,
                                    fontSize: 10.0,
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                              child: child,
                              scale: animation,
                            );
                          },
                          child: Image.asset(
                            selectedState == null
                                ? 'assets/empty.png'
                                : '${selectedState.picturePath}',
                            key: ValueKey(randomString(10)),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: RepaintBoundary(
                    key: paintKey,
                    child: GestureDetector(
                      onTapUp: (details) {
                        searchPixel(details.globalPosition);
                      },
                      child: Center(
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  void searchPixel(Offset globalPosition) async {
    if (photo == null) {
      await (useSnapshot ? loadSnapshotBytes() : loadImageBundleBytes());
    }
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (!useSnapshot) {
      double widgetScale = box.size.width / photo.width;
      print(py);
      px = (px / widgetScale);
      py = (py / widgetScale);
    }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);

    _stateController.add(Color(hex));
  }

  Future<void> loadImageBundleBytes() async {
    ByteData imageBytes = await rootBundle.load(imagePath);
    setImageBytes(imageBytes);
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes =
        await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
