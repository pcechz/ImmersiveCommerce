import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:immersive_commerce/presentation/viewmodels/auth_viewmodel.dart';
import 'presentation/routes/app_routes.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    final initialRoute = (authState.user != null) ? '/product-list' : '/login';

    return MaterialApp(
      title: 'Immersive Commerce',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: initialRoute,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
