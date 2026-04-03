import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:quran_international/View/Screen/HomeScreen/Controller/home_controller.dart';
import 'package:quran_international/View/Screen/BookmarkScreen/Controller/bookmark_controller.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    // Initial check
    _checkInitialConnectivity();
    // Listen for changes
    _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  Future<void> _checkInitialConnectivity() async {
    final List<ConnectivityResult> results = await _connectivity.checkConnectivity();
    updateConnectionStatus(results);
  }

  void updateConnectionStatus(List<ConnectivityResult> results) {
    ConnectivityResult previousStatus = connectionStatus.value;
    
    // Check if any active connection exists in the results
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      connectionStatus.value = ConnectivityResult.none;
    } else {
      connectionStatus.value = results.first;
    }

    // Trigger sync if coming back online
    if (previousStatus == ConnectivityResult.none && connectionStatus.value != ConnectivityResult.none) {
      _triggerBackgroundSync();
      _showStatusSnackBar(isOnline: true);
    } else if (connectionStatus.value == ConnectivityResult.none) {
      _showStatusSnackBar(isOnline: false);
    }
  }

  Future<bool> isConnected() async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none) && results.isNotEmpty;
  }

  void _triggerBackgroundSync() {
    try {
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().refreshData();
      }
      if (Get.isRegistered<BookmarkController>()) {
        Get.find<BookmarkController>().refreshData();
      }
    } catch (e) {
      // Ignored
    }
  }

  void _showStatusSnackBar({required bool isOnline}) {
    // Dismiss any existing snackbars first
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }

    Get.rawSnackbar(
      titleText: Text(
        isOnline ? "Back Online" : "Connection Lost",
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      messageText: Text(
        isOnline ? "Syncing latest data..." : "You are offline. Showing saved data.",
        style: const TextStyle(color: Colors.white70),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: isOnline ? Colors.green.withOpacity(0.9) : Colors.redAccent.withOpacity(0.9),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      borderRadius: 15,
      icon: Icon(isOnline ? Icons.wifi : Icons.wifi_off, color: Colors.white),
      isDismissible: true,
      shouldIconPulse: true,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
