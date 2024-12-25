import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/data/models/product.dart';
import 'package:immersive_commerce/presentation/viewmodels/product_viewmodel.dart';

class ProductDetailScreen extends ConsumerWidget {
  final Product product;

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title ?? ""),
        actions: [
          productState.when(
            data: (products) {
              final currentProduct = products.firstWhere((p) => p == product);
              return IconButton(
                icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Icon(
                    currentProduct.isFavorite == true
                        ? Icons.favorite
                        : Icons.favorite_border,
                    key: ValueKey<bool>(currentProduct.isFavorite!),
                    color: Colors.red,
                  ),
                ),
                onPressed: () {
                  ref.read(productProvider.notifier).toggleFavorite(currentProduct);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        currentProduct.isFavorite == true
                            ? "${currentProduct.title} added to favorites!"
                            : "${currentProduct.title} removed from favorites!",
                      ),
                    ),
                  );
                },
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, stackTrace) => Icon(Icons.error),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.images![0],
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              product.title ?? "",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${product.price?.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 8),
            Text(
              "Category: ${product.category}",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "Brand: ${product.brand}",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              "SKU: ${product.sku}",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                for (int i = 1; i <= 5; i++)
                  Icon(
                    i <= product.rating!.floor()
                        ? Icons.star
                        : (i - product.rating! > 0 && i - product.rating! < 1)
                        ? Icons.star_half
                        : Icons.star_border,
                    color: i <= product.rating!.floor() ? Colors.orange : (i - product.rating! > 0 && i - product.rating! < 1) ? Colors.orange : Colors.grey,
                    size: 20,
                  ),
                const SizedBox(width: 8),
                Text(
                  "${product.rating?.toStringAsFixed(1)} (${product.reviews?.length} reviews)",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(),
            const SizedBox(height: 8),
            Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              product.description ?? "",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              "Stock: ${product.stock}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Warranty: ${product.warrantyInformation}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Shipping Info: ${product.shippingInformation}",
              style: TextStyle(fontSize: 16),
            ),
            Text(
              "Return Policy: ${product.returnPolicy}",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Divider(),
            const SizedBox(height: 8),
            Text(
              "Reviews",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            for (var review in product.reviews!)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Loop to display stars for each review rating
                        for (int i = 1; i <= 5; i++)
                          Icon(
                            i <= review.rating!.floor()
                                ? Icons.star
                                : (i - review.rating! > 0 && i - review.rating! < 1)
                                ? Icons.star_half
                                : Icons.star_border,
                            color: i <= review.rating!.floor()
                                ? Colors.orange
                                : (i - review.rating! > 0 && i - review.rating! < 1)
                                ? Colors.orange
                                : Colors.grey,
                            size: 20,
                          ),
                        const SizedBox(width: 8),
                        Text(
                          "${review.rating}/5", // Display the rating out of 5
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Text(
                      review.comment ?? "", // Display the review comment
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "- ${review.reviewerName}", // Display the reviewer's name
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    SizedBox(height: 8,),
                    Divider(thickness: 0.5,)
                  ],
                ),
              ),

            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                      },
                      icon: Icon(Icons.shopping_cart),
                      label: Text("Add to Cart"),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                      },
                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


