import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/button.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/shared/screen_size.dart';
import 'package:smarthealthcare/shop/imagecard.dart';

class Cart extends StatefulWidget {
  static String routeName = "/cart";
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
  static _CartState? of(BuildContext context) =>
      context.findAncestorStateOfType<_CartState>();
}

class _CartState extends State<Cart> {
  late dynamic data;
  bool isfiltered = false;
  num totalPrice = 0;
  final DatabaseService _firebaseServices = DatabaseService();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        totalPrice;
      });
    });
  }

  void minusPrice(int p) {
    setState(() => totalPrice -= p);
  }

  @override
  Widget build(BuildContext context) {
    final uid = _firebaseServices.getUserId();

    return SafeArea(
      child: Scaffold(
        backgroundColor: kback,
        appBar: AppBar(
          title: const Text(
            "Cart",
            style: TextStyle(color: kpinkdark),
          ),
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder(
                stream: isfiltered
                    ? data
                    : _firebaseServices.userCollection
                        .doc(uid)
                        .collection("Cart")
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Loading();
                  }
                  totalPrice = 0;
                  if (snapshot.data!.size == 0) {
                    return Center(
                      child: Text(
                        "No results found!",
                        style: TextStyle(color: kpurple[800], fontSize: 18),
                      ),
                    );
                  }
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Wrap(
                        // spacing: 50,
                        children: snapshot.data!.docs.map((doc) {
                          return card(doc);
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
            bottomCard(),
          ],
        ),
      ),
    );
  }

  Container card(QueryDocumentSnapshot<Object?> doc) {
    late final docData;
    return Container(
      child: FutureBuilder(
          future: _firebaseServices.productCollection
              .doc(doc.id)
              .get()
              .then((DocumentSnapshot docSnap) {
            if (docSnap.exists) {
              docData = docSnap.data();
            } else {
              print('Document does not exist on the database');
            }
          }),
          builder: (context, productSnap) {
            if (productSnap.hasError) {
              return Center(
                child: Text("${productSnap.error}"),
              );
            }

            if (productSnap.connectionState == ConnectionState.done) {
              totalPrice += docData['price'];

              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ImageCard(
                    id: doc.id,
                    pid: docData['pid'],
                    title: docData['title'],
                    description: docData['description'],
                    image1: docData['images'][0],
                    price: docData['price'],
                    rating: docData['rating'],
                    category: docData['category'],
                    discount: docData['discount'],
                    iscart: true,
                  ),
                ),
              );
            }
            return const Loading();
          }),
    );
  }

  Container bottomCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 25,
        horizontal: 30,
      ),
      decoration: const BoxDecoration(
        color: kpinkdark,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -1000),
            blurRadius: 100,
            spreadRadius: 100,
            color: kpurple,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
              text: "Total:\n",
              style: const TextStyle(fontSize: 20, color: kwhite, height: 1.5),
              children: [
                TextSpan(
                  text: "\u{20B9} ${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            width: getProportionateScreenWidth(210),
            child: Button(
              text: "Proceed",
              press: () {
                // if (totalPrice != 0) popUp();
              },
            ),
          ),
        ],
      ),
    );
  }
}
