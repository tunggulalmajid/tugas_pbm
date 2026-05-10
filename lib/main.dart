import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // 1. Import Provider
import 'package:tugas_pbm/providers/auth_provider.dart'; // 2. Import AuthProvider Anda
import 'package:tugas_pbm/providers/products_provider.dart';
import 'package:tugas_pbm/screens/create_product.dart';
import 'package:tugas_pbm/screens/dashboard_screen.dart';
import 'package:tugas_pbm/screens/login_screen.dart';
import 'package:tugas_pbm/utils/app_routes.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      // 3. Bungkus MyApp dengan MultiProvider di sini
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: AppRoutes.login,
      routes: {
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.dashboard: (context) => const DashboardScreen(),
        AppRoutes.createProduct: (context) => const CreateProduct(),
      },
    );
  }
}
