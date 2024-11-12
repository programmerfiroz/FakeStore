import 'package:fakestore/model/product_model.dart';
import 'package:fakestore/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <ProductModel>[].obs;
  var categoryList = <String>[].obs; // List to store categories
  var selectedCategory = "".obs;

  @override
  void onInit() {
    super.onInit();
    print("ProductController: initialized");
    fetchProducts();
  }

  // Fetch products from API
  void fetchProducts() async {
    try {
      print("ProductController: Fetching products...");
      isLoading(true);

      var products = await ApiService().fetchProducts();
      print("ProductController: Products fetched: ${products.length} items");

      // Assign products and categories to the controller
      productList.assignAll(products);
      categoryList.assignAll(products.map((product) => product.category).toSet().toList()); // Extract unique categories

      print("ProductController: Product List updated: ${productList.length} items");
      print("ProductController: Category List updated: ${categoryList.length} items");

    } catch (e) {
      print("ProductController: Error fetching products: $e");
    } finally {
      isLoading(false);
      print("ProductController: Finished fetching products");
    }
  }

  // Filter products by selected category
  List<ProductModel> getFilteredProducts() {
    if (selectedCategory.value.isEmpty) {
      return productList; // If no category is selected, return all products
    }
    return productList.where((product) => product.category == selectedCategory.value).toList();
  }

  // Method to update selected category
  void filterProductsByCategory(String category) {
    selectedCategory.value = category;
  }
}
