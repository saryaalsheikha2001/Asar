import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddHamlaPage extends StatefulWidget {
  const AddHamlaPage({Key? key}) : super(key: key);

  @override
  State<AddHamlaPage> createState() => _AddHamlaState();
}

class _AddHamlaState extends State<AddHamlaPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final teamNameController = TextEditingController();
  final locationController = TextEditingController();
  final costController = TextEditingController();
  final volunteersController = TextEditingController();
  final dateController = TextEditingController();
  final pointsController = TextEditingController();

  File? _image;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void submitForm() {
    if (formKey.currentState!.validate() && _image != null) {
      final newCampaign = {
        'name': nameController.text,
        'type': teamNameController.text,
        'location': locationController.text,
        'amount': costController.text,
        'participants': '${volunteersController.text} مشارك',
        'date': dateController.text,
        'points': pointsController.text,
        'image': _image!.path,
      };

      Get.back(result: newCampaign);
    } else {
      Get.snackbar(
        "خطأ",
        "يرجى تعبئة جميع الحقول واختيار صورة",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: Colors.white),
              SizedBox(width: 12),
              Text("إضافة حملة", style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                imagePicker(),
                customTextField(nameController, 'اسم الحملة'),
                customTextField(teamNameController, 'اسم الفريق'),
                customTextField(locationController, 'مكان الحملة'),
                customTextField(
                  costController,
                  'تكلفة الحملة',
                  type: TextInputType.number,
                ),
                customTextField(
                  volunteersController,
                  'عدد المتطوعين المطلوب',
                  type: TextInputType.number,
                ),
                customTextField(dateController, 'تاريخ انطلاق الحملة'),
                customTextField(
                  pointsController,
                  'النقاط المعطاة بالحملة',
                  type: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'إنشاء الحملة',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePicker() {
    return GestureDetector(
      onTap: pickImage,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
        ),
        child:
            _image != null
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(_image!, fit: BoxFit.cover),
                )
                : const Center(child: Text('إضافة شعار')),
      ),
    );
  }

  Widget customTextField(
    TextEditingController controller,
    String label, {
    TextInputType type = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        validator:
            (value) =>
                value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
