import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:students_app/core/colors.dart';
import 'package:students_app/core/constants.dart';
import 'package:students_app/model/student_model.dart';
import 'package:students_app/view/widgets/cutsom_buttons.dart';

import '../form/entry_form.dart';
import '../form/widgets/text_button_widget.dart';
import 'widget/details_text_widget.dart';

// ignore: must_be_immutable
class StudentDetails extends StatelessWidget {
  StudentDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  int index;

  Box<Student> studentBox = Hive.box<Student>(boxName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: ValueListenableBuilder<Box<Student>>(
        valueListenable: studentBox.listenable(),
        builder: (context, Box<Student> box, _) {
          Student? student;
          try {
            student = box.getAt(index);
          } catch (e) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              kHeight40,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      icon: Icons.arrow_back_rounded,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    NeumorphicText(
                      "${student!.firstName} ${student.lastName} ",
                      style: const NeumorphicStyle(
                        depth: 10,
                        intensity: 0.8,
                        color: kGrey,
                      ),
                      textStyle: NeumorphicTextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomButton(
                      icon: Icons.more_vert,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              kHeight40,

              //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Image*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
              Neumorphic(
                padding: const EdgeInsets.all(2),
                style: NeumorphicStyle(
                  color: const Color(0xFFDCE5F6),
                  depth: 10,
                  intensity: 0.8,
                  shape: NeumorphicShape.convex,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(140),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: student.image == null
                      ? const CircleAvatar(
                          radius: 120,
                          backgroundImage:
                              AssetImage("assets/images/profileVector.jpg"),
                        )
                      : CircleAvatar(
                          radius: 120,
                          backgroundImage: FileImage(
                            File(
                              student.image.toString(),
                            ),
                          ),
                        ),
                ),
              ),
              kHeight20,

              //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Details*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Neumorphic(
                  padding: const EdgeInsets.all(2),
                  style: NeumorphicStyle(
                    color: const Color(0xFFDCE5F6),
                    depth: 10,
                    intensity: 0.8,
                    shape: NeumorphicShape.convex,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(10),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10),

                      //<<<<<Student_Details>>>>>//
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              DetailsTextWidget(text: "Name"),
                              DetailsTextWidget(text: "Batch"),
                              DetailsTextWidget(text: "Age"),
                              DetailsTextWidget(text: "Mobile"),
                              DetailsTextWidget(text: "Email"),
                            ],
                          ),
                          Column(
                            children: const [
                              DetailsTextWidget(text: ":"),
                              DetailsTextWidget(text: ":"),
                              DetailsTextWidget(text: ":"),
                              DetailsTextWidget(text: ":"),
                              DetailsTextWidget(text: ":"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailsTextWidget(
                                text:
                                    "${student.firstName} ${student.lastName} ",
                              ),
                              DetailsTextWidget(text: student.batch),
                              DetailsTextWidget(text: student.age.toString()),
                              DetailsTextWidget(
                                  text: student.mobile.toString()),
                              DetailsTextWidget(
                                text: student.email,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              kHeight20,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Edit_Buttons*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButtonWidget(
                      icon: Icons.edit_rounded,
                      text: " Edit",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EntryForm(
                              index: index,
                              isEditing: true,
                              student: student,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Delete_Buttons*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: TextButtonWidget(
                      icon: CupertinoIcons.delete_simple,
                      text: " Delete",
                      onTap: () {
                        //
                        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Delete_Function*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                        studentBox.deleteAt(index);

                        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Snackbar*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: NeumorphicText(
                              "Student Deleted Successfully",
                              style: const NeumorphicStyle(
                                depth: 10,
                                intensity: 0.8,
                                color: Colors.redAccent,
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
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
