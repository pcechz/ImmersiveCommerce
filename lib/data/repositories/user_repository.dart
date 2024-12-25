import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';

class UserRepository {
  static const String _userEmailKey = "user_email";
  static const String _userPasswordKey = "user_password";
  static const String _userNameKey = "user_name";

  Future<bool> registerUser(String email, String password, String name) async {
    final prefs = await SharedPreferences.getInstance();

    final existingEmail = prefs.getString(_userEmailKey);
    if (existingEmail != null && existingEmail == email) {
      return false;
    }

    // Save new user details
    await prefs.setString(_userEmailKey, email);
    await prefs.setString(_userPasswordKey, password);
    await prefs.setString(_userNameKey, name);
    return true;
  }


  Future<UserEntity?> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString(_userEmailKey);
    final storedPassword = prefs.getString(_userPasswordKey);

    if ((storedEmail == email && storedPassword == password)) {
      final name = prefs.getString(_userNameKey) ?? '';
      return UserEntity(id: '1', name: name, email: email);
    }
    return null;
  }

  Future<bool> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    final result = await prefs.clear();
   return result;
  }
}
