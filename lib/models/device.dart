import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeviceModel with ChangeNotifier {
  //obviously more will come here

  void getDeviceDetails(String deviceId) {
    // deviceName = queryResults(deviceId);
    //sub that in when query is written
    // deviceName = 'mytestDevice';
  }

  void getDeviceState(String deviceId) {
    // deviceName = queryResults(deviceId);
    //sub that in when query is written
    // deviceName = 'mytestDevice';
    notifyListeners();
  }
  // String queryResults = {
  //   //this is where the yonomi query will go, I think
  // }

  Future<DeviceModel> updateDeviceStateAsync() async {
    await Future.delayed(Duration(seconds: 5));
    notifyListeners();
    return DeviceModel();
  }
  //This will eventually be replaced by a webhook
}
