// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive/hive.dart';
import 'package:students_app/core/constants.dart';
import 'package:students_app/model/student_model.dart';
import 'package:students_app/view/search/studentSearch.dart';
import 'package:students_app/view/widgets/cutsom_buttons.dart';

import 'widgets/appbar_widget.dart';
import 'widgets/student_list_widget.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Hive_box*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
  Box<Student> studentBox = Hive.box<Student>(boxName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          kHeight40,

          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*AppBar*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: AppBarWidget(),
          ),

          //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Student_List*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
          StudentListWidget(),
        ],
      ),

      //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*Floating_Action_Button*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 40),
        child: CustomButton(
          icon: Icons.search,
          onTap: () => showSearch(context: context, delegate: StudentSearch()),
        ),
      ),
    );
  }
}
