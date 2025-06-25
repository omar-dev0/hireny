import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  final Widget? icon;
  final String label;

  const BulletPoint({
    super.key,
    this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          icon ??
              const Padding(
                padding: EdgeInsets.only(top: 6),
                child: Text(
                  '•',
                  style: TextStyle(fontSize: 20),
                ),
              ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
