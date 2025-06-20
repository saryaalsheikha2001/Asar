import 'dart:io';
import 'package:athar_project/admin/profile_for_admin/%D9%90Admin_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImagePicker extends StatelessWidget {
  final AdminProfileController controller;

  ProfileImagePicker(this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: controller.pickedImage != null
                ? FileImage(controller.pickedImage! as File)
                : AssetImage('assets/default_avatar.png') as ImageProvider,
            backgroundColor: Colors.grey[300],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.blue,
              child: Icon(Icons.edit, size: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
