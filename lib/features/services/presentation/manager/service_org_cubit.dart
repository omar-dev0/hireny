import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/usecases/add_service_org_post.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import 'service_org_states.dart';
import 'package:hireny/result.dart'; // Make sure this is the correct import for Result

@injectable
class ServiceOrgCubit extends Cubit<ServiceOrgStates> {
  final AddServiceOrgPost addServiceOrgPost;

  ServiceOrgCubit(this.addServiceOrgPost) : super(InitServiceOrg());

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  String? selectedCountry;
  String? selectedCity;

  void setCategory(String? value) {
    selectedCategory = value;
    emit(SuccessSetItems());
  }

  void setCountry(String? value) {
    selectedCountry = value;
    selectedCity = null;
    emit(SuccessSetItems());
  }

  void setCity(String? value) {
    selectedCity = value;
    emit(SuccessSetItems());
  }

  Future<void> submitForm(BuildContext context) async {
    if (formKey.currentState!.validate() &&
        selectedCategory != null &&
        selectedCountry != null &&
        selectedCity != null) {
      emit(LoadingServiceOrg());

      try {
        final double? salary = double.tryParse(priceController.text);
        if (salary == null) {
          throw Exception("Invalid salary input.");
        }

        final service = ServiceRequestModel(
          serviceTitle: titleController.text,
          salary: salary,
          serviceDescription: descriptionController.text,
          category: [selectedCategory!],
          country: [selectedCountry!],
          city: [selectedCity!],
          currency: [currencyController.text],
          serviceAvailable: "available",
          organization: AppSharedData.user?.id,
        );

        final result = await addServiceOrgPost.call(service);

      } catch (e) {
        emit(ErrorServiceOrg("Unexpected error occurred: $e"));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else {
      emit(ErrorServiceOrg("Please complete all required fields"));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
    }
  }
}
