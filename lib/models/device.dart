import 'package:flutter/foundation.dart';

class DeviceModel with ChangeNotifier {
  String deviceName = '';
  String deviceId = '';
  //obviously more will come here
  void getDeviceDetails(String deviceId) {
    // deviceName = queryResults(deviceId);
    //sub that in when query is written
    deviceName = 'mytestDevice';
    notifyListeners();
  }

  void getDeviceStatus(String deviceId) {
    // deviceName = queryResults(deviceId);
    //sub that in when query is written
    deviceName = 'mytestDevice';
    notifyListeners();
  }
  // String queryResults = {
  //   //this is where the yonomi query will go, I think
  // }
}
