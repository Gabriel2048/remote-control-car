import 'package:flutter/material.dart';
import 'package:remote_car_app/screens/home/bluetooth_off.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:remote_car_app/screens/home/bluetooth_scan_results.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isBluetoothOn = false;

  @override
  void initState() {
    super.initState();
    FlutterBluePlus.instance.state.listen((state) {
      setState(() {
        isBluetoothOn = state == BluetoothState.on;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isBluetoothOn
            ? FutureBuilder(
                future: FlutterBluePlus.instance
                    .startScan(timeout: const Duration(seconds: 10)),
                builder: (context, snapshot) => const BluetoothScanResults())
            : const BluetoothOff(),
      ),
    );
  }
}
