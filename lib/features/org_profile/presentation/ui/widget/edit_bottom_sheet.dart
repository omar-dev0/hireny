import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/custom_text_field.dart';

Future<String?> showEditReviewBottomSheet({
  required BuildContext context,
  required String initialText,
  required Function(String) onEdit,
}) async {
  final controller = TextEditingController(text: initialText);
  return await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      return FadeInUp(
        duration: const Duration(milliseconds: 400),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElasticIn(
                  child: Container(
                    width: 60,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Edit Review",
                  style: AppFonts.mainText.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: controller,
                  hint: "Update your review here...",
                  minLines: 4,
                  maxLines: 6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      onEdit.call(controller.text);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      );
    },
  );
}
