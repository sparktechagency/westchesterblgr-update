import 'package:get/get.dart';

import '../../../../models/get_all_product_model.dart';
import '../../../../services/repository/creator_product_repository/creator_product_repository.dart';
import '../../../../widgets/app_snack_bar/app_snack_bar.dart';

class AllProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();
  var products = <AllProduct>[].obs;
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
      }
    } catch (e) {
      AppSnackBar.error('Error fetching products');
    } finally {
      isLoading.value = false;
    }
  }
}
