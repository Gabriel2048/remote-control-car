import 'dart:io';

import 'package:embedded_controller/embedded_controller.dart' as embedded_controller;

void main(List<String> arguments) {
  print('Hello world: ${embedded_controller.calculate()}!');
  stdin.readLineSync();
}
