// flutter
import 'dart:convert';

import 'package:http/http.dart';
// dependencies
// app

class JsonModel {
  static const List<int> validResponseCodes = [200, 201, 204];

  final Map<String, dynamic> data;

  JsonModel({
    this.data,
  });

  factory JsonModel.fromResponse(Response response) {
    final int responseCode = response.statusCode;
    final String responseString = response.body;

    if (validResponseCodes.contains(responseCode)) {
      return JsonModel.fromString(responseString);
    } else {
      return _throwJsonError(responseString);
    }
  }

  factory JsonModel.fromStream(String responseString, int responseCode) {
    if (validResponseCodes.contains(responseCode)) {
      return JsonModel.fromString(responseString);
    } else {
      return _throwJsonError(responseString);
    }
  }

  factory JsonModel.fromString(String string,) => JsonModel(data: _jsonFromString(string));
  static _jsonFromString(String string) {
    final Map<String, dynamic> _json = json.decode(string);
    return _json.containsKey('data') ? _json['data'] : _json;
  }

  static _throwJsonError(String string) {
    final Map<String, dynamic> _json = _jsonFromString(string);
    final error = _json['error'] ?? 'Oops Something Went Wrong';
    throw(error);
  }

  Map<String, dynamic> toRecordData() {
    Map<String, dynamic> recordData = {};
    recordData.addAll({'id': data['id']});
    recordData.addAll(data['attributes']);
    return recordData;
  }

  static int stringToInt(String number) => number == null ? null : int.parse(number);
  static String stringFromInt(int number) => number?.toString();
}