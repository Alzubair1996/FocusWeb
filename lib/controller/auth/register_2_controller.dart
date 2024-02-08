import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:focusweb/controller/my_controller.dart';
import 'package:focusweb/helpers/services/auth_services.dart';
import 'package:focusweb/helpers/widgets/my_form_validator.dart';
import 'package:focusweb/helpers/widgets/my_validators.dart';

class Register2Controller extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, loading = false;

  @override
  void onInit() {
    super.onInit();
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'first_name',
      required: true,
      label: 'First Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'last_name',
      required: true,
      label: 'Last Name',
      controller: TextEditingController(),
    );
    basicValidator.addField(
      'password',
      required: true,
      validators: [MyLengthValidator(min: 6, max: 10)],
      controller: TextEditingController(),
    );
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      loading = true;
      update();
      var errors = await AuthService.loginUser(basicValidator.getController('password').toString());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/starter');

      loading = false;
      update();
    }
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  void gotoLogin() {
    Get.toNamed('/auth/login1');
  }
}
