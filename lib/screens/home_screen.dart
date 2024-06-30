// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:login_signup/providers/theme_provider.dart';
import 'package:login_signup/providers/user_provider.dart';
import 'package:login_signup/screens/favourite_screen.dart';
import 'package:login_signup/screens/starting_screen.dart';
import 'cart_details.dart';
import 'package:login_signup/widgets/nav_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
    required this.index,
  });
  int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List screen = [
    const StartingScreen(),
    const FavouriteScreen(),
    const CartDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    bool isDark=ThemeProvider.of(context).isDark;
    final user =UserProvider.of(context).currentUser;
    return Scaffold(
      drawer: const NavBar(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // custom height
        child: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
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
          actions: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: IconButton(
                  onPressed: ()
                    {ThemeProvider.of(context).toggleTheme(!isDark,user!);
                      setState(() {

                      });
                      },

                  icon: isDark? const Icon(
                    Icons.light_mode_outlined,
                    color: Colors.white,
                    size: 25,
                  ):const Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                ))
          ],
        ),
      ),
      body: screen[widget.index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ],
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
          onTap: (value) {
            setState(() {
              widget.index = value;
            });
          },
          backgroundColor: Colors
              .transparent, // Make background transparent to see the gradient
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
