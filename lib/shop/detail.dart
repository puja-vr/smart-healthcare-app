import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/shop/imageswipe.dart';

class Detail extends StatefulWidget {
  static String routeName = "/details";
  final String id, pid;
  const Detail({Key? key, this.pid = '', this.id = ''}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final DatabaseService _firebaseServices = DatabaseService();
  late dynamic docData = {};

  _snackBar({text}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.fromLTRB(20, 7, 0, 7),
      content: Text(text, style: const TextStyle(color: kwhite, fontSize: 16)),
      backgroundColor: kpurple,
      duration: defaultDuration,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseServices.productCollection
            .doc(widget.id)
            .get()
            .then((DocumentSnapshot docSnap) {
          if (docSnap.exists) {
            docData = docSnap.data();
          } else {
            print('Document does not exist on the database');
          }
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List images = docData['images'];

            return SafeArea(
              child: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ImageSwipe(pid: docData['pid'], images: images),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${docData['title']}",
                              style: const TextStyle(
                                color: kpurple,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(15),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: kpink,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "${docData['discount']}%",
                                    style: const TextStyle(
                                      color: kwhite,
                                      fontSize: 20,
                                      height: 1.5,
                                    ),
                                  ),
                                  const Text(
                                    "off",
                                    style: TextStyle(
                                      color: kwhite,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text(
                          "${docData['description']}",
                          style: const TextStyle(
                            fontSize: 17.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: kpurple[100],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          "\u{20B9} ${docData['price']}",
                          style: const TextStyle(
                            color: kblack,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 30),
                        child: const Text(
                          "RATING",
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Row(
                          children: [
                            RatingBar.builder(
                              initialRating: docData['rating'],
                              minRating: 1,
                              itemSize: 30,
                              ignoreGestures: true,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: const EdgeInsets.only(right: 3),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) => print(rating),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${docData['rating']}",
                              style: const TextStyle(
                                  fontSize: 18.0, color: kpurple),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                floatingActionButton: footerButtons(context),
              ),
            );
          }

          // Loading State
          return const Loading();
        });
  }

  Widget footerButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          child: const Icon(Icons.add_shopping_cart),
          onPressed: () async {
            await _firebaseServices.addToCart(id: widget.id, pid: widget.pid);
            _snackBar(text: "Added to the cart");
          },
          heroTag: "fab",
          backgroundColor: kpurple,
          tooltip: 'Add to Cart',
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
