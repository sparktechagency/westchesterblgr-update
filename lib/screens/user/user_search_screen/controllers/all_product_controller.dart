import 'dart:async';

import 'package:get/get.dart';

import '../../../../models/get_all_product_model.dart';
import '../../../../services/repository/creator_product_repository/creator_product_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class AllProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  var products = <AllProduct>[].obs;
  var filteredProducts = <AllProduct>[].obs;
  var isLoading = true.obs;
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoadingMore = false.obs;
  final int pageLimit = 10;
  var currentFilters = <String, dynamic>{}.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts({
    bool isLoadMore = false,
    Map<String, dynamic>? filters,
  }) async {
    try {
      if (isLoadMore) {
        isLoadingMore.value = true;
      } else {
        isLoading.value = true;
        currentPage.value = 1;
        if (filters != null) {
          currentFilters.value = filters;
          print('API call with filters: $filters');
        }
      }

      final response = await _productRepository.fetchAllProducts(
        page: currentPage.value,
        limit: pageLimit,
        filters: filters ?? currentFilters.value,
      );

      if (response != null) {
        if (!isLoadMore) {
          products.value = response['products'] as List<AllProduct>;
          totalPages.value = response['totalPages'] as int;
        } else {
          products.addAll(response['products'] as List<AllProduct>);
        }
        filteredProducts.value = products;
        print('API response received: ${products.length} products');
      } else {
        print('API returned null response');
      }
    } catch (e) {
      print('API fetch error: $e');
      AppSnackBar.error('Error fetching products: $e');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void loadMoreProducts() {
    if (currentPage.value < totalPages.value && !isLoadingMore.value) {
      currentPage.value++;
      fetchAllProducts(isLoadMore: true);
    }
  }

  void searchProducts(String searchTerm) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      print('Preparing to hit API with search term: $searchTerm');
      Map<String, dynamic> filters =
          Map<String, dynamic>.from(currentFilters.value);
      if (searchTerm.isEmpty) {
        filters.remove('name');
      } else {
        filters['name'] = searchTerm;
      }
      fetchAllProducts(filters: filters);
    });
  }

  void applyFilters({
    String? state,
    String? city,
    double? minPrice,
    double? maxPrice,
  }) {
    Map<String, dynamic> filters =
        Map<String, dynamic>.from(currentFilters.value);

    if (state != null && state.isNotEmpty) {
      filters['state'] = state;
    } else {
      filters.remove('state');
    }

    if (city != null && city.isNotEmpty) {
      filters['city'] = city;
    } else {
      filters.remove('city');
    }

    if (minPrice != null) {
      filters['minPrice'] = minPrice;
    } else {
      filters.remove('minPrice');
    }

    if (maxPrice != null) {
      filters['maxPrice'] = maxPrice;
    } else {
      filters.remove('maxPrice');
    }

    print('Applying filters and hitting API: $filters');
    fetchAllProducts(filters: filters);
  }

  // New method to reset filters and fetch all data
  Future<void> resetAndFetchAll() async {
    currentFilters.clear();
    print('Filters reset, fetching all products');
    await fetchAllProducts(filters: <String, dynamic>{});
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }
}
