import 'dart:async';
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
  StreamSubscription<BluetoothState>? _bluetoothStateSubscription;
  Future<dynamic>? _scannig;
  final Duration _scanningTimeout = const Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    _bluetoothStateSubscription =
        FlutterBluePlus.instance.state.listen(_onBluetoothStateChange);
  }

  @override
  void dispose() {
    super.dispose();
    _bluetoothStateSubscription?.cancel();
  }

  Future<void> _onBluetoothStateChange(state) async {
    if (state == BluetoothState.turningOff) {
      await FlutterBluePlus.instance.stopScan();
    }
    setState(() {
      isBluetoothOn = state == BluetoothState.on;
      if (isBluetoothOn) {
        _scannig =
            FlutterBluePlus.instance.startScan(timeout: _scanningTimeout);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isBluetoothOn
            ? FutureBuilder(
                future: _scannig,
                builder: (context, snapshot) => const BluetoothScanResults(),
              )
            : const BluetoothOff(),
      ),
    );
  }
}
