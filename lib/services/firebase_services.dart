import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:login_signup/models/my_product.dart';
import '../models/product.dart';



final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> addProductToFavourites(int productId,User user) async {

  final userEmail = user.email;
  final favouritesCollection = _firestore
      .collection('users')
      .doc(userEmail)
      .collection('favourites');

  await favouritesCollection.add({
    'productId': productId,
  });
}


Product? findProductById(int productId) {
  return MyProducts.allProducts.firstWhere((product) => product.id == productId);
}

Future<void> removeProductFromFavorites(int productId, User user) async {

  CollectionReference favouritesRef = FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('favourites');


  QuerySnapshot snapshot =
  await favouritesRef.where('productId', isEqualTo: productId).get();

  if (snapshot.docs.isNotEmpty) {

    for (DocumentSnapshot doc in snapshot.docs) {
      await doc.reference.delete();
    }
  } else {
    if (kDebugMode) {
      print('Document with productId $productId not found in favourites.');
    }
  }
}

void addProductToFavorites(int productId,User user) {
  FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('favourites')
      .doc()
      .set({'productId': productId});
}

Future<bool> isProductInFavorites(int productId,User user) async {

  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('favourites')
      .where('productId', isEqualTo: productId)
      .get();

  return querySnapshot.docs.isNotEmpty;
}



Future<void> addToCart(int productId,User user) async {
  final cartDoc = FirebaseFirestore.instance
      .collection('users')
      .doc(user.email)
      .collection('cart')
      .doc(productId.toString());

  final cartData = await cartDoc.get();

  if (cartData.exists) {

    await cartDoc.update({
      'quantity': FieldValue.increment(1),
    });
  } else {

    await cartDoc.set({
      'productId': productId,
      'quantity': 1,
    });
  }
}



Future<void> removeProductFromCart(int productId, User user) async {
  final userDoc = FirebaseFirestore.instance.collection('users').doc(user.email);
  final cartRef = userDoc.collection('cart').doc(productId.toString());


  final cartDoc = await cartRef.get();
  if (cartDoc.exists) {

      await cartRef.delete();
    }
}




