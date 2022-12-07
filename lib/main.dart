import 'package:flutter/material.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart' as SDK;
import 'package:yonomi_flutter_app/devicelist.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<SDK.Device> devices = DeviceList().myDevices;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Your Yonomi Devices',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Welcome to Yonomi'),
            ),
            body: Center(child: Text(devices.toString()))));
  }
}
