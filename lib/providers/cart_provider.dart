import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List <Product> _cart = [];

  List<Product> get cart => _cart;

  void toggleProduct(Product product) {
    if (_cart.contains(product)) {
      for(Product element in _cart){
        element.quantity++;
      }
    }
    else {
      _cart.add(product);
    }

    notifyListeners();
  }

  incrementQuantity(int index)=>_cart[index].quantity++;
  decrementQuantity(int index)=>_cart[index].quantity--;

  getTotalPrice(){
    double sum=0;
    for(int i=0;i<_cart.length;i++){
      sum=(sum+(_cart[i].quantity*_cart[i].price)) as double;
    }

    return sum;
  }


  static CartProvider of(
      BuildContext context,{bool listen=true,}){
    return Provider.of<CartProvider>(context,listen: listen);
  }
}

