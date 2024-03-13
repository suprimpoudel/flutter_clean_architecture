import 'dart:developer';

import 'package:flutter/material.dart';

extension HandleException on BuildContext {
  Future<void> handleException(dynamic error) async {
    return await showAdaptiveDialog(
      barrierDismissible: true,
      context: this,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(
          error.toString(),
        ),
      ),
    );
  }
}

extension DisplaySnackbar on BuildContext {
  Future<void> displaySnackbar(String? snackbarMessage,
      {SnackBarAction? action}) async {
    if (snackbarMessage != null ||
        snackbarMessage?.isNotEmpty == true && mounted) {
      try {
        ScaffoldMessenger.of(this).hideCurrentSnackBar();
        ScaffoldMessenger.of(this).showSnackBar(
          SnackBar(
            content: Text(snackbarMessage ?? ""),
            action: action,
          ),
        );
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
