import 'package:flutter/material.dart';
import 'package:re_showcase_exp/secondary_display.dart';

// This is a separate entry point for the presentation display
void presentationMainEntry() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: SecondaryDisplayWidget());
  }
}
