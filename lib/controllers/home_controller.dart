import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:presentation_displays/display.dart';
import 'package:presentation_displays/displays_manager.dart';

class HomeController extends GetxController {
  final Rx<IconData> _selectedIcon = Icons.home.obs;

  IconData get selectedIcon => _selectedIcon.value;

  final DisplayManager _displayManager = DisplayManager();
  List<Display?>? _displays;

  @override
  void onInit() {
    super.onInit();
    // Subscribe to icon changes
    _selectedIcon.listen((icon) {
      _updatePresentation(icon);
    });
  }

  @override
  void onReady() {
    super.onReady();
    _initDisplays();
  }

  void _initDisplays() async {
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      return;
    }
    try {
      debugPrint('Initializing display manager...');
      // Subscribe to connection events to re-show when needed
      _displayManager.connectedDisplaysChangedStream?.listen((event) async {
        debugPrint('Display connection event: $event');
        await Future.delayed(const Duration(milliseconds: 500)); // Give plugin time to settle
        await _tryShowOnExternal();
        // Send icon data after a brief delay
        await Future.delayed(const Duration(milliseconds: 100));
        _updatePresentation(_selectedIcon.value);
      });
      await _tryShowOnExternal();
      // Send initial icon after a brief delay
      await Future.delayed(const Duration(milliseconds: 100));
      _updatePresentation(_selectedIcon.value);
    } catch (e, st) {
      debugPrint('Display init error: $e\n$st');
    }
  }

  Future<void> _tryShowOnExternal() async {
    _displays = await _displayManager.getDisplays();
    if (_displays != null && _displays!.length > 1) {
      final displayId = _displays![1]!.displayId;
      if (displayId != null) {
        final ok = await _displayManager.showSecondaryDisplay(displayId: displayId, routerName: "presentation");
        debugPrint('showSecondaryDisplay => $ok');
      }
    } else {
      debugPrint('No external displays detected');
    }
  }

  void changeIcon(IconData newIcon) {
    _selectedIcon.value = newIcon;
  }

  void _updatePresentation(IconData icon) {
    try {
      _displayManager.transferDataToPresentation(icon.codePoint);
    } catch (e) {
      debugPrint('transferDataToPresentation error: $e');
    }
  }
}
