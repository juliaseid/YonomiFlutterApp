import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/providers/device_provider.dart';
import 'package:yonomi_flutter_app/models/request.dart';
import 'package:yonomi_flutter_app/models/device.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class DeviceList {
  DeviceList._create() {
    
  }
  //this should follow the private constructor/public factory model
}

static Future<DeviceList> create() async {
  await DevicesRepository.getDevices(request);
  var deviceList = DeviceList._create();
  
  return deviceList;
}

// final device = deviceFromJson(jsonstring);
class Device {
  String? deviceId;
  String? deviceName;
  String? deviceType;

  Device({
    this.deviceId,
    this.deviceName,
    this.deviceType
  });

  factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

  factory Device.fromJson(Map<String, dynamic> json) {
    String type = "other";
    String trait = json['traits'][0];
    if (trait == 'THERMOSTAT_SETTING') {
      type = "thermostat";
    }
    else if (trait == 'LOCK') {
      type = "lock";
    }
    else if (trait == "BRIGHTNESS") {
      type = "light";
    }
    return Device(
    deviceId: json['id'],
    deviceName: json['displayName'],
    deviceType: type,
    );
  } 
}



class Lock extends Device with ChangeNotifier {
  String? lockedState;
  String? jammedState;
  int? batteryLevel;
  // late Function setLocked;
  // late Function setUnlocked;

  // Lock(String deviceId) {
  //   DevicesRepository.getDeviceDetails(request, deviceId);

    //Lock should also be private constructor, public factory
  }
  // Future <Device> getDeviceById(String id) async {
  //   var newDevice = await DevicesRepository.getDeviceDetails(request, id);
  //   return newDevice;
  // }
}
 