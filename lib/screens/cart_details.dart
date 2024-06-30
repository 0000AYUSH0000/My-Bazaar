import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_signup/providers/user_provider.dart';
import '../models/product.dart';
import '../services/firebase_services.dart';
import 'details_screen.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({super.key});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    final user = UserProvider.of(context).currentUser;
    double getTotalCartPrice(List<Product> cartProducts) {
      double totalPrice = 0;
      for (var product in cartProducts) {
        totalPrice += product.price * product.quantity;
      }
      return totalPrice;
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .collection('cart')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final cartDocs = snapshot.data!.docs;
        List<Product> cartProducts = [];

        for (var doc in cartDocs) {
          final productId = doc['productId'];
          final product = findProductById(productId);
          if (product != null) {
            product.quantity=doc['quantity'];
            cartProducts.add(product);
          }
        }

        if (cartProducts.isEmpty) {
          return const Center(child: Text('No items in Cart',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),));
        }

        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Text(
                    'My Cart',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context, index) {
                  final product = cartProducts[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              removeProductFromCart(product.id,user!);
                            },
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(product: product),
                            ),
                          );
                        },
                        title: Text(
                          product.name,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text("₹ ${product.price}\n"),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(product.image),
                          backgroundColor: Colors.grey.withOpacity(0.2),
                        ),
                        trailing: Column(
                          children: [
                            buildProductQuantity(Icons.add, index, user,cartProducts),
                            Text(
                              product.quantity.toString(),
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                            ),
                            buildProductQuantity(Icons.remove, index, user,cartProducts),
                          ],
                        ),
                        tileColor: Colors.grey.withOpacity(0.1),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 10,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffB81736),
                        Color(0xff281537),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹ ${getTotalCartPrice(cartProducts).toString()}",
                      style: const TextStyle(
                          fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement checkout logic here
                      },
                      label: const Text("Check-Out"),
                      icon: const Icon(Icons.local_shipping_outlined, size: 15),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  GestureDetector buildProductQuantity(IconData icon, int index, User? user,List<dynamic>cartProducts) {

    return GestureDetector(
      onTap: () async {
        final productId = cartProducts[index].id.toString();
        final cartDoc = FirebaseFirestore.instance
            .collection('users')
            .doc(user?.email)
            .collection('cart')
            .doc(productId);

        if (icon == Icons.add) {
          await cartDoc.update({
            'quantity': FieldValue.increment(1),
          });
        } else if (icon == Icons.remove && cartProducts[index].quantity > 1) {
          await cartDoc.update({
            'quantity': FieldValue.increment(-1),
          });
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Icon(
          icon,
          size: 20,color: Colors.black87,
        ),
      ),
    );
  }
}
