import 'dart:convert';

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');

  // if (parts.length != 3) {
  //   print("oo");
  //   throw Exception(
  //       'invalid token');
  // }

  final payload = _decodeBase64(parts[0]);

  final payloadMap = json.decode(payload);

  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}
