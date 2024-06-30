import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/screens/home_screen.dart';

class NavBar extends StatefulWidget {
   const NavBar({super.key,});


  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final user=FirebaseAuth.instance.currentUser!;

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void signOut() {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/welcome');
    } on FirebaseAuthException catch (e) {
      _showErrorDialog('Error', e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Logged in as'),
            accountEmail: Text(user.email??''),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: ClipOval(
                child: Image.asset('assets/boy.png'),
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/red_back.webp',),fit: BoxFit.cover,opacity: 0.9,
              )
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite,color: Colors.redAccent,),
            title: const Text('Favourites',style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen(index: 1,))),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart,),
            title: const Text('Cart',style: TextStyle(fontWeight: FontWeight.bold),),
            onTap: ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen(index: 2))),
          ),
          ListTile(
            leading: const Icon(Icons.arrow_back,),
            title: const Text('Sign out',style: TextStyle(fontWeight: FontWeight.bold),),
            onTap:signOut,
          ),
        ],
      ),
    );
  }
}
