import 'package:flutter/material.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class ContainerInfo extends StatelessWidget {
  final List<String> info;

  const ContainerInfo({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return GridView.builder(
      itemCount: info.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 5,
      ),
      itemBuilder:
          (context, index) => Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.subPrimary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                info[index],
                style: theme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
    );
  }
}
