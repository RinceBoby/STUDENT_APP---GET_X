import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:students_app/model/student_model.dart';
import 'package:students_app/view/details/student_details.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../widgets/cutsom_buttons.dart';

final studentBox = Hive.box<Student>(boxName);
List<Student> studentList = studentBox.values.toList();
List<String> allStudents = [""];

class StudentSearch extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        color: kBgColor,
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back_rounded,
        color: kGrey,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(
          Icons.clear_rounded,
          color: kGrey,
        ),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: NeumorphicText(
        "$query not found!",
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    int index;
    final studentSearch = query.isEmpty
        ? studentList
        : studentList
                .where(
                  (element) => "${element.firstName}${element.lastName}"
                      .toLowerCase()
                      .contains(
                        query.toLowerCase(),
                      ),
                )
                .toList() +
            studentList
                .where(
                  (element) => element.batch.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            kHeight20,
            studentSearch.isEmpty
                ? Center(
                    child: NeumorphicText(
                      "$query not found!",
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
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => kHeight20,
                    itemCount: studentSearch.length,
                    itemBuilder: (context, index) {
                      Student? student = studentBox.getAt(index);
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
                              //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Image*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
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
                                  child: student!.image == null
                                      ? const CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(
                                              "assets/images/profileVector.jpg"),
                                        )
                                      : CircleAvatar(
                                          radius: 30,
                                          backgroundImage: FileImage(File(
                                              studentSearch[index]
                                                  .image
                                                  .toString())),
                                        ),
                                ),
                              ),

                              Column(
                                children: [
                                  //
                                  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_Name*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                  NeumorphicText(
                                    "${studentSearch[index].firstName} ${studentSearch[index].lastName}",
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

                                  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Batch_Name*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                                  NeumorphicText(
                                    studentSearch[index].batch,
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

                              //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Go_To_Details*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
                              CustomButton(
                                icon: CupertinoIcons.forward,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentDetails(
                                        index: studentList.indexWhere(
                                            (element) =>
                                                element.firstName ==
                                                studentSearch[index].firstName),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
