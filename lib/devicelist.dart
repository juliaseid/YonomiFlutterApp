import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:dotenv/dotenv.dart';
import 'package:yonomi_flutter_app/request.dart';
import 'dart:convert';

Iterable<String> path = ['.env'];
var env = DotEnv(includePlatformEnvironment: true)..load(path);

class DeviceList {
  String _myDevices = "";
  final Request request;

  DeviceList(this.request);

  Future<void> fetchDeviceList() async {
    final devicesFromGraph =
        await DevicesRepository.getDevices(request).toString();
    if (devicesFromGraph == null) {
      _myDevices = "";
      return;
    }
    _myDevices = devicesFromGraph;
    // .map((device) => Device(
    //     device.id,
    //     device.displayName,
    //     device.description,
    //     device.manufacturerName,
    //     device.model,
    //     device.serialNumber,
    //     device.createdAt,
    //     device.updatedAt,
    //     device.traits))
    // .toList();
  }

  String get myDevices => _myDevices;
}

main() async {
  // print(DeviceList(request).fetchDeviceList());
  print(DevicesRepository.getDeviceDetails(
      request, "13334f06-3b7d-423a-a7a3-f81257544920"));
}
