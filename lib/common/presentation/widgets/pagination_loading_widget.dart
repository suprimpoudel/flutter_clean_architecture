import 'package:flutter/material.dart';

class PaginationLoadingWidget extends StatelessWidget {
  const PaginationLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
