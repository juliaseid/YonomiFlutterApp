import 'dart:io';
//This allows us to do an easy OS query & set up a window for non-browser devices - other functionality inside `dart:io` is only availble in non-browser apps

import 'package:flutter/foundation.dart';
//similarly, we're just using this to check the compile format for a given app build with the `kIsWeb` property.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:window_size/window_size.dart';
import 'package:yonomi_flutter_app/common/theme.dart';
//Set window size for builds identified by dart:io and kIsWeb criteria
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:yonomi_flutter_app/models/devicelist.dart';
import 'package:yonomi_flutter_app/models/device.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 360;
const double windowHeight = 640;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Provider Counter');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<DeviceList>(
        create: (context) => DeviceList.create(),
        child: MaterialApp(
          title: 'Yonomi Device Demo App', 
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': ((context) => const MyDeviceList(),
            '/deviceDetail': (context) => const MyDeviceDetail(),
          }
        )
      );
  }
}

