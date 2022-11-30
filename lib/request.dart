import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:http/http.dart' as http;
import 'package:dotenv/dotenv.dart';
import 'dart:convert';

Iterable<String> path = ['.env'];
var env = DotEnv(includePlatformEnvironment: true)..load(path);

const String endpoint = 'https://platform.yonomi.cloud/graphql';
final String token = '${env['TOKEN_STRING']}';
final String tenantId = '${env['TENANT_ID']}';

Request request = Request(endpoint, {
  "Authorization": "Bearer $token",
  "x-allegion-installation-reference-id": tenantId
});

const Map<String, String> healthCheck = {
  "query": """query
  basicInfo {
    health {
      ok
    }
  }
  """
};

Future<String> fetchHealthCheck() async {
  final response =
      await http.post(Uri.parse('https://platform.yonomi.cloud/graphql'),
          headers: {
            "Authorization": "Bearer $token",
            "x-allegion-installation-reference-id": tenantId,
            "Content-Type": "application/json"
          },
          body: jsonEncode(healthCheck));
  if (response.statusCode == 200) {
    print(response.body.toString());
    print(jsonDecode(response.body));
    return (response.body.toString());
  } else {
    print(response.statusCode);
    throw Exception('Failed to connect');
  }
}

void getUserTest() async {
  final userFromRequest = await UserRepository.getUserDetails(request);
  print("My User ID: ${userFromRequest.id}");
}

void main() {
  fetchHealthCheck();
}
