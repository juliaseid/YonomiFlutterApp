import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/providers/device_provider.dart';
import 'package:yonomi_flutter_app/models/request.dart';
import 'package:yonomi_flutter_app/models/device.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class DeviceList {
  // TODO: set up constructor
  DeviceList._create(String jsonData) {
    //TODO: parse json
  }

  static Future<DeviceList> create() async {
    String jsonData = DevicesRepository.getDevices(request).toString();
    var deviceList = DeviceList._create(jsonData);
    return deviceList;
  }
}

class Device {
  String? deviceId;
  String? deviceName;
  String? deviceType;

  Device({this.deviceId, this.deviceName, this.deviceType});

  factory Device.fromRawJson(String str) => Device.fromJson(json.decode(str));

  factory Device.fromJson(Map<String, dynamic> json) {
    String type = "other";
    String trait = json['traits'][0];
    if (trait == 'THERMOSTAT_SETTING') {
      type = "thermostat";
    } else if (trait == 'LOCK') {
      type = "lock";
    } else if (trait == "BRIGHTNESS") {
      type = "light";
    }
    return Device(
      deviceId: json['id'],
      deviceName: json['displayName'],
      deviceType: type,
    );
  }
}

class Lock with ChangeNotifier {
  String? lockId;
  String? lockName;
  String? lockedState;
  String? jammedState;
  int? batteryLevel;

  Lock._create(String jsonData) {
    //TODO: parse JSON data & assign
    this.lockId;
    this.lockName;
    this.lockedState;
    this.jammedState;
    this.batteryLevel;
  }

  static Future<Lock> create(String lockId) async {
    String jsonData =
        DevicesRepository.getLockDetails(request, lockId).toString();
    var lockDetails = Lock._create(jsonData);
    return lockDetails;
  }
}
