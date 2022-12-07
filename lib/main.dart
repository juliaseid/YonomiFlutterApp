import 'package:flutter/material.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_flutter_app/request.dart';
// import 'package:yonomi_flutter_app/devicelist.dart';
// ignore: library_prefixes
import 'package:yonomi_platform_sdk/yonomi-sdk.dart' as platform_SDK;

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<platform_SDK.Device>> futureDeviceList;

  @override
  void initState() {
    super.initState();
    futureDeviceList = platform_SDK.DevicesRepository.getDevices(request);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Your Yonomi Devices',
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Welcome to Yonomi'),
            ),
            body: Center(
                child: FutureBuilder<List<platform_SDK.Device>>(
                    future: futureDeviceList,
                    builder: ((context,
                        AsyncSnapshot<List<platform_SDK.Device>> snapshot) {
                      List<Widget> children;
                      if (snapshot.hasData) {
                        List<platform_SDK.Device> devices = snapshot.data!;
                        children = <Widget>[
                          const Text("Your Yonomi Devices"),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Text(devices.toString()),
                            // ListView.builder(
                            //     itemCount: devices.length,
                            //     prototypeItem: ListTile(
                            //       title: Text(devices.first.displayName),
                            //     ),
                            //     itemBuilder: (context, index) {
                            //       return ListTile(
                            //         title: Text(
                            //             devices.elementAt(index).displayName),
                            //         onTap: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     DetailScreen(
                            //                         request: request,
                            //                         deviceId: devices
                            //                             .elementAt(index)
                            //                             .id),
                            //               ));
                            //         },
                            //       );
                            //     })
                          )
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
                    })))));
  }
}
