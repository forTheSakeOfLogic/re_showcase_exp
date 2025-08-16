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
          // Accept int, string, or map payloads
          if (argument is int) {
            _icon = IconData(argument, fontFamily: 'MaterialIcons');
          } else if (argument is String) {
            final parsed = int.tryParse(argument);
            if (parsed != null) {
              _icon = IconData(parsed, fontFamily: 'MaterialIcons');
            }
          } else if (argument is Map) {
            final dynamic cp = argument['codePoint'] ?? argument['icon'] ?? argument['value'];
            if (cp is int) {
              _icon = IconData(cp, fontFamily: 'MaterialIcons');
            } else if (cp is String) {
              final parsed = int.tryParse(cp);
              if (parsed != null) {
                _icon = IconData(parsed, fontFamily: 'MaterialIcons');
              }
            }
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreen.shade50,
          border: Border.all(color: Colors.pink, width: 2),
        ),
        child: PresentationView(icon: _icon),
      ),
    );
  }
}
