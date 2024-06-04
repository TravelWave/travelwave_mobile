import 'dart:convert';

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
