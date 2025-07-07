import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';
import '../manager/technical_info_cubit.dart';
import '../../data/models/response/skill_model.dart';

void showListDialog(
  BuildContext context,
  List<dynamic> items,
  TechnicalInfoCubit cubit, {
  required bool isSkill,
}) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController searchController = TextEditingController();
      List<dynamic> filteredItems = List.from(items);

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Search ${isSkill ? 'Skill' : 'Language'}"),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: "Type to search...",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      setState(() {
                        filteredItems =
                            items.where((item) {
                              final name =
                                  item is String
                                      ? item
                                      : (item is SkillModel
                                          ? item.skillName
                                          : '');
                              return name.toLowerCase().contains(
                                value.toLowerCase(),
                              );
                            }).toList();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final itemName =
                            item is String
                                ? item
                                : (item is SkillModel ? item.skillName : '');

                        return ListTile(
                          title: Text(itemName),
                          onTap: () async {
                            final selectedItem = itemName.toLowerCase().trim();

                            // Create the correct model
                            isSkill
                                ? cubit.selectedSkill = selectedItem
                                : cubit.selectedLang = selectedItem;
                            await cubit.addTechInfo(
                              isSkill: isSkill,
                              isLang: !isSkill,
                            );

                            if (context.mounted) Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Close"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    },
  );
}
