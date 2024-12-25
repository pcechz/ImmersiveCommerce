import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/data/models/product.dart';
import '../../data/repositories/product_repository.dart';

final productProvider = StateNotifierProvider<ProductViewModel, AsyncValue<List<Product>>>((ref) {
  final productRepository = ProductRepository();
  return ProductViewModel(productRepository);
});

class ProductViewModel extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository _productRepository;

  ProductViewModel(this._productRepository) : super(const AsyncValue.loading()) {
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productRepository.getProducts();
      state = AsyncValue.data(products);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void toggleFavorite(Product product) {
    state = state.whenData((products) {
      return products.map((p) {
        if (p == product) {
          p.isFavorite = !p.isFavorite!;
          p.favoriteCount += p.isFavorite! ? 1 : -1;
        }
        return p;
      }).toList();
    });
  }

}
