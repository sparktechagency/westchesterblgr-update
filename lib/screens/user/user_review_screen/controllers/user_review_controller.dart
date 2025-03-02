import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itzel/models/all_organizations_model.dart';
import 'package:itzel/services/repository/category_repository/category_repository.dart';

class UserReviewController extends GetxController {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final String categoryId;
  var organizations = <AllOrganizations>[].obs;
  var isLoading = true.obs;
  var searchController = TextEditingController();

  UserReviewController({required this.categoryId});

  @override
  void onInit() {
    super.onInit();
    fetchOrganizations();
  }

  Future<void> fetchOrganizations() async {
    try {
      isLoading.value = true;
      final fetchedOrganizations =
          await _categoryRepository.fetchOrganizationsByCategory(
        categoryId,
        searchController.text,
      );
      if (fetchedOrganizations != null) {
        organizations.value = fetchedOrganizations;
      } else {
        organizations.clear();
      }
    } catch (e) {
      print('Error fetching organizations: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
