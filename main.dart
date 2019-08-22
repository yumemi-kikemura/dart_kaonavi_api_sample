import 'package:http/http.dart';
import 'dart:convert';
import 'dart:async';

void main() async {
  String token = await getToken();
  String users = await getUser(token);
  print(jsonDecode(users)['data']);
}

Future <String> getToken() async {
  String url = 'https://api.kaonavi.jp/api/v1.0/get_token';
  var data = {
    'consumer_key': 'xxx',
    'consumer_secret': 'xxx'
  };
  // POST request
  Response response = await post(url, body: data);
  int statusCode = response.statusCode;
  print(statusCode);

  String body = response.body;
  print(body);

  String accessToken = jsonDecode(body)['data']['access_token'];
  print(accessToken);
  return accessToken;
}

Future <String> getUser(String accessToken) async {
  String url = 'https://api.kaonavi.jp/api/v1.0/user';
  var header = {
    'X-KAONAVI-TOKEN': accessToken
  };

  Response response = await post(url, headers: header);
  return response.body;
}
