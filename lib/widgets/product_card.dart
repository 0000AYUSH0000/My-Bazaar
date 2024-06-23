import 'package:flutter/material.dart';
import 'package:login_signup/models/product.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2,
      padding: EdgeInsets.all(8),
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
              Icon(
                Icons.favorite_border_outlined,
                color: Colors.red,
              ),
            ],
          ),
          SizedBox(
            height: 105,
            width: 105,
            child: Image.asset(widget.product.image,fit: BoxFit.cover,),
          ),
          Text(widget.product.name,textAlign: TextAlign.center,style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 14,),),
          Text(widget.product.category,style: TextStyle(color: Color(0xffB81736),fontSize: 13),),
          Text("₹ ${widget.product.price}",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16)),
          
        ],
      ),
    );
  }
}
