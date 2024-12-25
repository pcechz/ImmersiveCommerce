import '../../data/repositories/product_repository.dart';
import '../../data/models/product.dart';

class FetchProducts {
  final ProductRepository repository;

  FetchProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
