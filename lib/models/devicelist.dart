import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yonomi_flutter_app/models/device.dart';

class DeviceListModel {
  List<DeviceModel> myDevices = [];
  DeviceListModel(this.myDevices);
  void updateDeviceList() {
    for (final device in myDevices) {
      device.getDeviceStatus(device.deviceId);
    }
  }
}

//Should this be a list of DeviceModel or just a list of strings of ids, or a list of key:value pairs of id & name?  Should device status be included in this model? Maybe there should be 3 models: DeviceList, Device, and DeviceFunctions or DeviceDetail.  Both DeviceList and DeviceFunctions would be dependent on Device. This probably makes sense b/c it seems like it will lead to the fewest queries.  