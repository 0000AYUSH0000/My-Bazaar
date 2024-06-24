import 'package:flutter/material.dart';
import 'package:login_signup/models/product.dart';
import 'package:login_signup/providers/cart_provider.dart';
import 'package:login_signup/screens/cart_details.dart';
import 'package:login_signup/screens/home_screen.dart';
import 'package:login_signup/widgets/available_size.dart';


class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.product});
  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {

    final provider = CartProvider.of(context);



    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // custom height
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ],
              ),
            ),
          ),
          title: Text(
            'Details',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: Image.asset(
                    widget.product.image,
                    scale: 3.3,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  Text(
                    widget.product.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "₹ ${widget.product.price}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 36,
                  ),
                  Text(
                    widget.product.description,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Options',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if (widget.product.id >= 1 &&
                          widget.product.id <= 25) ...[
                        AvailableSize(
                          size: "US 6",
                        ),
                        AvailableSize(
                          size: "US 7",
                        ),
                        AvailableSize(
                          size: "US 8",
                        ),
                        AvailableSize(
                          size: "US 9",
                        ),
                        AvailableSize(
                          size: "US 10",
                        ),
                      ],
                      if (widget.product.id >= 26 &&
                          widget.product.id <= 50) ...[
                        AvailableSize(
                          size: "S",
                        ),
                        AvailableSize(
                          size: "M",
                        ),
                        AvailableSize(
                          size: "L",
                        ),
                        AvailableSize(
                          size: "XL",
                        ),
                        AvailableSize(
                          size: "XXL",
                        ),
                      ],
                      if (widget.product.id >= 51 &&
                          widget.product.id <= 75) ...[
                        AvailableSize(
                          size: "128GB",
                        ),
                        AvailableSize(
                          size: "256GB",
                        ),
                        AvailableSize(
                          size: "512GB",
                        ),
                        AvailableSize(
                          size: "1TB",
                        ),
                        AvailableSize(
                          size: "2TB",
                        ),
                      ],
                      if (widget.product.id >= 76 &&
                          widget.product.id <= 100) ...[
                        AvailableSize(
                          size: "128GB",
                        ),
                        AvailableSize(
                          size: "256GB",
                        ),
                        AvailableSize(
                          size: "512GB",
                        ),
                      ],
                      if (widget.product.id >= 101 &&
                          widget.product.id <= 125) ...[
                        AvailableSize(
                          size: "S",
                        ),
                        AvailableSize(
                          size: "M",
                        ),
                        AvailableSize(
                          size: "L",
                        ),
                        AvailableSize(
                          size: "XL",
                        ),
                        AvailableSize(
                          size: "XXL",
                        ),
                      ],
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Available Colours',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.cyanAccent,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.greenAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 10,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
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
                    "₹ ${widget.product.price}",
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      provider.toggleProduct(widget.product);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(index: 2),
                        ),
                      );
                    },
                    label: Text("Add to Cart"),
                    icon: Icon(Icons.add_shopping_cart),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
