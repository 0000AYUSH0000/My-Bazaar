import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:login_signup/providers/user_provider.dart';
import 'package:login_signup/screens/details_screen.dart';
import '../models/product.dart';
import '../services/firebase_services.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {

    final user = UserProvider.of(context).currentUser;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.email)
          .collection('favourites')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No favorites found',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),));
        }

        final favoriteDocs = snapshot.data!.docs;
        List<Product> favoriteProducts = [];

        for (var doc in favoriteDocs) {
          final int productId = doc['productId'];
          final product = findProductById(productId);
          if (product != null) {
            favoriteProducts.add(product);
          }
        }

        if (favoriteProducts.isEmpty) {
          return const Center(child: Text('No favorites found'));
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Text('My Favourites',style: TextStyle(fontSize:27 ,fontWeight: FontWeight.bold),),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(product: product),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                removeProductFromFavorites(product.id, user!);
                              },
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            ),
                          ],
                        ),
                        child: ListTile(
                          tileColor: Colors.grey.withOpacity(0.1),
                          title: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            product.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(product.image),
                            backgroundColor: Colors.grey.withOpacity(0.2),
                          ),
                          trailing: Text(
                            "₹ ${product.price}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

//     return Column(
//       children: [
//         const Padding(
//           padding: EdgeInsets.only(top: 20, left: 20),
//           child:  Row(
//             children: [
//               Text(
//                 'Favourites',
//                 style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
//               )
//             ],
//           ),
//         ),
//         Expanded(
//             child: ListView.builder(
//                 itemCount: finalList.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Slidable(
  //endActionPane: ActionPane(
//                         motion: const ScrollMotion(), children: [
//                           SlidableAction(onPressed: (context){
//                             finalList.removeAt(index);
//                             setState(() {
//
//                             });
//                           },
//                             backgroundColor: Colors.redAccent,
//                             foregroundColor: Colors.white,
//                             icon: Icons.delete,
//                             label: 'Delete',
//
//                           )
//                       ],
//                       ),
//                       child: ListTile(
//                         onTap:(){
//                           Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: finalList[index],),));
//                         },
//                         title: Text(
//                           finalList[index].name,
//                           style: const TextStyle(
//                               fontSize: 17, fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(finalList[index].description,overflow: TextOverflow.ellipsis),
//
//                         leading: CircleAvatar(
//                           radius: 35,
//                           backgroundImage: AssetImage(finalList[index].image),
//                           backgroundColor: Colors.grey.withOpacity(0.2),
//                         ),
//
//                         trailing: Text("₹ ${finalList[index].price}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
//
//                         tileColor: Colors.grey[100],
//                       ),
//                     ),
//                   );
//                 }))
//       ],
//     );
//   }
// }

