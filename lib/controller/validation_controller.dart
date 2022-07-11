import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:students_app/model/student_model.dart';

class FormValidationController extends GetxController {
  final studentBox = Hive.box<Student>(boxName);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String email = "";

  String? emailValidator(String value) {
    if (value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
  }

  void trySubmit() {
    final isValid = formKey.currentState!.validate();
    Get.focusScope!.unfocus();

    if (isValid) {
      formKey.currentState!.save();
    }
  }
}
