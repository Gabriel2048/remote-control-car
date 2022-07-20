import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothScanResults extends StatelessWidget {
  const BluetoothScanResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanResult>>(
      stream: FlutterBluePlus.instance.scanResults,
      initialData: const [],
      builder: (context, snapshot) {
        final results = snapshot.data?.toList() ?? [];
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final result = results[index];
            return ListTile(
              key: Key(result.device.id.toString()),
              title: Text(result.device.name),
              subtitle: Text(result.device.id.toString()),
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
