import 'package:flutter/material.dart';
import 'package:zeazeoshop/pages/cart_page.dart';
import 'package:zeazeoshop/pages/checkout_page.dart';
import 'package:zeazeoshop/pages/checkout_succes_page.dart';
import 'package:zeazeoshop/pages/detail_chat_page.dart';
import 'package:zeazeoshop/pages/edit_profile_page.dart';
import 'package:zeazeoshop/pages/home/main_page.dart';
import 'package:zeazeoshop/pages/product_page.dart';
import 'package:zeazeoshop/pages/sign_in_page.dart';
import 'package:zeazeoshop/pages/sign_up_page.dart';
import 'package:zeazeoshop/pages/splash_page.dart';
import 'package:zeazeoshop/utils/shared_pref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/sign-in': (context) => SignInPage(),
        '/sign-up': (context) => SignUpPage(),
        '/home': (context) => MainPage(),
        '/edit-profile': (context) => EditProfilePage(),
        '/product': (context) => ProductPage(),
        '/cart': (context) => CartPage(),
        '/checkout': (context) => CheckoutPage(),
        '/checkout-success': (context) => CheckoutSuccesPage(),
      },
    );
  }
}
