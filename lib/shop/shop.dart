import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/shop/imagecard.dart';
import 'package:smarthealthcare/shop/promocard.dart';
import 'package:smarthealthcare/shop/section.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late dynamic data;
  bool isfiltered = false;
  List title = [
    'Sanitary Products',
    'Homemade Products',
    'Pregnancy Test Kits'
  ];

  static List<Map<String, dynamic>> promotions = [
    {
      "reverseGradient": false,
      "title": 'All Products\nDiscount Up to',
      "subtitle": '50%',
      "tag": '30 April 2022',
    },
    {
      "reverseGradient": true,
      "title": 'Get voucher gift',
      "subtitle": '\u{20B9} 50.00',
      "caption": '*for new member\'s only',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24.0, bottom: 28.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search healthcare products...',
              ),
            ),
          ),
          Section(
            title: 'Today\'s Promo',
            children: promotions.map((p) {
              return PromoCard(
                title: p["title"],
                subtitle: p["subtitle"],
                tag: p["tag"],
                caption: p["caption"],
                imagePath: p["imagePath"],
                reverseGradient: p["reverseGradient"],
              );
            }).toList(),
          ),
          grid(0),
          grid(1),
          grid(2),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> grid(int choice) {
    return StreamBuilder(
      stream: isfiltered
          ? data
          : FirebaseFirestore.instance
              .collection('categories')
              .where('category', isEqualTo: choice)
              .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Loading();
        }
        if (snapshot.data!.size == 0) {
          return Text(
            "No results found!",
            textAlign: TextAlign.center,
            style: TextStyle(color: kpurple[800], fontSize: 18),
          );
        }
        return Section(
          title: title[choice],
          children: snapshot.data!.docs.map((doc) {
            return ImageCard(
              id: doc.id,
              pid: doc['pid'],
              title: doc['title'],
              description: doc['description'],
              image1: doc['images'][0],
              price: doc['price'],
              rating: doc['rating'],
              category: doc['category'],
              discount: doc['discount'],
              iscart: false,
            );
          }).toList(),
        );
      },
    );
  }
}
