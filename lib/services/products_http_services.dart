import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dars47/models/product.dart';

class ProductsHttpServices {
  Future<List<Product>> getProducts() async {
    Uri url = Uri.parse(
        "https://lesson46-761b9-default-rtdb.firebaseio.com/products.json");

    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<Product> loadedProducts = [];
    if (data != null) {
      data.forEach((key, value) {
        value['id'] = key;
        loadedProducts.add(Product.fromJson(value));
      });
    }

    return loadedProducts;
  }

  Future<Product?> addProduct(
    String title,
    double price,
    int amount,
    String image,
  ) async {
    Uri url = Uri.parse(
        "https://lesson46-761b9-default-rtdb.firebaseio.com/products.json");

    Map<String, dynamic> productData = {
      "title": title,
      "price": price,
      "amount": amount,
      "image": image,
    };
    final response = await http.post(
      url,
      body: jsonEncode(productData),
    );
    final data = jsonDecode(response.body);
    if (data != null) {
      productData['id'] = data['name'];
      Product newProduct = Product.fromJson(productData);
      return newProduct;
    }

    return null;
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    double newPrice,
    int newAmount,
    String newImage,
  ) async {
    Uri url = Uri.parse(
        "https://lesson46-761b9-default-rtdb.firebaseio.com/products/$id.json");

    Map<String, dynamic> productData = {
      "title": newTitle,
      "price": newPrice,
      "amount": newAmount,
      "image": newImage,
    };
    await http.patch(
      url,
      body: jsonEncode(productData),
    );
  }

  Future<void> deleteProduct(String id) async {
    Uri url = Uri.parse(
        "https://lesson46-761b9-default-rtdb.firebaseio.com/products/$id.json");

    await http.delete(url);
  }
}
