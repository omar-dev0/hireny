import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/services/domain/models/request/service_post_request.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/features/services/domain/usecases/add_service_org_post.dart';
import 'package:hireny/features/services/domain/usecases/delete_service.dart';
import 'package:hireny/features/services/domain/usecases/get_services.dart';
import 'package:hireny/features/services/domain/usecases/update_service.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import 'service_org_states.dart';
import 'package:hireny/result.dart'; // Make sure this is the correct import for Result

@injectable
class ServiceOrgCubit extends Cubit<ServiceOrgStates> {
  final AddServiceOrgPost addServiceOrgPost;
  final GetServicesOrg getServicesOrg;
  final DeleteService deleteUseCase;
  final UpdateService updateUseCase;

  ServiceOrgCubit(this.addServiceOrgPost, this.getServicesOrg, this.deleteUseCase, this.updateUseCase) : super(InitServiceOrg());

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
  void setFields(ServiceResponse service) {
    titleController.text = service.serviceTitle;
    priceController.text = service.salary.toString(); // Make sure it's a String
    currencyController.text = service.currency.isNotEmpty ? service.currency.first : '';
    descriptionController.text = service.serviceDescription;

    // Set dropdown values safely
    selectedCategory = service.category.isNotEmpty ? service.category.first : null;
    selectedCountry = service.country;
    selectedCity = service.city;

    emit(SuccessSetItems());
  }

  String formatCreatedAt(String isoTime) {
    final dateTime = DateTime.parse(isoTime).toLocal();
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays >= 1) {
      return '${diff.inDays}d ${diff.inHours.remainder(24)}h ago';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h ${diff.inMinutes.remainder(60)}m ago';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}m ago';
    } else {
      return 'just now';
    }
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
          organization: AppSharedData.user?.id?.toInt(),
        );

        final result = await addServiceOrgPost.call(service);

      } catch (e) {
        emit(ErrorServiceOrg("Unexpected error occurred: $e"));

      }
    } else {
      emit(ErrorServiceOrg("Please complete all required fields"));

    }
  }
  Future<void> loadServices() async {


    emit(LoadingServiceOrg());

    try {
      final userId = 8;//AppSharedData.user?.id
      if (userId == null) {
        emit(ErrorServiceOrg("User not logged in."));
        return;
      }

      final result = await getServicesOrg.call(userId);
      debugPrint(result.runtimeType as String?);

      if (result is Success) {
        AppSharedData.servicesOrg.clear();
        AppSharedData.servicesOrg.addAll(result.response);
        emit(SuccessServiceOrg());
      } else if (result is Error) {
        emit(ErrorServiceOrg(result.error));
      }
    } catch (e) {
      emit(ErrorServiceOrg("Error loading services: $e"));
    }
  }
  Future<void> deleteService(int serviceId) async {
    emit(LoadingServiceOrg());
    try {
      final result = await deleteUseCase.call(serviceId);

      if (result is Success) {
        // 🔹 Remove locally
        AppSharedData.servicesOrg.removeWhere((s) => s.id == serviceId);
        emit(SuccessServiceOrg());
      } else if (result is Error) {
        emit(ErrorServiceOrg(result.error));
      }
    } catch (e) {
      emit(ErrorServiceOrg("Error deleting service: $e"));
    }
  }


  Future<void> updateServiceOrg(ServiceResponse service) async {
    emit(LoadingServiceOrg());

    try {
      final double? salary = double.tryParse(priceController.text);
      if (salary == null) {
        emit(ErrorServiceOrg("Invalid salary input."));
        return;
      }
      final serviceUpdated = ServiceRequestModel(
        serviceTitle: titleController.text,
        salary: salary,
        serviceDescription: descriptionController.text,
        category: [selectedCategory!],
        country: [selectedCountry!],
        city: [selectedCity!],
        currency: [currencyController.text],
        serviceAvailable: service.serviceAvailable,
        organization: service.organization,
      );

      final result = await updateUseCase.call(service.id, serviceUpdated);

      if (result is Success) {
        // // Update local list
        final index = AppSharedData.servicesOrg.indexWhere((s) => s.id == service.id);
        if (index != -1) {
          AppSharedData.servicesOrg[index] = ServiceResponse(
            serviceTitle: titleController.text,
            salary: "salary",
            serviceDescription: descriptionController.text,
            category: [selectedCategory!],
            country: selectedCountry!,
            city: selectedCity!,
            currency: [currencyController.text],
            companyLogo: service.companyLogo,
            companyName: service.companyName,
            createdAt: service.createdAt,
            id: service.id,
            organization: service.organization,
            serviceAvailable: service.serviceAvailable,
            totalApplications: service.totalApplications,
            updatedAt: DateTime.now().toIso8601String(),
          );
        }

        emit(SuccessServiceOrg());
      } else if (result is Error) {
        emit(ErrorServiceOrg(result.error));
      }
    } catch (e) {
      emit(ErrorServiceOrg("Error updating service: $e"));
    }
  }

}

