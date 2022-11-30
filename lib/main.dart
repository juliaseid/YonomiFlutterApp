import 'package:flutter/material.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_flutter_app/request.dart';
import 'package:yonomi_flutter_app/devicelist.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<DeviceList> futureDeviceList;

  @override
  void initState() {
    super.initState();
    futureDeviceList = DeviceList().fetchDeviceList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Your Yonomi Devices',
        theme: ThemeData(
          primaryColor: Colors.yellow[400],
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Welcome to Yonomi'),
            ),
            body: Center(
              child: FutureBuilder<DeviceList>(
                  future: futureDeviceList,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.myDevices != null) {
                        final Map<String, String> deviceMap =
                            <String, String>{};
                        for (var device in snapshot.data!.myDevices!) {
                          final deviceNameId = <String, String>{
                            device.id: device.displayName
                          };
                          deviceMap.addEntries(deviceNameId.entries);
                        }
                        ListView.builder(
                            itemCount: deviceMap.length,
                            prototypeItem: ListTile(
                              title: Text(deviceMap.values.first),
                            ),
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(deviceMap.values.elementAt(index)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                            request: request,
                                            deviceId: deviceMap.keys
                                                .elementAt(index)),
                                      ));
                                },
                              );
                            });
                      } else if (snapshot.hasData &&
                          snapshot.data!.myDevices == null) {
                        return const Text(
                            'You have no Yonomi devices linked to your account.');
                      }
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  })),
            )));
  }
}
