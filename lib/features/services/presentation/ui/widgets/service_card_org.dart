import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_colors.dart';

class ServiceCardOrg extends StatelessWidget {
  final String name;
  final String price;
  final Widget? footer;

  const ServiceCardOrg({
    super.key,
    required this.name,
    required this.price,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.primary),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                price,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ),

          /// 🌟 Centered Service Name
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

          /// 👥 Footer (e.g. avatars) at the bottom
          if (footer != null)
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Center(child: footer!),
            ),

        ],
      ),
    );
  }
}
