import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webkit/controller/my_controller.dart';
import 'package:webkit/helpers/services/auth_services.dart';
import 'package:webkit/helpers/widgets/my_form_validator.dart';
import 'package:webkit/helpers/widgets/my_validators.dart';

import '../../AdminUsers.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false, isChecked = false;



  final adminusres = <AdminUsers>[AdminUsers(2, 1, "Admin", "false")];


  @override
  void onInit() {
    super.onInit();
    getUSers();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors = await AuthService.loginUser("");
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      } else {
        String nextUrl =
            Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "")
                    .queryParameters['next'] ??
                "/dashboard";
        Get.toNamed(
          nextUrl,
        );
      }
      loading = false;
      update();
    }
  }
  getUSers() async {



    DatabaseReference eventReflocaton =
    FirebaseDatabase.instance.ref("Focus/Admin/User");

    final location1 = <AdminUsers>[];
    try {
    DatabaseEvent snapshot = await eventReflocaton.once();

    Map<dynamic, dynamic>? values1 =
    snapshot.snapshot.value as Map<dynamic, dynamic>;

    List<MapEntry> entries = values1.entries.toList();

// Sort the list based on the 'name' value
    entries.sort((a, b) => (a.value['name']).compareTo(b.value['name']));

// Create a new map with sorted entries
    Map<String, dynamic> sortedMap =
    Map.fromEntries(entries as Iterable<MapEntry<String, dynamic>>);

    sortedMap.forEach((key, value) {



    });
    } catch (error) {
    print('Error: $error');
    }
    AdminUsers location = AdminUsers(
        1,
        1,
        "Admin",
        "true"
      /*
            value['id'],
            value['ida'],
            value['name'],
            value['pramions'].toString()

          */

    );

    location1.add(location);


    adminusres.clear();
    adminusres.addAll(location1);



}

  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.offAndToNamed('/auth/register');
  }
}
