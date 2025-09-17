import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:quick_order_app/app/core/routes/app_router.dart';
import 'package:quick_order_app/app/core/res/app_colors.dart';
import 'package:quick_order_app/app/data/providers/auth_provider.dart';
import 'package:quick_order_app/app/data/providers/request_provider.dart';
import 'package:quick_order_app/app/splash_screen.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
      ],
      child: MaterialApp(
        title: 'Quick Order',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        onGenerateRoute: generateRoute,
      ),
    );
  }
}