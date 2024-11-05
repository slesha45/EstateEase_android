import 'package:final_assignment/app/contants/api_endpoint.dart';
import 'package:final_assignment/core/common/provider/theme_view_model_provider.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/favourite/favourite_provider.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:final_assignment/features/single_property/presentation/widgets/my_single_property.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import the SingleView

class MyPropertyCard extends ConsumerWidget {
  final PropertyEntity property;

  const MyPropertyCard({required this.property, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageUrl = '${ApiEndpoints.imageUrl}${property.propertyImage}';
    final isDark = ref.watch(themeViewModelProvider);
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isTablet = screenWidth > 600;

    final isFavorite = ref
        .watch(favoritePropertiesProvider)
        .contains(property);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black54 : Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingleView(
                          singleProperty: property,
                          selectedQuantity:
                              1, // Example quantity, adjust as needed
                          onAddToBag: () {},
                          onIncreaseQuantity: () {},
                          onDecreaseQuantity: () {},
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(isTablet ? 16 : 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.propertyTitle,
                      style: TextStyle(
                        fontSize: isTablet ? 18 : 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      property.propertyLocation,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: isDark ? Colors.grey[400] : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      property.propertyCategory,
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: isDark ? Colors.grey[400] : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Rs ${property.propertyPrice}",
                      style: TextStyle(
                        fontSize: isTablet ? 16 : 14,
                        color: isDark ? Colors.red[400] : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  final notifier =
                      ref.read(favoritePropertiesProvider.notifier);
                  if (isFavorite) {
                    notifier.removeProperty(property);
                    showMySnackBar(message: "${property.propertyTitle} removed from wishlist");
                  } else {
                    notifier.addProperty(property);
                    showMySnackBar(message: "${property.propertyTitle} added to wishlist");
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              icon: Icon(
                Icons.view_module,
                color: isDark ? Colors.orange : Colors.brown,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SingleView(
                      singleProperty: property,
                      selectedQuantity: 1, // Example quantity, adjust as needed
                      onAddToBag: () {},
                      onIncreaseQuantity: () {},
                      onDecreaseQuantity: () {},
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
