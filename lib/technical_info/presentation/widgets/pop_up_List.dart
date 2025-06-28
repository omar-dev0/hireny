import 'package:flutter/material.dart';

import '../../../utils/constants/app_colors.dart';

void showSkillSearchDialog(BuildContext context, List<String> items) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController searchController = TextEditingController();
      List<String> filteredSkills = List.from(items);
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("Search"),
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
                        filteredSkills = items
                            .where((skill) => skill.toLowerCase().contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredSkills.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredSkills[index]),
                          onTap: () {
                            // onSkillSelected(filteredSkills[index]);
                            Navigator.pop(context); // close popup
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
