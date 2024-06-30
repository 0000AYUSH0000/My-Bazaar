import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/models/product.dart';
import '../services/firebase_services.dart';
class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product, required this.user});
  final Product product;
  final User user;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    if (!mounted) return;
    bool isPresent = await isProductInFavorites(widget.product.id, widget.user);
    setState(() {
      isFavorite = isPresent;
    });
  }

  void toggleFavoriteStatus() async {
    if (isFavorite) {
      await removeProductFromFavorites(widget.product.id, widget.user);
    } else {
      addProductToFavorites(widget.product.id, widget.user);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.email)
          .collection('favourites')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final favoriteDocs = snapshot.data!.docs;
          isFavorite = favoriteDocs.any((doc) => doc['productId'] == widget.product.id);
        }

        return Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: toggleFavoriteStatus,
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 55,
                width: 55,
                child: Image.asset(
                  widget.product.image,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                widget.product.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                widget.product.category,
                style: const TextStyle(color: Color(0xffB81736), fontSize: 13),
              ),
              Text("₹ ${widget.product.price}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ],
          ),
        );
      },
    );
  }
}
