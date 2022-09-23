import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class YonomiRequest {
  final String endpoint = dotenv.get('GRAPH_ENDPOINT', fallback: '');
  final String token = dotenv.get('TOKEN_STRING', fallback: '');
  late Request request;

  YonomiRequest(String endpoint, String token) {
    request = Request(endpoint, {"Authorization": "Bearer $token"});
  }
}
