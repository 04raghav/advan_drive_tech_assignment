import 'package:flutter/material.dart';
import 'package:quick_order_app/app/core/routes/route_names.dart';
import 'package:quick_order_app/app/data/models/request_model.dart';
import 'package:quick_order_app/app/presentation/features/auth/login_screen.dart';
import 'package:quick_order_app/app/presentation/features/auth/signup_screen.dart';
import 'package:quick_order_app/app/presentation/features/end_user/create_request/create_request_screen.dart';
import 'package:quick_order_app/app/presentation/features/end_user/home/end_user_home_screen.dart';
import 'package:quick_order_app/app/presentation/features/receiver/home/receiver_home_screen.dart';
import 'package:quick_order_app/app/presentation/features/receiver/request_details/request_details_screen.dart';
import 'package:quick_order_app/app/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {

    case RouteNames.splash:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );

    case RouteNames.login:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const LoginScreen(),
      );

      case RouteNames.signup:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignupScreen(),
      );
    
    case RouteNames.endUserHome:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const EndUserHomeScreen(),
      );

    case RouteNames.createRequest:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateRequestScreen(),
      );

    case RouteNames.receiverHome:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const ReceiverHomeScreen(),
      );
    
    case RouteNames.requestDetails:
      var request = routeSettings.arguments as RequestModel;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => RequestDetailsScreen(request: request),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("The screen you are looking for doesn't exist."),
          ),
        ),
      );
  }
}