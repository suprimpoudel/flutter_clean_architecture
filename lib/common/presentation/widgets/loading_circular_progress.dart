import 'package:flutter/material.dart';

class LoadingCircularProgress extends StatelessWidget {
  final String? progressMessage;
  final double? opacity;

  const LoadingCircularProgress({
    super.key,
    this.progressMessage,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        children: [
          Container(
            color: Colors.black.withValues(alpha: opacity ?? 0.5),
            height: double.infinity,
            width: double.infinity,
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
