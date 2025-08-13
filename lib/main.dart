import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_showcase_exp/views/home_view.dart';
import 'package:re_showcase_exp/secondary_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple), useMaterial3: true),
      home: const HomeView(),
      getPages: [GetPage(name: '/presentation', page: () => const SecondaryDisplayWidget())],
    );
  }
}
