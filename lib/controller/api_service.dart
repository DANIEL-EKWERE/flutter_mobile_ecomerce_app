import 'dart:io';

import 'package:ecommerce1/models/login_model.dart';
import 'package:ecommerce1/models/products_category.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// c7_zFbqZSN6WyhH9nKR3As:APA91bECDtC76YED32C4S7Qtw3JsvBTzfntz3jn2lxpdEi_LGbMGnRmZii7AihK-37DtP4Zuc5byCeLpoO7MBlv-NX6oaWZgcQqCmVTz8LJOgIcLzsznmRwxDuLoP0TbsElJ3KZ0CqYG



class ProductProvider extends ChangeNotifier {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<void> login(LoginModel loginModel) async {
    final String url = '$baseUrl/auth/login';

    final response = await http.post(Uri.parse(url), body: {
      'username': loginModel.username,
      'password': loginModel.password,
    });

    try {
      if (response.statusCode == 200) {
      } else {
        throw Exception("Error ${response.statusCode}");
      }
    } on SocketException {
      throw const SocketException('please check your network connection');
    }
  }

  Future<List<ProductsCategory>> getProducts() async {
    final url = "$baseUrl/products";

    final response = await http.get(Uri.parse(url));

    try {
      if (response.statusCode == 200) {
        final responseData = response.body;
        List<ProductsCategory> productCategory =
            productsCategoryFromJson(responseData);
        notifyListeners();
        return productCategory;
      }else{
        // ignore: avoid_print
        print("Error ${response.statusCode}");
        return[];
      }
    } on SocketException {
      throw const SocketException('please check your internet connection');
    }
  }
}
