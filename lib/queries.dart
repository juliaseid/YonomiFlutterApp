import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:new_app/request.dart';

class DeviceList {
  List<Device> myDevices = [];

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

//How to handle reqeusts that aren't built into the SDK methods? I guess just a regular API call specifying endpoint and headers as properties of Request class
//This is what we'll have to use for now for "allDevices", but the advantage is being able to specify a minimal device view that won't require state handling
//That way, all state management will happen at DetailScreen level, keeping Provider out of "allDevices" screen
//How to build a custom UI widget? IDK. I hope it is easy.