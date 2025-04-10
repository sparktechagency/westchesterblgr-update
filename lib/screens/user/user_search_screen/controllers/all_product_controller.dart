import 'package:get/get.dart';

import '../../../../models/get_all_product_model.dart';
import '../../../../services/repository/creator_product_repository/creator_product_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class AllProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  var products = <AllProduct>[].obs;
  var filteredProducts = <AllProduct>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final fetchedProducts = await _productRepository.fetchAllProducts();
      if (fetchedProducts != null) {
        products.value = fetchedProducts;
        filteredProducts.value = fetchedProducts;
      }
    } catch (e) {
      AppSnackBar.error('Error fetching products');
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String searchTerm) {
    if (searchTerm.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((product) =>
              product.name?.toLowerCase().contains(searchTerm.toLowerCase()) ??
              false)
          .toList();
    }
  }

  void applyFilters({
    String? state,
    String? city,
    double? minPrice,
    double? maxPrice,
  }) {
    filteredProducts.value = products.where((product) {
      // Filter by state (mapped from "Location")
      bool matchesState = state == null ||
          state.isEmpty ||
          (product.state?.toLowerCase().contains(state.toLowerCase()) ?? false);

      // Filter by city
      bool matchesCity = city == null ||
          city.isEmpty ||
          (product.city?.toLowerCase().contains(city.toLowerCase()) ?? false);

      // Filter by price range
      bool matchesPrice = (product.price ?? 0) >= (minPrice ?? 0) &&
          (product.price ?? 0) <= (maxPrice ?? double.infinity);

      return matchesState && matchesCity && matchesPrice;
    }).toList();
  }
}
