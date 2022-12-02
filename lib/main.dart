import 'package:flutter/material.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_flutter_app/request.dart';
// import 'package:yonomi_flutter_app/devicelist.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart' as SDK;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<SDK.Device>> futureDeviceList;
  late Future<String> testString;

  @override
  void initState() {
    super.initState();
    futureDeviceList = SDK.DevicesRepository.getDevices(request);
    testString = fetchHealthCheck();
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
                child: FutureBuilder<List<SDK.Device>>(
                    future: futureDeviceList,
                    builder:
                        ((context, AsyncSnapshot<List<SDK.Device>> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        List<SDK.Device> devices = snapshot.data!;
                        children = <Widget>[
                          const Text("Your Yonomi Devices"),
                          Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: ListView.builder(
                                  itemCount: devices.length,
                                  prototypeItem: ListTile(
                                    title: Text(devices.first.displayName),
                                  ),
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title: Text(
                                          devices.elementAt(index).displayName),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailScreen(
                                                      request: request,
                                                      deviceId: devices
                                                          .elementAt(index)
                                                          .id),
                                            ));
                                      },
                                    );
                                  }))
                        ];
                      } else if (snapshot.hasError) {
                        children = <Widget>[
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        ];
                      } else {
                        children = const <Widget>[
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 16),
                            child: Text('Awaiting result...'),
                          ),
                        ];
                      }

                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: children,
                        ),
                      );
                    }))
                // child: FutureBuilder<DeviceList>(
                //     future: futureDeviceList,
                //     builder: ((context, snapshot) {
                //       if (snapshot.hasData) {
                //         if (snapshot.data!.myDevices != null) {
                //           final Map<String, String> deviceMap =
                //               <String, String>{};
                //           for (var device in snapshot.data!.myDevices!) {
                //             final deviceNameId = <String, String>{
                //               device.id: device.displayName
                //             };
                //             deviceMap.addEntries(deviceNameId.entries);
                //           }
                //           ListView.builder(
                //               itemCount: deviceMap.length,
                //               prototypeItem: ListTile(
                //                 title: Text(deviceMap.values.first),
                //               ),
                //               itemBuilder: (context, index) {
                //                 return ListTile(
                //                   title: Text(deviceMap.values.elementAt(index)),
                //                   onTap: () {
                //                     Navigator.push(
                //                         context,
                //                         MaterialPageRoute(
                //                           builder: (context) => DetailScreen(
                //                               request: request,
                //                               deviceId: deviceMap.keys
                //                                   .elementAt(index)),
                //                         ));
                //                   },
                //                 );
                //               });
                //         } else if (snapshot.hasData &&
                //             snapshot.data!.myDevices == null) {
                //           return const Text(
                //               'You have no Yonomi devices linked to your account.');
                //         }
                //       } else if (snapshot.hasError) {
                //         return Text('${snapshot.error}');
                //       }
                //       return const CircularProgressIndicator();
                //     })),
                )));
  }
}
