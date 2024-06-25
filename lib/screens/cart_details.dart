import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/cart_provider.dart';
import 'details_screen.dart';

class CartDetails extends StatefulWidget {
  const CartDetails({super.key});

  @override
  State<CartDetails> createState() => _CartDetailsState();
}

class _CartDetailsState extends State<CartDetails> {
  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final finalList = provider.cart;


    buildProductQuantity(IconData icon, int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (icon == Icons.add) {
              provider.incrementQuantity(index);

            } else if (icon == Icons.remove && finalList[index].quantity > 1) {
              provider.decrementQuantity(index);
            }
          });
        },
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            icon,
            size: 20,
          ),
        ),
      );
    }

    return  Column(
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
              itemCount: finalList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            finalList.removeAt(index);
                            setState(() {});
                          },
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        )
                      ],
                    ),
                    child: ListTile(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: finalList[index],),));
                      },
                      title: Text(
                        finalList[index].name,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("₹ ${finalList[index].price}\n"),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(
                          finalList[index].image,
                        ),
                        backgroundColor: Colors.grey.withOpacity(0.2),
                      ),
                      trailing: Column(
                        children: [
                          buildProductQuantity(Icons.add, index),
                          Text(
                            finalList[index].quantity.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                          buildProductQuantity(Icons.remove, index),
                        ],
                      ),
                      tileColor: Colors.grey[100],
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
                    "₹ ${provider.getTotalPrice()}",
                    style: const TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    label: const Text("Check-Out"),
                    icon: const Icon(Icons.local_shipping_outlined),
                  )
                ],
              ),
            ),
          ),
        ],
      );

  }
}
