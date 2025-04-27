import 'package:athar_project/core/models/pr1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.product.value == null) {
          return Center(child: Text('No product found.'));
        } else {
          final product = controller.product.value!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(product.image!, height: 150),
                SizedBox(height: 20),
                Text(
                  product.title!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "\$${product.price}",
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(height: 10),
                Text(product.description!),
              ],
            ),
          );
        }
      }),
    );
  }
}
