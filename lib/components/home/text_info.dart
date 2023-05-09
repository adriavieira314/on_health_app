import 'package:flutter/material.dart';

class TextInfo extends StatelessWidget {
  final String label;
  final String? info;
  final MainAxisAlignment? mainAxisAlignment;

  const TextInfo({
    super.key,
    required this.label,
    required this.info,
    this.mainAxisAlignment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            info!,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}
