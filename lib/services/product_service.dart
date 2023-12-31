import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zeazeoshop/models/product_model/product_item_model.dart';
import 'package:zeazeoshop/utils/env.dart';
import 'package:zeazeoshop/utils/shared_pref.dart';

class ProductService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Authorization': SharedPrefs().user?.token ?? '',
  };

  Future<List<Map<String, dynamic>>> getAllCategories() async {
    try {
      var response = await http.get(
        Uri.https(Env.baseUrl, '/api/categories'),
        headers: _headers,
      );

      print('HEADERS : ${response.headers}');
      print(
          'METHOD | URL : ${response.request?.method} ${response.request?.url}');
      print(
          'STATUS CODE | RESPONSE : ${response.statusCode} | ${response.body}');

      if (response.statusCode == 200) {
        var data = List<Map<String, dynamic>>.from(
            jsonDecode(response.body)['data']['data']);

        return data;
      } else {
        throw Exception('Gagal Get Category');
      }
    } catch (e) {
      print('error category : ${e}');

      return [];
    }
  }

  Future<List<ProductItemModel>> getAllProducts(
      {Map<String, dynamic>? params}) async {
    try {
      var response = await http.get(
        Uri.https(Env.baseUrl, '/api/products', params),
        headers: _headers,
      );

      print('HEADERS : ${response.headers}');
      print(
          'METHOD | URL : ${response.request?.method} ${response.request?.url}');
      print(
          'STATUS CODE | RESPONSE : ${response.statusCode} | ${response.body}');

      if (response.statusCode == 200) {
        var data = List<Map<String, dynamic>>.from(
            jsonDecode(response.body)['data']['data']);
        var dataToModel = data.map((e) => ProductItemModel.fromMap(e)).toList();

        return dataToModel;
      } else {
        throw Exception('Gagal Get Poducts');
      }
    } catch (e) {
      print('error products : ${e}');

      return [];
    }
  }

  Future<bool> checkout({required Map<String, dynamic> request}) async {
    try {
      var response = await http.post(
        Uri.https(Env.baseUrl, '/api/checkout'),
        headers: _headers,
        body: jsonEncode(request),
      );

      print('HEADERS : ${response.headers}');
      print(
          'METHOD | URL : ${response.request?.method} ${response.request?.url}');
      print(
          'STATUS CODE | RESPONSE : ${response.statusCode} | ${response.body}');

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      print('error checkout : ${e}');

      return false;
    }
  }
}
