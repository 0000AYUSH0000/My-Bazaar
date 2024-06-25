import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white

        ),
        child: Column(children: [
           Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child:  Image.asset('assets/cart.gif',scale: 4.5,),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'MY BAZAAR',
            style: TextStyle(fontSize: 30, color: Colors.black87,fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffB81736),
                    Color(0xff281537),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN IN',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RegScreen()));
            },
            child: Container(
              height: 53,
              width: 320,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xffB81736),
                    Color(0xff281537),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
              ),
              child: const Center(
                child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Text(
            'Shop away the boredom',
            style: TextStyle(fontSize: 17, color:Color(0xffB81736),fontWeight: FontWeight.bold ),
          ), //
          const SizedBox(
            height: 12,
          ),

        ],),
      ),
    );
  }
}
