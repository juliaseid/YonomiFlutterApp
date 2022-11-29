import 'package:yonomi_platform_sdk/yonomi-sdk.dart';
import 'package:dotenv/dotenv.dart';

var env = DotEnv(includePlatformEnvironment: true)..load();

const String endpoint = 'https://platform.yonomi.cloud/graphql';
final String token = '${env['TOKEN_STRING']}';
final String tenantId = '${env['TENANT_ID']}';

Request request = Request(endpoint, {
  "Authorization": "Bearer $token",
  "x-allegion-installation-reference-id": tenantId
});
