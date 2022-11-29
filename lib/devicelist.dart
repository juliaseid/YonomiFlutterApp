import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:yonomi_device_widgets/providers/widget_state.dart';
import 'package:yonomi_device_widgets/ui/string_constants.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';
import 'dart:convert';
import 'package:yonomi_flutter_app/querytext.dart' as query_text;

typedef GetDeviceListMethod = Future<List<Device>> Function(Request request);
var env = DotEnv(includePlatformEnvironment: true)..load();

class DeviceList {
  final List<Device> myDevices;
  final String token = '${env['TOKEN_STRING']}';
  String tenantId = '${env['TENANT_ID']}';

  DeviceList({
    required this.myDevices,
  });

  factory DeviceList.fromJson(Map<String, dynamic> json) {
    List<Device> devicesFromJson = [];
    Map<String, dynamic> devicesData = json['me'];
    Map<String, dynamic> edges = devicesData['devices'];
    Map<String, dynamic> nodes = edges['node'];
    nodes.forEach((node, device) => {
          devicesFromJson.add(Device(
              device.id,
              device.displayName,
              device.description,
              device.manufacturerName,
              device.model,
              device.serialNumber,
              device.createdAt,
              device.updatedAt,
              device.traits))
        });
    return DeviceList(myDevices: devicesFromJson);
  }

  Future<DeviceList> fetchDeviceList() async {
    final response =
        await http.post(Uri.parse('https://platform.yonomi.cloud/graphql'),
            headers: {
              "Authorization": "Bearer $token",
              "x-allegion-installation-reference-id": tenantId
            },
            body: query_text.allDevicesquery);
    if (response.statusCode == 200) {
      return DeviceList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load device list');
    }
  }
}
