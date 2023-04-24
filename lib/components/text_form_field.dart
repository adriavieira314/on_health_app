import 'package:flutter/material.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String label;
  final String hintText;

  const TextFormFieldComponent({
    super.key,
    required this.label,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {},
            validator: (value) {
              final name = value ?? '';

              if (name.trim().isEmpty) {
                return 'Campo obrigatório.';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
