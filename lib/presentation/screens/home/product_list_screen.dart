import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/presentation/utils/widget.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../viewmodels/product_viewmodel.dart';
import '../../widgets/product_card.dart';

class ProductListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopBar("Products List", isHomePage: true,),
            Expanded(
              child: productState.when(
                data: (products) => SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: products.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              onTap: () {
                                Navigator.pushNamed(context, '/product-details', arguments: product);
                              },
                              onWishlistTap: () {
                                ref.read(productProvider.notifier).toggleFavorite(product); // Toggle favorite
                              },
                            );
                          },
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.7,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                loading: () => ShimmerLoader(),
                error: (error, stackTrace) => Center(child: Text('Error: $error')),
              ),
            )
          ],
        ),
      ),
    );
  }
}

