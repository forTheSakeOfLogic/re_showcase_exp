import 'package:flutter/material.dart';

class PresentationView extends StatelessWidget {
  final IconData icon;

  const PresentationView({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Icon(icon, size: 200)));
  }
}
