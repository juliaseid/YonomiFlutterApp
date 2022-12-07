import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:yonomi_flutter_app/request.dart' as my_request;

class DeviceList {
  List<Device> _myDevices = [];
  static Request request = my_request.request;

  Future<void> fetchDeviceList() async {
    var devicesFromGraph = await DevicesRepository.getDevices(request);
    _myDevices = devicesFromGraph;
  }

  List<Device> get myDevices => _myDevices;
}

main() async {
  DeviceList().fetchDeviceList();
  print(DeviceList().myDevices);
}
