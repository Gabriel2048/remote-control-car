import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

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

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

// ignore: prefer_const_constructors
  final a = FlutterBlue.instance.startScan(scanMode: ScanMode.lowLatency);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: StreamBuilder(
            stream: FlutterBlue.instance.scanResults,
            builder: (_, AsyncSnapshot<List<ScanResult>> snapshot) =>
                ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (_, int index) {
                if (snapshot.data == null || snapshot.data!.isEmpty) {
                  final state = snapshot.connectionState.name;
                  return Text(
                    '$state empty',
                    key: const Key('1'),
                  );
                }
                final title = snapshot.data?[index].device.name ?? 'no name';
                return Text(
                  title,
                  key: Key(snapshot.data![index].device.id.id),
                );
              },
            ),
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}
