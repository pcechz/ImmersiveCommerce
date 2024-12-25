import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:immersive_commerce/data/models/product.dart';
import 'package:immersive_commerce/presentation/utils/widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  final VoidCallback onWishlistTap;

  const ProductCard({
    required this.product,
    required this.onTap,
    required this.onWishlistTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shadowColor: Colors.black.withOpacity(0.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  height: context.height() * 0.2,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: CachedNetworkImage(
                      imageUrl: product.thumbnail!,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                // Wishlist Icon
                Positioned(
                  top: 0,
                  right: 8,
                  child: GestureDetector(
                    onTap: onWishlistTap,
                    child: Icon(
                      product.isFavorite == true ? Icons.favorite : Icons.favorite_border,
                      color: product.isFavorite == true ? Colors.red : Colors.grey,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              child: Text(
                product.title ?? "",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textPrimaryColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: <Widget>[
                  Text(
                    "\$${product.price?.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 16,
                      color: textSecondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8),
                  if (product.discountPercentage! > 0)
                    Text(
                      "-${product.discountPercentage?.toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            // SizedBox(height: 12),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Text(
            //     "Category: ${product.category}",
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Text(
            //     "Brand: ${product.brand}",
            //     style: TextStyle(
            //       fontSize: 14,
            //       color: Colors.grey,
            //     ),
            //   ),
            // ),
            // SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}



