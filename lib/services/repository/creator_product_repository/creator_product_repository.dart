import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
import 'package:itzel/services/api/api_post_services.dart';
import 'package:itzel/utils/app_all_log/error_log.dart';
import 'package:itzel/widgets/app_snack_bar/app_snack_bar.dart';
import 'package:mime/mime.dart';

import '../../../constants/app_api_url.dart';
import '../../../models/get_all_product_model.dart';
import '../../../models/single_product_model.dart';
import '../../api/api_get_services.dart';

class ProductRepository {
  Future<dynamic> sellProduct({
    required File? imageFile,
    required Map<String, dynamic> productData,
  }) async {
    try {
      // Prepare form data
      FormData formData = FormData.fromMap(productData);

      // Add image if exists
      if (imageFile != null) {
        String originalFileName = imageFile.path.split('/').last;
        String? mimeType = lookupMimeType(imageFile.path);

        // Validate file extension before sending
        String fileExtension = originalFileName.split('.').last.toLowerCase();
        if (!['jpeg', 'png', 'jpg'].contains(fileExtension)) {
          throw Exception(
              'Invalid file type. Only .jpeg, .png, .jpg are supported.');
        }

        formData.files.add(MapEntry(
          'image',
          await MultipartFile.fromFile(
            imageFile.path,
            filename: originalFileName,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        ));
      }

      final response = await ApiPostServices().apiPostServices(
        url: AppApiUrl.creatorSellProduct,
        body: formData,
        statusCode: 200,
      );

      return response;
    } catch (e) {
      if (e is DioException) {
        final errorMessage =
            e.response?.data['message'] ?? 'Something went wrong';
        errorLog('Product posting error: ${e.response?.data}', e);
        AppSnackBar.error("Error: $errorMessage");
      } else {
        errorLog('Unexpected error: ${e.toString()}', e);
        AppSnackBar.error(
            "Something went wrong while posting product: ${e.toString()}");
      }
      return null;
    }
  }

  Future<List<AllProduct>?> fetchAllProducts() async {
    try {
      final response = await ApiGetServices().apiGetServices(
        '${AppApiUrl.baseUrl}${AppApiUrl.getAllProduct}',
      );

      // Log the response for debugging
      errorLog('API Response:', response);

      if (response != null && response['success'] == true) {
        // Extract the 'data' list from the response
        final productList = response['data']?['data'] as List<dynamic>?;

        if (productList != null) {
          return productList
              .map((product) => AllProduct.fromJson(product))
              .toList();
        } else {
          AppSnackBar.error('No products found');
          return null;
        }
      } else {
        final errorMessage = response?['message'] ?? 'Failed to fetch products';
        errorLog('Error Message:', errorMessage);
        AppSnackBar.error(errorMessage);
        return null;
      }
    } catch (e) {
      errorLog('Exception while fetching products:', e);
      AppSnackBar.error('Something went wrong while fetching products');
      return null;
    }
  }

  Future<SingleProduct?> fetchProductDetails(String productId) async {
    try {
      final response = await ApiGetServices().apiGetServices(
        '${AppApiUrl.baseUrl}${AppApiUrl.getAllProduct}$productId',
      );

      // Log the response for debugging
      errorLog('Product Details API Response:', response);

      if (response != null && response['success'] == true) {
        return SingleProduct.fromJson(response['data']);
      } else {
        final errorMessage =
            response?['message'] ?? 'Failed to fetch product details';
        errorLog('Error Message:', errorMessage);
        AppSnackBar.error(errorMessage);
        return null;
      }
    } catch (e) {
      errorLog('Exception while fetching product details:', e);
      AppSnackBar.error('Something went wrong while fetching product details');
      return null;
    }
  }
}
