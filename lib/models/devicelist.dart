import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_app/models/device.dart';

class DeviceListModel {
  static final List<String> deviceIDs = [];

  List<Device> get myDevices => {
    List<Device> myDevices = <Device>[];
    for (var l = 1, l<deviceIDs.length; l++) {
      Device newDevice = Device();
      newDevice.getDeviceById(id);
      myDevices.add(newDevice);
    }
    return myDevices;
  }


  
}

class Device with ChangeNotifier {
  String deviceId = '';
  String? deviceName;
  String? lockedState;
  String? jammedState;
  int? batteryLevel;

  Device getDeviceById(String id) {
    //Yonomi query here
    String name = "name from query";
    String locked = "state from query";
    String jammed = "state from query";
    int battery = 100; 
    Device newDevice = Device();
    newDevice.deviceId = id;
    newDevice.deviceName = name;
    newDevice.lockedState = locked;
    newDevice.jammedState = jammed;
    newDevice.batteryLevel = battery;
    return newDevice;
  } 
}

