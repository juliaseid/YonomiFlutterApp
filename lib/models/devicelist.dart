import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_app/models/request.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class DeviceList {
  List<Device>? myDevices;

  DeviceList._create(List<Device> deviceList);

  static Future<DeviceList> create() async {
    List<Device> deviceList = await DevicesRepository.getDevices(request);
    var myDevices = DeviceList._create(deviceList);
    return myDevices;
  }
}

class Lock with ChangeNotifier {
  String? lockId;
  String? lockName;
  bool? lockedState;
  bool? jammedState;
  int? batteryLevel;

  Lock._create(Device lock) {
    lockId = lock.id;
    lockName = lock.displayName;

    Trait isLocked =
        (lock.traits.singleWhere((element) => (element.name == "isLocked")));
    isLocked.properties.first.value ? lockedState = true : lockedState = false;

    Trait supportsIsJammed = (lock.traits
        .singleWhere((element) => (element.name) == "supportsIsJammed"));
    Trait? isJammed =
        (lock.traits.singleWhere((element) => (element.name) == "isJammed"));
    supportsIsJammed.properties.first.value
        ? jammedState = isJammed.properties.first.value
        : jammedState = null;

    batteryLevel = lock.traits
        .singleWhere(((element) => (element.name == "batteryLevel")))
        .properties
        .first
        .value;
  }

  // static Future<Lock> create(String lockId) async {
  //   Device lockDevice = await DevicesRepository.getLockDetails(request, lockId);
  //   var lock = Lock._create(lockDevice);
  //   return lock;
  // }

  static Lock create(String lockId) async {
    var newLock = Lock()
    //TODO: create an empty lock for initial state, then call Yonomi
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