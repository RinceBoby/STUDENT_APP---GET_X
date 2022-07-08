// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:students_app/core/constants.dart';
import 'package:students_app/view/widgets/capitalise.dart';
import 'package:students_app/view/widgets/cutsom_buttons.dart';

import '../../core/colors.dart';
import '../../model/student_model.dart';
import 'widgets/text_button_widget.dart';
import 'widgets/text_from_field_widget.dart';

// ignore: must_be_immutable
class EntryForm extends StatefulWidget {
  EntryForm({
    Key? key,
    this.isEditing = false,
    this.student,
    this.index,
  }) : super(key: key);

  bool isEditing;
  Student? student;
  int? index;

  @override
  State<EntryForm> createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController mobileController = TextEditingController();

  TextEditingController batchController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Form_Key*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  final _formKey = GlobalKey<FormState>();

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Image*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  XFile? xFile;
  String? imagePath;

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Box*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  Box<Student> studentBox = Hive.box<Student>(boxName);

  @override
  void initState() {
    if (widget.isEditing) {
      firstNameController.text = widget.student!.firstName;
      lastNameController.text = widget.student!.lastName;
      batchController.text = widget.student!.batch;
      mobileController.text = widget.student!.mobile.toString();
      ageController.text = widget.student!.age.toString();
      emailController.text = widget.student!.email;
      imagePath = widget.student!.image.toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Column(
        children: [
          kHeight30,
          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*AppBar*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
            child: Row(
              children: [
                CustomButton(
                  icon: Icons.arrow_back_rounded,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Neumorphic(
                      padding: const EdgeInsets.all(2),
                      style: NeumorphicStyle(
                        color: kBgColor,
                        depth: 10,
                        intensity: 0.8,
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10),
                        ),
                      ),

                      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Entry_From*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                      child: _buildAddStudentFormWidget(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
//======================================================================================================================//
//=======================================================>METHOD<=======================================================//
//======================================================================================================================//

  _buildAddStudentFormWidget(BuildContext context) {
    return Column(
      children: [
        kHeight20,
        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Image*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
        Stack(
          children: [
            Neumorphic(
              padding: const EdgeInsets.all(2),
              style: NeumorphicStyle(
                color: const Color(0xFFDCE5F6),
                depth: 10,
                intensity: 0.8,
                shape: NeumorphicShape.convex,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(90),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: imagePath == null
                    ? const CircleAvatar(
                        radius: 80,
                        backgroundImage:
                            AssetImage("assets/images/profileVector.jpg"),
                      )
                    : CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(
                          File(imagePath!),
                        ),
                      ),
              ),
            ),
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Camera_Button*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//

            Positioned(
              left: 120,
              top: 132,
              child: Neumorphic(
                padding: const EdgeInsets.all(0),
                style: NeumorphicStyle(
                  color: const Color(0xFFDCE5F6),
                  depth: 10,
                  intensity: 0,
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(90),
                  ),
                ),
                child: IconButton(
                  onPressed: () async {
                    ImagePicker imagePicker = ImagePicker();
                    xFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    if (xFile == null) return;
                    imagePath = xFile!.path;
                    setState(() {});
                  },
                  icon: const Icon(
                    CupertinoIcons.camera_on_rectangle_fill,
                    color: kGrey,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
        kWidth05,
        kHeight20,

        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Form*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*First_Name*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                Neumorphic(
                  style: NeumorphicStyle(
                    color: const Color(0xFFDCE5F6),
                    depth: 8,
                    intensity: 0.9,
                    shape: NeumorphicShape.concave,
                    lightSource: LightSource.bottom,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: TextFormFieldWidget(
                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Validation*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                    validator: (value) {
                      String patttern = r'(^[a-z A-Z]+$)';
                      RegExp regExp = RegExp(patttern.toString());
                      if (value.length == 0) {
                        return "Enter your name";
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter a valid name';
                      } else {
                        return null;
                      }
                    },
                    controller: firstNameController,
                    name: "First Name",
                    prefixIcon: CupertinoIcons.person,
                    keyboardType: TextInputType.text,
                  ),
                ),
                kHeight10,

                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Last_Name*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                Neumorphic(
                  style: NeumorphicStyle(
                    color: const Color(0xFFDCE5F6),
                    depth: 8,
                    intensity: 0.9,
                    shape: NeumorphicShape.concave,
                    lightSource: LightSource.bottom,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: TextFormFieldWidget(
                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Validation*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                    validator: (value) {
                      String patttern = r'(^[a-z A-Z]+$)';
                      RegExp regExp = RegExp(patttern.toString());
                      if (value.length == 0) {
                        return "Enter your name";
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter a valid name';
                      } else {
                        return null;
                      }
                    },
                    controller: lastNameController,
                    name: "Last Name",
                    prefixIcon: CupertinoIcons.person_2,
                    keyboardType: TextInputType.text,
                  ),
                ),
                kHeight10,

                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Batch*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          color: const Color(0xFFDCE5F6),
                          depth: 8,
                          intensity: 0.9,
                          shape: NeumorphicShape.concave,
                          lightSource: LightSource.bottom,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10),
                          ),
                        ),
                        child: TextFormFieldWidget(
                          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Validation*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                          validator: (value) {
                            if (value == "") {
                              return "Field is required";
                            }
                            return null;
                          },
                          controller: batchController,
                          name: "Batch",
                          prefixIcon: CupertinoIcons.person_2_square_stack,
                          keyboardType: TextInputType.text,
                        ),
                      ),
                    ),
                    kWidth05,

                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Age*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.32,
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          color: const Color(0xFFDCE5F6),
                          depth: 8,
                          intensity: 0.9,
                          shape: NeumorphicShape.concave,
                          lightSource: LightSource.bottom,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(10),
                          ),
                        ),
                        child: TextFormFieldWidget(
                          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Validator*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                          validator: (value) {
                            if (value.isEmpty || value == null) {
                              return "Required Field";
                            } else if (value.length < 2 || value.length > 2) {
                              return "Under age to join";
                            } else if (int.parse(value) < 17 ||
                                int.parse(value) > 45) {
                              return "Must be b/w 18-45";
                            } else {
                              return null;
                            }
                          },
                          controller: ageController,
                          name: "Age",
                          prefixIcon: CupertinoIcons.list_number_rtl,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                kHeight10,

                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Mobile*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                Neumorphic(
                  style: NeumorphicStyle(
                    color: const Color(0xFFDCE5F6),
                    depth: 8,
                    intensity: 0.9,
                    shape: NeumorphicShape.concave,
                    lightSource: LightSource.bottom,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: TextFormFieldWidget(
                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Validation*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                    validator: (value) {
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                      RegExp regExp = RegExp(patttern.toString());
                      if (value.length == 0) {
                        return "Required Field";
                      } else if (!regExp.hasMatch(value)) {
                        return 'Please enter valid mobile number';
                      } else {
                        return null;
                      }
                    },
                    controller: mobileController,
                    name: "Mobile No",
                    prefixIcon: CupertinoIcons.device_phone_portrait,
                    keyboardType: TextInputType.phone,
                  ),
                ),
                kHeight10,

                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Email*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                Neumorphic(
                  style: NeumorphicStyle(
                    color: const Color(0xFFDCE5F6),
                    depth: 8,
                    intensity: 0.9,
                    shape: NeumorphicShape.concave,
                    lightSource: LightSource.bottom,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: TextFormFieldWidget(
                    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Validation*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                    validator: (value) {
                      Pattern pattern =
                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = RegExp(pattern.toString());
                      if (value.isEmpty || value == null) {
                        return "Required Field";
                      } else if (!regex.hasMatch(value)) {
                        return "Enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    name: "Email",
                    prefixIcon: CupertinoIcons.mail,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                kHeight30,

                //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Submit_Button*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                TextButtonWidget(
                  icon: CupertinoIcons.person_add_solid,
                  text: widget.isEditing ? "Update Student" : " Add Student",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Student newStudent = Student(
                        firstName: firstNameController.text.capitalise(),
                        lastName: lastNameController.text.capitalise(),
                        batch: batchController.text.toUpperCase(),
                        age: int.parse(ageController.text),
                        mobile: int.parse(mobileController.text),
                        email: emailController.text,
                        image: imagePath,
                      );

                      if (widget.isEditing) {
                        studentBox.putAt(widget.index!, newStudent);
                      } else {
                        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Adding_to_Box*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                        studentBox.add(newStudent);
                      }

                      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Snackbar*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: NeumorphicText(
                            widget.isEditing
                                ? "Student details updated"
                                : "Student added successfully",
                            style: const NeumorphicStyle(
                              depth: 10,
                              intensity: 0.8,
                              color: Colors.green,
                            ),
                            textStyle: NeumorphicTextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: kBgColor,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 6.0,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        kHeight20,
      ],
    );
  }
}
