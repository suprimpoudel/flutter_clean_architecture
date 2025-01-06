import 'dart:developer';

import 'package:flutter/material.dart';

extension HandleException on BuildContext {
  Future<void> handleException(dynamic error) async {
    return showAdaptiveDialog(
      barrierDismissible: true,
      context: this,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(error.toString()),
      ),
    );
  }
}

extension DisplaySnackbar on BuildContext {
  void displaySnackbar(String? snackbarMessage, {SnackBarAction? action}) {
    if (snackbarMessage?.isNotEmpty == true) {
      try {
        ScaffoldMessenger.of(this)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(snackbarMessage!),
              action: action,
            ),
          );
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
