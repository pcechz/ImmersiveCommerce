
import 'package:immersive_commerce/data/repositories/user_repository.dart';

class RegisterUser {
  final UserRepository repository;

  RegisterUser(this.repository);

  Future<bool> call(String email, String password, String name) async {
    return await repository.registerUser(email, password, name);
  }
}
