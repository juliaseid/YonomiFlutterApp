import 'dart:async';
import 'package:flutter/material.dart';

import 'package:yonomi_flutter_app/models/request.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class DeviceList {
  List<Device>? myDevices;

  DeviceList._create(List<Device> deviceList);

  static DeviceList create() {
    var deviceList = <Device>[];
    DevicesRepository.getDevices(request)
        .then(((value) => {deviceList = value}))
        .catchError((e) {
      print('Got error: $e');
    });
    var myDevices = DeviceList._create(deviceList);
    return myDevices;
  }
}


// class Device {
//   String? deviceId;
//   String? deviceName;
//   String? deviceType;

//   Device({this.deviceId, this.deviceName, this.deviceType});

//   factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

//   factory Device.fromJson(Map<String, dynamic> json) {
//     String type = "other";
//     String trait = json['traits'][0];
//     if (trait == 'THERMOSTAT_SETTING') {
//       type = "thermostat";
//     } else if (trait == 'LOCK') {
//       type = "lock";
//     } else if (trait == "BRIGHTNESS") {
//       type = "light";
//     }
//     return Device(
//       deviceId: json['id'],
//       deviceName: json['displayName'],
//       deviceType: type,
//     );
//   }
// }