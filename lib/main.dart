import 'package:flutter/material.dart';
import 'package:dotenv/dotenv.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/assets/traits/device_item_icon.dart';
import 'package:yonomi_device_widgets/devices/lock.dart';
import 'package:yonomi_device_widgets/providers/device_provider.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_device_widgets/traits/lock_widget.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:yonomi_flutter_app/request.dart';
import 'package:yonomi_flutter_app/devicelist.dart';

void main() {
  runApp(MyApp());
  late Future<DeviceList> futureDeviceList;
  futureDeviceList = fetchDeviceList();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    futureDeviceList 
    if (myDeviceList != null) {
      return MaterialApp(
        title: 'Welcome to Yonomi',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Your Yonomi Devices'),
            ),
            body: ListView.builder(
              itemBuilder: ((BuildContext context, int index) {
                return ListTile(
                    leading: DeviceItemIcon.getIcon(myDeviceList[index].traits),
                    title: Text(myDeviceList[index].displayName));
              }),
            )),
      );
    } else {
      return MaterialApp(
          title: 'Welcome to Yonomi',
          home: Scaffold(
              appBar: AppBar(
                title: const Text('Your Yonomi Devices'),
              ),
              body: Column(
                children: [
                  const Text("You have no Yonomi devices."),
                ],
              )));
    }
  }
}
