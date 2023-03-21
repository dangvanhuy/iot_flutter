import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fsos/srceens/locationv2/homepage.dart';
import 'package:fsos/srceens/onloading.dart';
import 'package:fsos/srceens/screen_bluetooth_off.dart';
import 'package:fsos/srceens/screen_find_devices.dart';
import 'package:get/get.dart';

class FlutterBlueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Onbording(),
      // home: StreamBuilder<BluetoothState>(
      //     stream: FlutterBlue.instance.state,
      //     initialData: BluetoothState.unknown,
      //     builder: (c, snapshot) {
      //       final state = snapshot.data;
      //       if (state == BluetoothState.on) {
      //         return const FindDevicesScreen();
      //       }
      //       // return BluetoothOffScreen(state: state);
      //       return Onbording();
      //     }),
    );
  }
}
