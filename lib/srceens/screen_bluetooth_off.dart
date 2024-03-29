import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothOffScreen extends StatelessWidget {
  const BluetoothOffScreen({Key? key, this.state}) : super(key: key);

  final BluetoothState? state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'FSOS client',
              style: Theme.of(context)
                  .primaryTextTheme
                  .displaySmall
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              'Arduino/GPS/LORA. Open source tracker.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(
              height: 30,
            ),
            const Icon(
              Icons.bluetooth_disabled,
              size: 100.0,
              color: Colors.white54,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: Theme.of(context)
                  .primaryTextTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
