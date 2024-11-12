import 'dart:convert';
import 'package:fakestore/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String _url = "https://fakestoreapi.com/products";

  Future<List<ProductModel>> fetchProducts() async {
    try {
      print("ApiService: Sending request to fetch products from: $_url"); // Log the API request URL
      final response = await http.get(Uri.parse(_url));

      print("ApiService: Response status: ${response.statusCode}"); // Log the status code of the response

      if (response.statusCode == 200) {
        print("ApiService: Successful response received."); // Log when response is successful
        List jsonResponse = json.decode(response.body);
        print("ApiService: Received ${jsonResponse.length} products."); // Log the number of products received

        return jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
      } else {
        print("ApiService: Failed to load products. Status code: ${response.statusCode}"); // Log failure
        return []; // Return an empty list if the request fails
      }
    } catch (e) {
      print("ApiService: Exception: $e"); // Log any errors that occur during the API call
      return []; // Return an empty list in case of error
    }
  }
}
