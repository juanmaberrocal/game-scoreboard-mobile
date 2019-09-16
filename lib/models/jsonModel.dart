// flutter
import 'dart:convert';
// dependencies
// app

abstract class JsonModel {
  // This class is intended to be used as a mixin, and should not be
  // extended directly.
  factory JsonModel._() => null;

  Map<String, dynamic> parseResponseString({
    String responseString,
    int responseCode,
    List<int> validResponseCodes = const [200, 201, 204]
  }) {
    final responseJson = json.decode(responseString);

    if (validResponseCodes.contains(responseCode)) {
      final responseData = responseJson['data'];
      return responseData;
    } else {
      final responseError = responseJson['error'] ?? 'Oops Something Went Wrong';
      throw(responseError);
    }
  }

  Map<String, dynamic> parseResponseDataToRecordData({
    Map<String, dynamic> responseData,
  }) {
    Map<String, dynamic> recordData = {};
    recordData.addAll({'id': responseData['id']});
    recordData.addAll(responseData['attributes']);

    return recordData;
  }

  static int stringToInt(String number) => number == null ? null : int.parse(number);
  static String stringFromInt(int number) => number?.toString();
}