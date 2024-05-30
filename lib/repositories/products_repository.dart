import 'package:dars47/models/product.dart';
import 'package:dars47/services/products_http_services.dart';

class ProductsRepository {
  final productsHttpServices = ProductsHttpServices();
  // final productLocalServices = ProductLocalServices();

  Future<List<Product>> getProducts() async {
    // final products = productLocalServices.getProducts();
    // if (products.isEmpty) {
    return productsHttpServices.getProducts();
    // }
    // return products;
  }

  Future<Product?> addProduct(
    String title,
    double price,
    int amount,
    String image,
  ) async {
    return productsHttpServices.addProduct(
      title,
      price,
      amount,
      image,
    );
  }

  Future<void> editProduct(
    String id,
    String newTitle,
    double newPrice,
    int newAmount,
    String newImage,
  ) async {
    return productsHttpServices.editProduct(
      id,
      newTitle,
      newPrice,
      newAmount,
      newImage,
    );
  }

  Future<void> deleteProduct(String id) async {
    return productsHttpServices.deleteProduct(id);
  }
}
