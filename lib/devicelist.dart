import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:dotenv/dotenv.dart';
import 'package:yonomi_flutter_app/request.dart';
import 'dart:convert';

Iterable<String> path = ['.env'];
var env = DotEnv(includePlatformEnvironment: true)..load(path);

class DeviceList {
  List<Device> _myDevices = [];
  final Request request;

  DeviceList(this.request);

  Future<void> fetchDeviceList() async {
    final devicesFromGraph = await DevicesRepository.getDevices(request);
    if (devicesFromGraph == null) {
      _myDevices = [];
      return;
    }
    _myDevices = devicesFromGraph;
  }

  List<Device> get myDevices => _myDevices;
}

main() async {
  DeviceList(request).fetchDeviceList();
}
