import 'package:athar_project/core/models/products_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var product = Rxn<ProductsModel>();

  @override
  void onInit() {
    fetchProduct();
    super.onInit();
  }

  void fetchProduct() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse('https://fakestoreapi.com/products/1'),
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        product.value = ProductsModel.fromJson(data);
      } else {
        Get.snackbar('Error', 'Failed to load product');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
