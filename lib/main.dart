import 'package:flutter/material.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart' as SDK;
import 'package:yonomi_flutter_app/devicelist.dart';
import 'package:yonomi_flutter_app/request.dart' as my_request;

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
            body: Center(
                child: devices.isEmpty == true
                    ? const Text("You have no linked devices")
                    : ListView.builder(
                        itemCount: devices.length,
                        prototypeItem: ListTile(
                          title: Text(devices.first.displayName),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        request: my_request.request,
                                        deviceId: devices.first.id)));
                          },
                        ),
                        itemBuilder: ((context, index) {
                          return ListTile(
                              title: Text(devices[index].displayName),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              request: my_request.request,
                                              deviceId: devices[index].id,
                                            )));
                              });
                        }),
                      ))));
  }
}
