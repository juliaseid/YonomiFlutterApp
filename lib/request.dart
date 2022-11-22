import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String endpoint = 'platform.yonomi.cloud/graphql';
final String token = dotenv.get('TOKEN_STRING');
final String tenantId = dotenv.get('TENANT_ID');

Request request = Request(endpoint, {
  "Authorization": "Bearer $token",
  "x-allegion-installation-reference-id": tenantId
});
