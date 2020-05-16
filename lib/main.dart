import 'package:flutter/material.dart';
import 'views/india_map.dart';
import 'views/state_view.dart';
import 'package:india_map/modals/states_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: IndiaMap.id ,
      routes: {
        IndiaMap.id: (context) => IndiaMap(),
        StateView.id: (context) => StateView(state: IndianStates[0])
      },
    );
  }
}

