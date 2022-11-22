import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/devices/lock.dart';
import 'package:yonomi_device_widgets/providers/device_provider.dart';
import 'package:yonomi_device_widgets/traits/detail_screen.dart';
import 'package:yonomi_device_widgets/traits/lock_widget.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:yonomi_flutter_app/request.dart';

void main() async {
  await dotenv.load();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Yonomi',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Yonomi'),
        ),
        body: Center(
          child: DetailScreen(request: request, deviceId: ,),
        ),
      ),
    );
  }
}
