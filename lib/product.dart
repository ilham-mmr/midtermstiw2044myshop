import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Product {
  String productName, productType, pictureUrl, image64;
  double price;
  int quantity;

  Product({this.productName, this.productType, this.price, this.quantity});

  Product.fromJson(json) {
    productName = json['productName'];
    productType = json['productType'];
    price = json['price'].toDouble();
    quantity = json['quantity'];
    pictureUrl = json['picture'];
  }
}

class ProductProvider with ChangeNotifier {
  List<Product> productList = [];
  getProducts() async {
    var url = Uri.parse('http://192.168.18.4/myshop/php/loadproducts.php');
    var response = await http.get(url);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200 && data['status'] == 'success') {
      data = data['data']['products'];

      productList =
          data.map<Product>((item) => Product.fromJson(item)).toList();
      notifyListeners();
    }
  }

  Future<bool> addProduct(Product product, File imageFile) async {
    String base64Image = base64Encode(imageFile.readAsBytesSync());
    var url = Uri.parse('http://192.168.18.4/myshop/php/newproduct.php');
    var response = await http.post(url, body: {
      'productName': product.productName,
      'productType': product.productType,
      'price': product.price.toString(),
      'quantity': product.quantity.toString(),
      'encoded_base64string': base64Image,
    });
    if (response.body == 'success') {
      getProducts();
      return true;
    }
    return false;
  }
}
