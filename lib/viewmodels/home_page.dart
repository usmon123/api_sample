import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../service/api_respons.dart';
import '../models/models.dart';

class HomeViewModel extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty');
  ApiResponse get apiResponse {
    return _apiResponse;
  }

  final List<CurrencyRate> _list = [];
  List<CurrencyRate> get list {
    return _list;
  }

  Future<ApiResponse> getData() async {
    String url = 'https://nbu.uz/uz/exchange-rates/json/';
    var myUrl = Uri.parse(url);
    try {
      var response = await http.get(myUrl);
      List data = jsonDecode(response.body);
      _list.clear();
      for (var item in data) {
        _list.add(CurrencyRate.fromJson(item));
      }
      _apiResponse = ApiResponse.success(_list);

      return _apiResponse;
    } on SocketException {
      _apiResponse = ApiResponse.error('Socket Exception');

      return _apiResponse;
    } catch (error) {
      _apiResponse = ApiResponse.error(error.toString());
      return _apiResponse;
    }
  }
}