

import 'package:flutter/material.dart';
import 'package:mvvm/utils/Routes/routes_name.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_screen.dart';

class Routes {
  
  static Route<dynamic> generateRoute(RouteSettings settings)
  {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (context) => const LoginScreen(),);
      case RoutesName.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("No route found",style: TextStyle(
                fontSize: 25,
              ),),
            ),
          );
        });

    }
  }

}