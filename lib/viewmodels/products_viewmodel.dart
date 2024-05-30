import 'package:dars47/models/product.dart';
import 'package:dars47/repositories/products_repository.dart';
import 'package:flutter/material.dart';

class ProductsViewmodel {
  final productsRepository = ProductsRepository();
  List<Product> _list = [
    Product(
      id: "1",
      title: "iPhone 11",
      price: 200,
      amount: 13,
      image:
          "https://www.apple.com/newsroom/images/product/iphone/standard/Apple_iphone_11-rosette-family-lineup-091019_big.jpg.large.jpg",
    ),
  ];

  Future<List<Product>> get list async {
    _list = await productsRepository.getProducts();
    return [..._list];
  }

  Future<void> addProduct(
    String title,
    double price,
    int amount,
    String image,
  ) async {
    final newProduct = await productsRepository.addProduct(
      title,
      price,
      amount,
      image,
    );
    if (newProduct != null) {
      _list.add(newProduct);
    }
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    double newPrice,
    int newAmount,
    String newImage,
  ) async {
    await productsRepository.editProduct(
        id, newTitle, newPrice, newAmount, newImage);
    final index = _list.indexWhere((product) {
      return product.id == id;
    });
    _list[index].title = newTitle;
    _list[index].price = newPrice;
    _list[index].amount = newAmount;
    _list[index].image = newImage;
  }

  void deleteProduct(String id) async {
    _list.removeWhere((product) {
      return product.id == id;
    });
    productsRepository.deleteProduct(id);
  }
}
