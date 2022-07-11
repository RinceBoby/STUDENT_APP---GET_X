import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../core/colors.dart';

class DetailsTextWidget extends StatelessWidget {
  const DetailsTextWidget({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: NeumorphicText(
        text,
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
    );
  }
}
