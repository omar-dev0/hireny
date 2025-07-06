import 'package:flutter/material.dart';

void showSkillSearchDialog(BuildContext context, List<String> allSkills, Function(String) onSkillSelected) {
  showDialog(
    context: context,
    builder: (context) {
      TextEditingController searchController = TextEditingController();
      List<String> filteredSkills = List.from(allSkills);

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Text("Search Skills"),
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
                        filteredSkills = allSkills
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
                            onSkillSelected(filteredSkills[index]);
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
