import 'package:immersive_commerce/data/repositories/user_repository.dart';

import '../entities/user_entity.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<UserEntity?> call(String email, String password) async {
    return await repository.loginUser(email, password);
  }

  Future<bool> logout() async {
    return await repository.logoutUser();
  }
}
