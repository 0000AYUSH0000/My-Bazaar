import 'package:flutter/material.dart';
import 'package:login_signup/screens/favourite_screen.dart';
import 'package:login_signup/screens/starting_screen.dart';
import 'cart_details.dart';
import 'package:login_signup/widgets/nav_bar.dart';
class HomeScreen extends StatefulWidget {
   HomeScreen({super.key, required this.index,});
   late final int index;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List screen=[
    StartingScreen(),
    const FavouriteScreen(),
    const CartDetails(),
  ];





  @override
  Widget build(BuildContext context) {


    return Scaffold(
    drawer: NavBar(),
      appBar: PreferredSize(

        preferredSize: const Size.fromHeight(60.0), // custom height
        child: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu,color: Colors.white,),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],

              ),
            ),
          ),
          title: const Text(
            'My Bazaar',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: false,
          automaticallyImplyLeading: false,

        ),
      ),
      body: screen[widget.index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
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
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          currentIndex: widget.index,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.white,
          onTap: (value){
            setState(() {
              widget.index=value;
            });
          },
          backgroundColor: Colors.transparent, // Make background transparent to see the gradient
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
