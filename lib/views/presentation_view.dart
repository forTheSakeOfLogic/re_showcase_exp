import 'package:flutter/material.dart';

class PresentationView extends StatelessWidget {
  final IconData icon;

  const PresentationView({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen.shade50,
      body: Center(
        child: Icon(
          icon,
          size: 200,
          color: Colors.black87,
        ),
      ),
    );
  }
}
