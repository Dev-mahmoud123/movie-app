import 'dart:convert';

import 'package:http/http.dart';
import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  dynamic get(String path) async {
    var url = Uri.parse(
        "${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}");
    final response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  dynamic getWithParams(String path, Map<dynamic, dynamic> params) async {
    var url = Uri.parse(getPath(path, params));
    final response = await _client.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}

String getPath(String path, Map<dynamic, dynamic> params) {
  var paramsString = "";
  if (params.isNotEmpty) {
    params.forEach((key, value) {
      paramsString += "&$key=$value";
    });
  }
  return '${ApiConstants.baseUrl}$path?api_key=${ApiConstants.apiKey}$paramsString}';
}
