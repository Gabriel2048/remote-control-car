import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';

class BluetoothOff extends StatelessWidget {
  const BluetoothOff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Bluetooth is required for this application.'),
        ElevatedButton.icon(
          icon: const Icon(Icons.bluetooth),
          label: const Text('Turn on'),
          onPressed: AppSettings.openBluetoothSettings,
        ),
      ],
    );
  }
}
