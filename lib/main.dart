import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_showcase_exp/views/home_view.dart';
import 'package:re_showcase_exp/presentation_main.dart';

void main() {
  runApp(const MyApp());
}

// This pragma tells Flutter to preserve this function for native code to call
@pragma('vm:entry-point')
void presentationMain() => presentationMainEntry();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const HomeView(),
    );
  }
}
