import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_device_widgets/providers/device_provider.dart';
import 'package:yonomi_flutter_app/models/request.dart';
import 'package:yonomi_flutter_app/models/device.dart';
import 'package:yonomi_platform_sdk/yonomi-sdk.dart';

class Device with ChangeNotifier {
  String deviceId = '';
  String? deviceName;
  String? lockedState;
  String? jammedState;
  int? batteryLevel;
  // late Function setLocked;
  // late Function setUnlocked;

  Device(String deviceId) {
    DevicesRepository.getDeviceDetails(request, deviceId);

  }
  // Future <Device> getDeviceById(String id) async {
  //   var newDevice = await DevicesRepository.getDeviceDetails(request, id);
  //   return newDevice;
  // } 
}


class DeviceListModel {
  final List<String> deviceIDs = [];
  
  set myDevices (List<String> deviceIDs) =>  {
    deviceIDs.forEach((element) {
      Future<Device> newDevice = Device.getDeviceById(id)
    })
  };

  List<Device> get myDevices => {
    myDevices = <Device>[];
    return myDevices;
  }

//   static List<Device> 


  
// }



