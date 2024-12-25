import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:immersive_commerce/data/models/product.dart';

class ProductRepository {
  final String apiUrl = "https://dummyjson.com/products";

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      final List<dynamic> productList = responseData['products'];

      return productList.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

}
