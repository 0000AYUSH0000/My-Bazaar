import 'package:flutter/material.dart';
import 'package:login_signup/models/product.dart';
import 'package:login_signup/providers/cart_provider.dart';
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
        preferredSize: const Size.fromHeight(60.0), // custom height
        child: AppBar(
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
            'Details',
            style:  TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 160,
                  height: 160,
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
            const SizedBox(
              height: 14,
            ),
            Container(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  Text(
                    widget.product.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "₹ ${widget.product.price}",
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.product.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Available Options',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      if (widget.product.id >= 1 &&
                          widget.product.id <= 25) ...[
                        const AvailableSize(
                          size: "US 6",
                        ),
                        const AvailableSize(
                          size: "US 7",
                        ),
                        const AvailableSize(
                          size: "US 8",
                        ),
                        const AvailableSize(
                          size: "US 9",
                        ),

                      ],
                      if (widget.product.id >= 26 &&
                          widget.product.id <= 50) ...[

                        const AvailableSize(
                          size: "M",
                        ),
                        const AvailableSize(
                          size: "L",
                        ),
                        const AvailableSize(
                          size: "XL",
                        ),
                        const AvailableSize(
                          size: "XXL",
                        ),
                      ],
                      if (widget.product.id >= 51 &&
                          widget.product.id <= 75) ...[
                        const AvailableSize(
                          size: "128GB",
                        ),
                        const AvailableSize(
                          size: "256GB",
                        ),
                        const AvailableSize(
                          size: "512GB",
                        ),
                        const AvailableSize(
                          size: "1TB",
                        ),

                      ],
                      if (widget.product.id >= 76 &&
                          widget.product.id <= 100) ...[
                        const AvailableSize(
                          size: "128GB",
                        ),
                        const AvailableSize(
                          size: "256GB",
                        ),
                        const AvailableSize(
                          size: "512GB",
                        ),
                      ],
                      if (widget.product.id >= 101 &&
                          widget.product.id <= 125) ...[

                        const AvailableSize(
                          size: "M",
                        ),
                        const AvailableSize(
                          size: "L",
                        ),
                        const AvailableSize(
                          size: "XL",
                        ),
                        const AvailableSize(
                          size: "XXL",
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Available Colours',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Row(
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
            const SizedBox(
              height: 35,
            ),
            Container(
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
                    "₹ ${widget.product.price}",
                    style: const TextStyle(
                        fontSize: 26,
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
                    label: const Text("Add to Cart"),
                    icon: const Icon(Icons.add_shopping_cart),
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
