import 'package:flutter/material.dart';
import 'package:flutter_demo_apps/apps/counter_app.dart';
import 'package:flutter_demo_apps/apps/draggable_card.dart';
import 'package:flutter_demo_apps/apps/flutter_block_app.dart';
import 'package:flutter_demo_apps/apps/google_fonts.dart';
import 'package:flutter_demo_apps/apps/implicit_animations.dart';
import 'package:flutter_demo_apps/apps/provider_app.dart';
import 'package:flutter_demo_apps/apps/sunflower_app.dart';
import 'package:flutter_demo_apps/apps/firebase_demo_app.dart';
import 'apps/color_theming_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, Object>> _appList = [
    {'title': 'Counter App', 'app': const CounterApp(title: "Counter App")},
    {'title': 'Sunflower App', 'app': const Sunflower()},
    {'title': 'Imp App', 'app': const PhysicsCardDragDemo()},
    {'title': 'Animated Disks App', 'app': const AnimatedDisks()},
    {'title': 'Google Fonts App', 'app': const GoogleFontsApp()},
    {'title': 'Provider Demo App', 'app': const ProviderDemoApp()},
    {'title': 'Flutter Block Demo App', 'app': const FlutterBlocDemo()},
    {'title': 'Color Theming App', 'app': const ColorThemingApp()},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // addFirebaseApp();
  }

  void addFirebaseApp() async {
    _appList.add(
      {'title': 'Firebase Demo App', 'app': const FirebaseDemoApp()},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Apps'),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(_appList[index]['title'] as String),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => _appList[index]['app'] as Widget));
              },
            );
          },
          itemCount: _appList.length,
        ),
      ),
    );
  }
}
