import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:login_signup/screens/forgot_password.dart';
import 'package:login_signup/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }



  void signIn() async {
    showDialog(context: context, builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print("Signed in as ${userCredential.user?.email}");

      // Navigate to WelcomeScreen on successful login
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(index: 0)));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        _showErrorDialog('User not found', 'Please enter a valid email.');
      }
      if (e.code == 'wrong-password') {
        _showErrorDialog('Wrong Password', 'Please enter a valid password.');
      }
      else {

        print('FirebaseAuthException: ${e.message}');
        _showErrorDialog('Error', 'An error occurred. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ],
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 75, left: 23),
            child: Text(
              'Hello\nSign in!',
              style: TextStyle(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 228.0),
          child: Container(
            padding: const EdgeInsets.only(top: 18.0),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: Icon(
                          Icons.check,
                          color: Colors.grey,
                        ),
                        label: Text(
                          'Email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText ? Icons.visibility_off : Icons
                                .visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText =
                              !_obscureText; // Toggle the obscure text status
                            });
                          },
                        ),
                        label: const Text(
                          'Password',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                     Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xffB81736),
                              fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 89,
                    ),
                    GestureDetector(
                      onTap: signIn,
                      child: Container(
                        height: 50,
                        width: 230,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xffB81736),
                                Color(0xff281537),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(40)),
                        child: const Center(
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 22),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 140,
                    ),
                     Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,

                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, '/signup');
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

}