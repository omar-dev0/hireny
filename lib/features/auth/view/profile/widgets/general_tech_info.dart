import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/sideBar.dart';
import '../../../../../routes/page_route.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/widgets/custom_text_field.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_states.dart';

class GeneralTechInfo extends StatefulWidget {
  const GeneralTechInfo({super.key});

  @override
  State<GeneralTechInfo> createState() => _GeneralTechInfoState();
}

class _GeneralTechInfoState extends State<GeneralTechInfo> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text(
          'Personal Info',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: AppColors.primary),
        //   actions: [
        //     BlocBuilder<UserCubit, UserStates>(
        //       builder: (context, state) {
        //         return IconButton(
        //           icon: const Icon(Icons.add),
        //           onPressed: manager.addFieldPair,
        //           color: AppColors.primary,
        //         );
        //       },
        //     ),
        //   ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: cubit.formTechKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                CustomTextField(
                  controller: cubit.titleController,
                  hint: "Enter your title",
                  keyboardType: TextInputType.name,
                  onValidate: (value) => cubit.validateText(value, "title"),
                ),
                const SizedBox(height: 16),
                Text(
                  "Career level",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                DropdownButtonFormField2(
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      color: AppColors.grey.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: "-- Choose your career level --",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AppColors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AppColors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  items:
                      cubit.careerLevels
                          .map(
                            (level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ),
                          )
                          .toList(),
                  value: cubit.selectedCareerLevel,
                  onChanged: (value) => cubit.setCareerLevel(value),
                  validator:
                      (value) => cubit.validateDropList(value, "career level"),
                ),
                const SizedBox(height: 16),
                Text(
                  "Employment status",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                DropdownButtonFormField2(
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      color: AppColors.grey.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                    ),
                    hintText: "-- Choose your employment status --",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AppColors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: AppColors.grey.withOpacity(0.5),
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  items:
                      cubit.employmentStatusList
                          .map(
                            (level) => DropdownMenuItem(
                              value: level,
                              child: Text(level),
                            ),
                          )
                          .toList(),
                  value: cubit.selectedCareerLevel,
                  onChanged: (value) => cubit.setEmploymentStatus(value),
                  validator:
                      (value) =>
                          cubit.validateDropList(value, "employment status"),
                ),
                const SizedBox(height: 16),
                Text(
                  "Brief",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                CustomTextField(
                  controller: cubit.briefController,
                  hint: "Enter your brief",
                  maxLines: 4,
                  keyboardType: TextInputType.name,
                  onValidate: (value) => cubit.validateText(value, "brief"),
                ),
                const SizedBox(height: 16),

                Row(
                  children: [
                    const Text(
                      "Links",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      onPressed: cubit.addFieldPair,
                    ),
                  ],
                ),
                BlocBuilder<UserCubit, UserStates>(
                  builder: (context, state) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cubit.getLen(),
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: DropdownButtonFormField2(
                                dropdownStyleData: DropdownStyleData(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                decoration: InputDecoration(
                                  hintStyle: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 16,
                                    color: AppColors.grey.withOpacity(0.5),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  hintText: "link type",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide(
                                      color: AppColors.grey.withOpacity(0.5),
                                      width: 1,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: const BorderSide(
                                      color: AppColors.primary,
                                      width: 1,
                                    ),
                                  ),
                                ),

                                items:
                                    cubit.linkTypes
                                        .map(
                                          (link) => DropdownMenuItem(
                                            value: link,
                                            child: Text(link),
                                          ),
                                        )
                                        .toList(),
                                value: cubit.selectedLinkType,
                                onChanged: (value) => cubit.setLinkType(value),
                                validator:
                                    (value) => cubit.validateDropList(
                                      value,
                                      "link type",
                                    ),
                              ),
                            ),

                            const SizedBox(height: 10),
                            CustomTextField(
                              controller: cubit.fieldPairs[index]['link'],
                              hint: "Enter the link",
                              keyboardType: TextInputType.url,
                              onValidate: (value)=>cubit.validateLink(value),
                            ),

                            const SizedBox(height: 10),
                            if (cubit.getLen() > 1)
                              Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => cubit.removeFieldPair(index),
                                ),
                              ),

                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  },
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (cubit.formTechKey.currentState!.validate()) {
                        cubit.formKey.currentState!.save();
                        Navigator.pushNamed(
                          context,
                          PagesRoute.generalInfo,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
