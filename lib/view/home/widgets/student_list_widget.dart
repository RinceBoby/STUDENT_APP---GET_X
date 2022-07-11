import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:students_app/controller/student_controller.dart';
import 'package:students_app/model/student_model.dart';
import 'package:students_app/view/details/student_details.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../widgets/cutsom_buttons.dart';

// ignore: must_be_immutable
class StudentListWidget extends StatelessWidget {
  StudentListWidget({
    Key? key,
  }) : super(key: key);

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Controller*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  StudentController studentController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      //
      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Controller*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
      child: Obx(
        () {
          if (studentController.studentsList.isEmpty) {
            return Center(
              child: NeumorphicText(
                "No Students Added !",
                style: const NeumorphicStyle(
                  depth: 10,
                  intensity: 0.8,
                  color: kGrey,
                ),
                textStyle: NeumorphicTextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            );
          } else {
            //
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_List_View*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
            return ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => kHeight20,
              itemCount: studentController.studentsList.length,
              itemBuilder: (context, index) {
                Student studentLst = studentController.studentsList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Neumorphic(
                    padding: const EdgeInsets.all(10),
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(10),
                      ),
                      lightSource: LightSource.top,
                      depth: 15,
                      intensity: 0.9,
                      color: kNeupColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //
                        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Image*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                        Neumorphic(
                          padding: const EdgeInsets.all(2),
                          style: NeumorphicStyle(
                            color: const Color(0xFFDCE5F6),
                            depth: 10,
                            intensity: 0.8,
                            shape: NeumorphicShape.convex,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(60),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: studentLst.image == null
                                ? const CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(
                                        "assets/images/profileVector.jpg"),
                                  )
                                : CircleAvatar(
                                    radius: 30,
                                    backgroundImage: FileImage(
                                        File(studentLst.image.toString())),
                                  ),
                          ),
                        ),

                        Column(
                          children: [
                            //
                            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Name*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                            NeumorphicText(
                              "${studentLst.firstName} ${studentLst.lastName}",
                              style: const NeumorphicStyle(
                                depth: 10,
                                intensity: 0.8,
                                color: kGrey,
                              ),
                              textStyle: NeumorphicTextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Batch_Name*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                            NeumorphicText(
                              studentLst.batch,
                              style: const NeumorphicStyle(
                                depth: 10,
                                intensity: 0.8,
                                color: kGrey,
                              ),
                              textStyle: NeumorphicTextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),

                        //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Go_To_Details*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                        CustomButton(
                          icon: CupertinoIcons.forward,
                          onTap: () => Get.to(StudentDetails(index: index)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
