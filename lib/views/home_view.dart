import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:re_showcase_exp/controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(title: const Text('RE Showcase EXP')),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Row(
              children: [
                // Left Panel
                SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => controller.changeIcon(Icons.house_rounded),
                        child: const Text('House'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.changeIcon(Icons.apartment_rounded),
                        child: const Text('Apartment'),
                      ),
                    ],
                  ),
                ),
                // Middle Panel (to be projected)
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 100),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen.shade50,
                      border: Border.all(color: Colors.pink, width: 2),
                    ),
                    child: Center(child: Obx(() => Icon(controller.selectedIcon, size: 100))),
                  ),
                ),
                // Right Panel
                SizedBox(
                  width: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => controller.changeIcon(Icons.cabin_rounded),
                        child: const Text('Cabin'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => controller.changeIcon(Icons.villa_rounded),
                        child: const Text('Villa'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('Please use landscape mode'));
          }
        },
      ),
    );
  }
}
