import 'dart:convert';
import 'dart:developer';

import 'package:athar_project/admin/core/model/login_admin_model.dart';
import 'package:athar_project/volunter/core/model/login_volunteer_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

// class StorageService {
//   GetStorage storage = GetStorage();

//   ///Keys storage
//   static const User_Basic_info = "UserBasicInfo";
//   static const Account_Type = "Account_Type";

//   ///Values storage
//   static const Volunteer_User_Account = "Volunteer_User_Account";
//   static const Employee_Account = "Employee_Account";
//   static const NA_Account = "NA_Account";

//   void setLoginAccountType(bool isEmployee) => storage.write(
//     Account_Type,
//     isEmployee ? Employee_Account : Volunteer_User_Account,
//   );

//   Future logOut() async => await storage.erase();

//   // Future fullLogOut() async {
//   //   await logOut();
//   //   return await Get.offAll(() => LoginView());
//   // }

//   String getAccountType() {
//     if (GetUtils.isNull(storage.read(Account_Type))) {
//       return NA_Account;
//     } else {
//       return storage.read(Account_Type);
//     }
//   }

//   bool get isCompleteLoginAccount =>
//       (getAccountType() == Volunteer_User_Account ||
//           getAccountType() == Employee_Account);

//   ///---------------------------------------------------------------------------
//   Future storeVolunteerTokenInfo(LoginVolunteerModel loginModel) async {
//     await storage.write(User_Basic_info, json.encode(loginModel.toJson()));
//     // await storage.write(Token, json.encode(loginModel.data!.token));
//   }

//   LoginVolunteerModel getVolunteerTokenInfo() {
//     try {
//       log(
//         storage.read(User_Basic_info).toString(),
//         name: "Token |||||||||||||||||||||||||||||||||",
//       );
//       return LoginVolunteerModel.fromJson(
//         json.decode(storage.read(User_Basic_info)),
//       );
//       // return storage.read(Token);
//     } catch (e) {
//       print(e.toString());
//       return LoginVolunteerModel();
//     }
//   }

//   Future storeEmployeeTokenInfo(LoginAdminModel loginModel) async {
//     await storage.write(User_Basic_info, json.encode(loginModel.toJson()));
//     // await storage.write(Token, json.encode(loginModel.data!.token));
//   }

//   LoginAdminModel getEmployeeTokenInfo() {
//     try {
//       log(
//         storage.read(User_Basic_info).toString(),
//         name: "Token |||||||||||||||||||||||||||||||||",
//       );
//       return LoginAdminModel.fromJson(
//         json.decode(storage.read(User_Basic_info)),
//       );
//       // return storage.read(Token);
//     } catch (e) {
//       print(e.toString());
//       return LoginAdminModel();
//     }
//   }
// }
class StorageService {
  GetStorage storage = GetStorage();

  ///Keys
  static const Account_Type = "Account_Type";
  static const Volunteer_Basic_Info = "VolunteerBasicInfo";
  static const Employee_Basic_Info = "EmployeeBasicInfo";

  /// Account Types
  static const Volunteer_User_Account = "Volunteer_User_Account";
  static const Employee_Account = "Employee_Account";
  static const NA_Account = "NA_Account";

  void setLoginAccountType(bool isEmployee) {
    storage.write(
      Account_Type,
      isEmployee ? Employee_Account : Volunteer_User_Account,
    );
  }

  String getAccountType() {
    return storage.read(Account_Type) ?? NA_Account;
  }

  bool get isCompleteLoginAccount =>
      (getAccountType() == Volunteer_User_Account ||
          getAccountType() == Employee_Account);

  Future logOut() async => await storage.erase();

  /// ------------------ Volunteer -------------------
  Future storeVolunteerTokenInfo(LoginVolunteerModel loginModel) async {
    await storage.write(Volunteer_Basic_Info, json.encode(loginModel.toJson()));
  }

  LoginVolunteerModel getVolunteerTokenInfo() {
    try {
      return LoginVolunteerModel.fromJson(
        json.decode(storage.read(Volunteer_Basic_Info)),
      );
    } catch (e) {
      print("getVolunteerTokenInfo Error: $e");
      return LoginVolunteerModel();
    }
  }

  /// ------------------ Employee (Admin) -------------------
  Future storeEmployeeTokenInfo(LoginAdminModel loginModel) async {
    await storage.write(Employee_Basic_Info, json.encode(loginModel.toJson()));
  }

  LoginAdminModel getEmployeeTokenInfo() {
    try {
      return LoginAdminModel.fromJson(
        json.decode(storage.read(Employee_Basic_Info)),
      );
    } catch (e) {
      print("getEmployeeTokenInfo Error: $e");
      return LoginAdminModel();
    }
  }
}
