import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../core/colors.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    Key? key,
    required this.text,
    this.icon = null,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      padding: const EdgeInsets.all(2),
      style: NeumorphicStyle(
        color: const Color(0xFFDCE5F6),
        depth: 10,
        intensity: 0.8,
        shape: NeumorphicShape.concave,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(10),
        ),
      ),
      child: NeumorphicButton(
        minDistance: -10,
        onPressed: () {},
        padding: const EdgeInsets.all(15),
        style: NeumorphicStyle(
          color: const Color(0xFFE3ECFD),
          depth: 10,
          intensity: 0.8,
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(10),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: kGrey,
              ),
              NeumorphicText(
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
            ],
          ),
        ),
      ),
    );
  }
}
