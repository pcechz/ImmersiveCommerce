import 'package:flutter/material.dart';
import 'package:immersive_commerce/presentation/screens/favourite/favourite_screen.dart';
import 'package:immersive_commerce/presentation/screens/profile/profile_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/signup_screen.dart';
import '../screens/home/product_list_screen.dart';
import '../screens/product_details/product_detail_screen.dart';
import '../../data/models/product.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/product-list':
        return MaterialPageRoute(builder: (_) => ProductListScreen());
       case '/favourites':
        return MaterialPageRoute(builder: (_) => FavouriteScreen());
        case '/profile':
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case '/product-details':
        final product = settings.arguments as Product;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProductDetailScreen(product: product),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);

            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}

