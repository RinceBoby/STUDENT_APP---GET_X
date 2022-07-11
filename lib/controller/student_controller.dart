import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_app/model/student_model.dart';

class StudentController extends GetxController {
  final studentBox = Hive.box<Student>(boxName);
  String? imagePath;
  XFile? xFile;
  //
  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*List*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  RxList<Student> studentsList = <Student>[].obs;

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Get_Function*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  getStudents() {
    studentsList.value = studentBox.values.toList();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Add_Function*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  addStudent(Student newStudent) {
    studentBox.add(newStudent);
    getStudents();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Update_Function*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  updateStudent(int index, Student newStudent) {
    studentBox.putAt(index, newStudent);
    getStudents();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Delete_Function*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  deleteStudent(int index) {
    studentBox.deleteAt(index);
    getStudents();
  }

  @override
  void onInit() {
    getStudents();
    super.onInit();
  }

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Image_Function*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  final ImagePicker imagePicker = ImagePicker();
  Future pickImage() async {
    xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    imagePath = xFile!.path;
    update();
  }
}
