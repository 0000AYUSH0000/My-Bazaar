import 'package:flutter/material.dart';
import 'package:login_signup/providers/cart_provider.dart';
import 'package:login_signup/providers/favourite_provider.dart';
import 'package:login_signup/screens/auth_screen.dart';
import 'package:login_signup/screens/home_screen.dart';
import 'package:login_signup/screens/login_screen.dart';
import 'package:login_signup/screens/signup_screen.dart';
import 'package:login_signup/screens/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>FavouriteProvider()),
        ChangeNotifierProvider(create: (_)=>CartProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Poppins'
        ),
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
        routes: {
          '/home': (context) => HomeScreen(index: 0,),
          '/welcome': (context) => WelcomeScreen(),
          '/signup' : (context) =>  RegScreen(),
          '/signin' : (context) => LoginScreen()
        },
      ),
    );
  }
}


