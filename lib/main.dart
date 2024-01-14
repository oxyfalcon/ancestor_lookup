import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Keys",
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent)),
      home: const Material(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  late List<StateFullTiles> tileList;
  @override
  void initState() {
    tileList = [
      StateFullTiles(key: UniqueKey()),
      StateFullTiles(key: UniqueKey())
    ];
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Text("change"),
          onPressed: () => setState(() {
            tileList.insert(1, tileList.removeAt(0));
          }),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: tileList),
      ),
    );
  }
}

class StateFullTiles extends StatefulWidget {
  const StateFullTiles({super.key});

  @override
  State<StateFullTiles> createState() => _StateFullTilesState();

  @override
  StatefulElement createElement() {
    return CustomElement(this);
  }
}

class _StateFullTilesState extends State<StateFullTiles> {
  late Color color;

  @override
  void initState() {
    color = Color.fromARGB(255, Random().nextInt(255), Random().nextInt(255),
        Random().nextInt(255));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: color,
      child: const Text("Tile"),
    );
  }
}

class CustomElement extends StatefulElement {
  CustomElement(super.widget);

  @override
  Element inflateWidget(Widget newWidget, Object? newSlot) {
    print("Inflate widget ${newWidget.hashCode}");
    return super.inflateWidget(newWidget, newSlot);
  }

  @override
  void update(covariant StatefulWidget newWidget) {
    print("Update Widget: ${newWidget.hashCode}");
    super.update(newWidget);
  }
}
