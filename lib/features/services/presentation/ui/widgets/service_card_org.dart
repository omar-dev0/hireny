import 'package:flutter/material.dart';
import '../../../../../utils/constants/app_colors.dart';

class ServiceCardOrg extends StatelessWidget {
  final String name;
  final String price;
  final String company;
  final String companyLogo;
  final Widget? footer;

  const ServiceCardOrg({
    super.key,
    required this.name,
    required this.price,
    required this.company,
    required this.companyLogo,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Top row: Name & Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Service Name
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              /// Price Badge
              Container(
                margin: const EdgeInsets.only(left: 8),
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
            ],
          ),

          const SizedBox(height: 12),

          /// Spacer between name/price and bottom info
          const Spacer(),

          /// 🏢 Company Info
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(companyLogo),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  company,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 👥 Footer (e.g. avatars row)
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
