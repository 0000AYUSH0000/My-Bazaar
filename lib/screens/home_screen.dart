import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/favourite_screen.dart';
import 'package:login_signup/screens/profile_screen.dart';
import 'package:login_signup/screens/starting_screen.dart';
import 'cart_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List screen=[
    StartingScreen(),
    FavouriteScreen(),
    ProfileScreen()
  ];
  int currentIndex=0;


  void signOut() {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/welcome');
    } on FirebaseAuthException catch (e) {
      print("Error signing in: $e");
    }
  }

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // custom height
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],

              ),
            ),
          ),
          title: Text(
            'My Bazaar',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: signOut, icon: Icon(Icons.logout_outlined,color: Colors.white,)),
            IconButton(onPressed:()=> Navigator.push(context,MaterialPageRoute(builder: (context)=>CartDetails())), icon: Icon(Icons.shopping_cart,color: Colors.white,))
            
          ],
          automaticallyImplyLeading: false,
        ),
      ),
      body: screen[currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color(0xffB81736),
              Color(0xff281537),],

          ),
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: currentIndex,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.white,
          onTap: (value){
            setState(() {
              currentIndex=value;
            });
          },
          backgroundColor: Colors.transparent, // Make background transparent to see the gradient
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
