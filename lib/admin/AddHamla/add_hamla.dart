import 'dart:io';
import 'package:athar_project/admin/AddHamla/add_hamla_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddHamlaPage extends StatefulWidget {
  const AddHamlaPage({Key? key}) : super(key: key);

  @override
  State<AddHamlaPage> createState() => _AddHamlaState();
}

class _AddHamlaState extends State<AddHamlaPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final costController = TextEditingController();
  final volunteersController = TextEditingController();
  final dateController = TextEditingController();
  final toController = TextEditingController();
  final pointsController = TextEditingController();

  final campaignController = Get.put(CampaignController());

  File? _image;

  bool isLoading = false;

  DateTime? selectedDateTime;

  Future<void> pickDateTime(
    BuildContext context,
    TextEditingController controller,
  ) async {
    // Step 1: Pick Date
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date == null) return; // Cancelled

    // Step 2: Pick Time
    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime:
          selectedDateTime != null
              ? TimeOfDay.fromDateTime(selectedDateTime!)
              : TimeOfDay.now(),
    );

    if (time == null) return; // Cancelled

    // Combine date & time
    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    setState(() => selectedDateTime = dateTime);
    setState(
      () =>
          controller.text = DateFormat(
            'yyyy-MM-dd hh:mm:ss',
          ).format(selectedDateTime!),
    );
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future submitForm() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      String name = nameController.text.trim();
      String address = locationController.text.trim();
      String cost = costController.text.trim();
      int volunteers = int.tryParse(volunteersController.text.trim()) ?? 0;
      String date = dateController.text.trim();
      String to = dateController.text.trim();
      int points = int.tryParse(pointsController.text.trim()) ?? 0;

      String status = "active";
      String specializationId = "1";
      String campaignTypeId = "1";
      int teamId = 1;
      int employeeId = 1;

      await campaignController.createCampaign(
        name: nameController.text.trim(),
        address: locationController.text.trim(),
        cost: costController.text.trim(),
        volunteers: int.tryParse(volunteersController.text.trim()) ?? 0,
        date: dateController.text.trim(),
        to: dateController.text.trim(),
        points: int.tryParse(pointsController.text.trim()) ?? 0,
        status: "active",
        specializationId: "1",
        campaignTypeId: "1",
        teamId: 1,
        employeeId: 1,
        // image: _image!,
      );

      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى تعبئة جميع الحقول واختيار صورة'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "إضافة حملة",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromRGBO(0, 51, 102, 1),
        ),
        body:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // imagePicker(),
                        customTextField(nameController, 'اسم الحملة'),
                        customTextField(locationController, 'مكان الحملة'),
                        customTextField(
                          costController,
                          'تكلفة الحملة',
                          type: TextInputType.number,
                        ),
                        customTextField(
                          volunteersController,
                          'عدد المتطوعين',
                          type: TextInputType.number,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () => pickDateTime(context, dateController),
                            child: AbsorbPointer(
                              child: customTextField(
                                dateController,
                                'تاريخ الانطلاق',
                                type: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () => pickDateTime(context, toController),
                            child: AbsorbPointer(
                              child: customTextField(
                                toController,
                                'تاريخ الانتهاء',
                                type: TextInputType.datetime,
                              ),
                            ),
                          ),
                        ),
                        // customTextField(
                        //   dateController,
                        //   'تاريخ الانطلاق (مثال: 2025-06-30)',
                        //   type: TextInputType.datetime,
                        // ),
                        // customTextField(
                        //   toController,
                        //   'تاريخ الانتهاء (مثال: 2025-06-30)',
                        //   type: TextInputType.datetime,
                        // ),
                        customTextField(
                          pointsController,
                          'عدد النقاط',
                          type: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async => await submitForm(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              0,
                              51,
                              102,
                              1,
                            ),
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

  Future<void> pickBirthDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18),
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year - 18),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
      setState(() {});
    }
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
