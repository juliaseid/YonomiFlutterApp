import 'dart:html';
import 'dart:io';

import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';
import 'dart:convert';
import 'package:multiple_result/multiple_result.dart';
import 'package:yonomi_flutter_app/request.dart';

Iterable<String> path = ['.env'];
var env = DotEnv(includePlatformEnvironment: true)..load(path);

class DeviceList {
  late List<Device>? myDevices;
  final String token = '${env['TOKEN_STRING']}';
  String tenantId = '${env['TENANT_ID']}';

  DeviceList({
    this.myDevices,
  });

  static Future<DeviceList> fetchDeviceList() async {
    final result = await DevicesRepository.getDevices(request);
    return (DeviceList(myDevices: result));
  }
}
