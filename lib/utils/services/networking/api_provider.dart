import 'dart:developer';

import 'package:ecommerce/constants/api_path_constants.dart';
import 'package:ecommerce/utils/services/shared_preference/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'custom_exception.dart';
import 'package:async/async.dart';
import 'dart:convert';

class ApiProvider{
  Map<String, String> requestHeaders = {
    'Accept-Charset': 'utf-8'
  };


  Future<dynamic> post({required String url, required Map<String,String> body}) async {
    final dateInitial = DateTime.now();

    dynamic responseJson;
    try {
      final response = await http.post(Uri.parse(url),body: body);
      final dateFinal = DateTime.now();
      debugPrint('Api $url response time is => ' + dateFinal.difference(dateInitial).inSeconds.toString() + ' seconds');
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  dynamic _responseStream(http.StreamedResponse response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.stream.toString());
        log(jsonEncode(responseJson));
        return responseJson;
      case 400:
        throw BadRequestException(response.stream.toString());
      case 401:

      case 403:
        return response.statusCode;
    // throw UnauthorisedException(response.statusCode);
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        log(jsonEncode(responseJson));
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        return response.statusCode;
    // throw UnauthorisedException(response.statusCode);
      case 500:

      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}