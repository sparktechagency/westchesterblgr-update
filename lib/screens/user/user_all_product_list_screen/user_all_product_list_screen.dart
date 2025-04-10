import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:itzel/screens/user/user_all_product_list_screen/widgets/sell_item_search_widget.dart';
import 'package:itzel/widgets/app_image/app_image.dart';
import 'package:itzel/widgets/button_widget/button_widget.dart';

import '../../../constants/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/appbar_widget/appbar_widget.dart';
import '../../../widgets/space_widget/space_widget.dart';
import '../../../widgets/text_widget/text_widgets.dart';
import '../user_search_screen/controllers/all_product_controller.dart';

class UserAllProductListScreen extends StatefulWidget {
  const UserAllProductListScreen({super.key});

  @override
  _UserAllProductListScreenState createState() =>
      _UserAllProductListScreenState();
}

class _UserAllProductListScreenState extends State<UserAllProductListScreen> {
  final AllProductController controller = Get.put(AllProductController());
  final TextEditingController searchController = TextEditingController();
  final TextEditingController cityController =
      TextEditingController(text: 'New Jersey'); // Controller for city
  final TextEditingController locationController =
      TextEditingController(text: 'New Jersey'); // Controller for location
  bool _isFilterVisible = false; // Toggle filter visibility
  RangeValues _priceRange = const RangeValues(50, 200); // Default price range
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  // Sample list of items (for demonstration)
  final List<Map<String, dynamic>> _items = [
    {
      'name': 'The Unicorn Duckie',
      'price': 23,
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
    {
      'name': 'The Unicorn Duckie',
      'price': 23,
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
    {
      'name': 'The Unicorn Duckie',
      'price': 23,
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
    {
      'name': 'The Unicorn Duckie',
      'price': 23,
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
    {
      'name': 'The Unicorn Duckie',
      'price': 23,
      'address': '2464 Royal Ln. Mesa, New Jersey 45463',
    },
    // Add more items as needed
  ];

  List<Map<String, dynamic>> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_items); // Initialize filtered items
  }

  void _toggleFilter() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _applyFilter() {
    setState(() {
      _filteredItems = _items.where((item) {
        // Case-insensitive search for city and location
        bool matchesCity = cityController.text.isEmpty ||
            item['city']
                .toString()
                .toLowerCase()
                .contains(cityController.text.toLowerCase());
        bool matchesLocation = locationController.text.isEmpty ||
            item['location']
                .toString()
                .toLowerCase()
                .contains(locationController.text.toLowerCase());
        bool matchesPrice = item['price'] >= _priceRange.start &&
            item['price'] <= _priceRange.end;
        return matchesCity && matchesLocation && matchesPrice;
      }).toList();
      _isFilterVisible = false; // Hide filter after applying
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.whiteBg,
      appBar: const AppbarWidget(text: "Sell Item Post"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceWidget(spaceHeight: 16),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width / (size.width / 20)),
              child: SellItemSearchWidget(
                hintText: 'Search',
                controller: searchController,
                maxLines: 1,
                onChanged: (value) {
                  controller.searchProducts(value); // Call search method
                },
                onSuffixIconTap: _toggleFilter, // Toggle filter on icon tap
              ),
            ),
            const SpaceWidget(spaceHeight: 16),
            // Filter Section
            if (_isFilterVisible)
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / (size.width / 20)),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.greyLighter),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // City TextField
                      const Text(
                        'City',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      const SpaceWidget(spaceHeight: 8),
                      TextField(
                        controller: cityController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.greyLighter),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SpaceWidget(spaceHeight: 16),
                      // Location TextField
                      const Text(
                        'Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                        ),
                      ),
                      const SpaceWidget(spaceHeight: 8),
                      TextField(
                        controller: locationController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.greyLighter),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                      ),
                      const SpaceWidget(spaceHeight: 16),
                      // Price Range Slider
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Est Budget',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.blue100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '\$${_priceRange.start.round()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const SpaceWidget(spaceWidth: 8),
                              const Text(
                                'to',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.grey700,
                                ),
                              ),
                              const SpaceWidget(spaceWidth: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.blue100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '\$${_priceRange.end.round()}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.blue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SpaceWidget(spaceHeight: 8),

                      RangeSlider(
                        values: _priceRange,
                        min: 0,
                        max: 1000,
                        divisions: 100,
                        activeColor: AppColors.blue,
                        inactiveColor: AppColors.greyLighter,
                        onChanged: (RangeValues values) {
                          setState(() {
                            _priceRange = values;
                          });
                        },
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$0',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey700,
                            ),
                          ),
                          Text(
                            '\$1K',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.grey700,
                            ),
                          ),
                        ],
                      ),
                      const SpaceWidget(spaceHeight: 16),
                      // Search Now Button
                      ButtonWidget(
                        onPressed: () {
                          _applyFilter();
                        },
                        label: "Search Now",
                        buttonWidth: double.infinity,
                      )
                    ],
                  ),
                ),
              ),
            const SpaceWidget(spaceHeight: 16),
            // Item List
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (controller.filteredProducts.isEmpty) {
                return const Center(child: Text('No products found'));
              } else {
                return Column(
                  children: [
                    ...List.generate(controller.filteredProducts.length,
                        (index) {
                      final product = controller.filteredProducts[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.userProductDetailsScreen,
                            arguments: {
                              'productId': product.id
                            }, // Pass the product ID
                          );
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: double.infinity,
                          padding:
                              EdgeInsets.all(size.width / (size.width / 8)),
                          margin: EdgeInsets.only(
                              left: size.width / (size.width / 20),
                              right: size.width / (size.width / 20),
                              bottom: size.width / (size.width / 12)),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.greyLighter,
                              width: size.width / (size.width / 0.7),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AppImage(
                                  url: product.image,
                                  height: size.width / (size.width / 58),
                                  width: size.width / (size.width / 58),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SpaceWidget(spaceWidth: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget(
                                    text: capitalize(product.name ?? 'No Name'),
                                    fontColor: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  const SpaceWidget(spaceHeight: 2),
                                  TextWidget(
                                    text: '\$${product.price ?? 0}',
                                    fontColor: AppColors.grey700,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  TextWidget(
                                    text:
                                        "${capitalize(product.city ?? '')}, ${capitalize(product.state ?? '')}, ${capitalize(product.country ?? '')}",
                                    fontColor: AppColors.grey700,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ],
                              ),
                              const SpaceWidget(spaceHeight: 8),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
