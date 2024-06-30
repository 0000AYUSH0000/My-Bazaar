import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/constants.dart';
import 'package:login_signup/providers/theme_provider.dart';
import 'package:login_signup/providers/user_provider.dart';
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

  runApp(MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_)=>UserProvider()),
        ChangeNotifierProvider(create: (_)=>ThemeProvider())
      ],
      child: const MyApp()));
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override


  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Provider.of<ThemeProvider>(context, listen: false).getThemePreference(user);
    }
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: Provider.of<ThemeProvider>(context).isDark ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),
      routes: {
        '/home': (context) => HomeScreen(index: 0,),
        '/welcome': (context) => const WelcomeScreen(),
        '/signup' : (context) =>  const RegScreen(),
        '/signin' : (context) => const LoginScreen()
      },
    );
  }
}


