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
  List<String> tokenParts = token.split('.');

// Decode the payload part (the middle part)
  String payloadString = tokenParts[1];
  while (payloadString.length % 4 != 0) {
    payloadString += '=';
  }
// Decode the base64 payload string
  String decodedPayload = utf8.decode(base64Url.decode(payloadString));

// Parse the JSON payload
  Map<String, dynamic> payload = jsonDecode(decodedPayload);

  return payload;
}
