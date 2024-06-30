import 'package:flutter/material.dart';
import 'package:login_signup/models/my_product.dart';
import 'package:login_signup/screens/details_screen.dart';

import '../providers/user_provider.dart';
import '../widgets/product_card.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();

}

class _StartingScreenState extends State<StartingScreen> {
  int isSelected = 0;


 
  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context).currentUser;

    _buildTShirts(){
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 140),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          final tshirtlist = MyProducts.tShirts[index];
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: tshirtlist)));
              },
              child: ProductCard(product: tshirtlist, user: user,));
        },
        itemCount: MyProducts.tShirts.length,
      );
    }

    _buildPhones(){
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 140),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          final phonelist = MyProducts.phones[index];
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: phonelist)));
              },
              child: ProductCard(product: phonelist, user: user,));
        },
        itemCount: MyProducts.phones.length,
      );
    }

    _buildLaptops(){
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 140),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          final laptoplist = MyProducts.laptops[index];
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: laptoplist)));
              },
              child: ProductCard(product: laptoplist, user: user,));
        },
        itemCount: MyProducts.laptops.length,
      );
    }

    _buildSneakers(){
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 140),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          final sneakerlist = MyProducts.sneakers[index];
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: sneakerlist)));
              },
              child: ProductCard(product: sneakerlist, user: user,));
        },
        itemCount: MyProducts.sneakers.length,
      );
    }

    _buildJackets(){
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 140),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          final jacketlist = MyProducts.jackets[index];
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product:jacketlist)));
              },
              child: ProductCard(product: jacketlist, user: user,));
        },
        itemCount: MyProducts.jackets.length,
      );
    }

    _buildAllProducts() {
      if (user == null) {
        return const Center(child: CircularProgressIndicator());
      }
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (100 / 140),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12),
        itemBuilder: (BuildContext context, int index) {
          final allProducts = MyProducts.allProducts;
          allProducts.shuffle();
          final allProductIndex=allProducts[index];
          return GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: allProductIndex)));
              },
              child: ProductCard(product: allProductIndex, user: user,));
        },
        itemCount: MyProducts.allProducts.length,
      );
    }

    Widget _buildProductCategory({required int index, required String name}) {
      return GestureDetector(
        onTap: ()=> setState(()=>isSelected=index) ,
        child: Container(
          width: 100,
          height: 40,
          margin: const EdgeInsets.only(top: 10, right: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
          ),
          child: Text(
            name,
            style: TextStyle(
                color: isSelected == index ? Colors.orange : Colors.white),
          ),
        ),
      );
    }


    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text(
            'Our Products!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildProductCategory(index: 0, name: 'All Products'),
                _buildProductCategory(index: 1, name: 'Jackets'),
                _buildProductCategory(index: 2, name: 'Sneakers'),
                _buildProductCategory(index: 3, name: 'Laptops'),
                _buildProductCategory(index: 4, name: 'Phones'),
                _buildProductCategory(index: 5, name: 'T-shirts'),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(child:
          isSelected==0?
          _buildAllProducts() :
          isSelected==1?
          _buildJackets():
          isSelected==2?
          _buildSneakers():
          isSelected==3?
          _buildLaptops():
              isSelected==4?
              _buildPhones():
                  _buildTShirts()

          )
        ],
      ),
    );
  }
}
