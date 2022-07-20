import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  @override
  void initState() {
    super.initState();
    flutterBlue.startScan();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<List<ScanResult>>(
          stream: flutterBlue.scanResults,
          builder: (_, snapshot) => Center(
              child: ListView.builder(
                  itemBuilder: (_, a) =>
                      Text(snapshot.data?[a].device.name ?? ''),
                  itemCount: snapshot.data?.length)),
        ),
      ),
    );
  }
}
