import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fsos/controller/fsos_controller.dart';
import 'package:fsos/saved_parameters.dart';
import 'package:fsos/srceens/location/home_location.dart';
import 'package:fsos/widgets/widget_lora_tracker_tile.dart';
import 'package:fsos/widgets/widget_use_compass.dart';
import 'package:get/get.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  final BluetoothDevice device;

  Widget _buildServiceTiles(List<BluetoothService> services) {
    BluetoothService? FSOSService;

    services.forEach((service) {
      if (service.uuid.toString().startsWith("0000ffa2") ||
          service.uuid.toString().startsWith("0000ffe0")) {
        FSOSService = service;
      }
    });
    if (FSOSService != null) {
      var characteristics = FSOSService!.characteristics;
      for (BluetoothCharacteristic c in characteristics) {
        if (c.uuid.toString().startsWith("0000ffe1")) {
          c.setNotifyValue(true);
          c.read();
          return StreamBuilder<List<int>>(
              stream: c.value,
              initialData: c.lastValue,
              builder: (c, snapshot) {
                final value = snapshot.data;
                //print('Char FFE1 value: ${value}');
                newDataReceived(value!);
                return Column(
                  children: trackersDataList
                      .map((e) => LORAtrackerTile(
                          time: e.time,
                          lat: e.latitude,
                          lon: e.longitude,
                          identifier: e.identificator,
                          use_compass: use_compass))
                      .toList(),
                );
              });
        }
      }
    }
    return Text('Not FSOS data.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback? onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  device.discoverServices();
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return TextButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .labelLarge
                        ?.copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const BottomAppBar(
              color: Colors.white,
              child: WidgetUseCompass(),
            ),
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device ${myName} is ${snapshot.data.toString().split('.')[1]}.'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data! ? 1 : 0,
                    children: const <Widget>[
                      Icon(Icons.account_tree),
                      SizedBox(
                        width: 18.0,
                        height: 18.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return _buildServiceTiles(snapshot.data!);
              },
            ),
            // Center(
            //     child:  Expanded(child: HomePage()),
            // ),
            ElevatedButton(
              child: Text("location"),
              onPressed: () {
                Get.off(() => HomePagev2());
              },
            )
          ],
        ),
      ),
      // bottomNavigationBar: const BottomAppBar(
      //   color: Colors.white,
      //   child: WidgetUseCompass(),
      // )
    );
  }
}
