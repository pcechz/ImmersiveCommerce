import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/data/repositories/user_repository.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/entities/user_entity.dart';

class AuthState {
  final bool isLoading;
  final UserEntity? user;
  final String? error;

  const AuthState({this.isLoading = false, this.user, this.error});

  AuthState copyWith({bool? isLoading, UserEntity? user, String? error}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user,
      error: error,
    );
  }
}

class AuthViewModel extends StateNotifier<AuthState> {
  final RegisterUser _registerUser;
  final LoginUser _loginUser;

  AuthViewModel(this._registerUser, this._loginUser) : super(const AuthState());

  Future<void> register(String email, String password, String name, BuildContext context) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      state = state.copyWith(error: 'All fields are required');
      return;
    }

    state = state.copyWith(isLoading: true);
    final success = await _registerUser.call(email, password, name);
    if (success) {
      final user = UserEntity(id: '1', name: name, email: email);
      state = state.copyWith(isLoading: false, user: user);

      if (state.user != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(
            context,
            '/product-list',
          );
        });
      }
    } else {
      state = state.copyWith(isLoading: false, error: 'User already exists');
    }
  }

  Future<void> login(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(error: 'Email and password are required');
      return;
    }

    state = state.copyWith(isLoading: true);
    final user = await _loginUser.call(email, password);
    if (user != null) {
      state = state.copyWith(isLoading: false, user: user);
      if (state.user != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(
            context,
            '/product-list',
          );
        });
      }
    } else {
      state = state.copyWith(isLoading: false, error: 'Invalid credentials');
    }
  }


  Future<void> logout( BuildContext context) async {
    state = const AuthState();
    final logout = await _loginUser.logout();
    if (logout) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(
            context,
            '/login',
          );
        });

    } else {
      state = state.copyWith(isLoading: false, error: 'Error Logging out');
    }
  }


}

final authProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final userRepository = UserRepository();
  final registerUser = RegisterUser(userRepository);
  final loginUser = LoginUser(userRepository);
  return AuthViewModel(registerUser, loginUser);
});
