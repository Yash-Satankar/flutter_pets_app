import 'package:flutter/material.dart';
import 'package:flutter_pets_app/screens/add_new_pet.dart';
import 'package:flutter_pets_app/screens/home_page.dart';
import 'package:flutter_pets_app/screens/my_pets_screen.dart';
import 'package:flutter_pets_app/screens/sign_in.dart';
import 'package:flutter_pets_app/screens/sign_up.dart';

class AppRoutes {
  static const String signUp = '/signUp';
  static const String signIn = '/signIn';
  static const String home = '/home';
  static const String newPet = '/newPet';
  static const String myPets = '/myPets';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case newPet:
        return MaterialPageRoute(builder: (_) => const AddNewPet());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case myPets:
        return MaterialPageRoute(builder: (_) => const MyPetsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
