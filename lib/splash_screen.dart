import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:students_app/core/colors.dart';
import 'package:students_app/core/constants.dart';
import 'package:students_app/view/home/screen_home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _screenhome();
  }

  _screenhome() async {
    await Future.delayed(
      const Duration(milliseconds: 3000),
      () {},
    );
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Neumorphic(
              padding: const EdgeInsets.all(2),
              style: const NeumorphicStyle(
                color: Color(0xFFDCE5F6),
                depth: 10,
                intensity: 0.8,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.circle(),
              ),
              child:const Padding(
                padding: EdgeInsets.all(30.0),
                child: Icon(
                  CupertinoIcons.person_3,
                  color: kGrey,
                  size: 200,
                ),
              ),
            ),
            kHeight40,
            
            //<<<<<Title>>>>>//
            Neumorphic(
              padding: const EdgeInsets.all(2),
              style: NeumorphicStyle(
                color:const Color(0xFFDCE5F6),
                depth: 10,
                intensity: 0.8,
                shape: NeumorphicShape.concave,
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: NeumorphicText(
                  "STUDENTS APP",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
