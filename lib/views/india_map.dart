import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show rootBundle;
import 'package:india_map/models/states_data.dart';

class IndiaMap extends StatefulWidget {
  static const id = "mapOfIndia";
  @override
  _IndiaMapState createState() => _IndiaMapState();
}

class _IndiaMapState extends State<IndiaMap> {
  String imagePath = 'assets/IndiaMap.png';
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  // CHANGE THIS FLAG TO TEST BASIC IMAGE, AND SNAPSHOT.
  bool useSnapshot = true;

  // based on useSnapshot=true ? paintKey : imageKey ;
  // this key is used in this example to keep the code shorter.
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
    double _width = 0.0;
    double _height = 0.0;
    final String title = useSnapshot ? "snapshot" : "basic";
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
              if (selectedState != null) {
                _width = 100.0;
                _height = 100.0;
              }
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
                                    ? ''
                                    : '${selectedState.name}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.0,
                                    decoration: TextDecoration.none)),
                            SizedBox(height: 10.0),
                            Text(
                                selectedState == null
                                    ? ''
                                    : '${selectedState.capital}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10.0,
                                    decoration: TextDecoration.none)),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                            child: Image.asset(
                              selectedState == null
                                    ? 'assets/empty.png'
                                    : '${selectedState.picturePath}',
                              key: imageKey,
                              fit: BoxFit.none,
                            ),
                          ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Stack(
                    children: <Widget>[
                      RepaintBoundary(
                        key: paintKey,
                        child: GestureDetector(
                          onTapUp: (details) {
                            _width = 100.0;
                            _height = 100.0;
                            searchPixel(details.globalPosition);
                          },
                          child: Center(
                            child: Image.asset(
                              imagePath,
                              key: imageKey,
                              fit: BoxFit.none,
                            ),
                          ),
                        ),
                      ),
                    ],
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

// image lib uses uses KML color format, convert #AABBGGRR to regular #AARRGGBB
int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
