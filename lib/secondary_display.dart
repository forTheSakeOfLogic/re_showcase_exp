import 'package:flutter/material.dart';
import 'package:presentation_displays/secondary_display.dart' as presentation;
import 'package:re_showcase_exp/views/presentation_view.dart';

class SecondaryDisplayWidget extends StatefulWidget {
  const SecondaryDisplayWidget({super.key});

  @override
  State<SecondaryDisplayWidget> createState() => _SecondaryDisplayWidgetState();
}

class _SecondaryDisplayWidgetState extends State<SecondaryDisplayWidget> {
  IconData _icon = Icons.question_mark;

  @override
  Widget build(BuildContext context) {
    return presentation.SecondaryDisplay(
      callback: (argument) {
        setState(() {
          if (argument is int) {
            _icon = IconData(argument, fontFamily: 'MaterialIcons');
          }
        });
      },
      child: PresentationView(icon: _icon),
    );
  }
}
