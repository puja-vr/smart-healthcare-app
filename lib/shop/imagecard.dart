import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/shared/constants.dart';
import 'package:smarthealthcare/shop/cart.dart';
import 'package:smarthealthcare/shop/detail.dart';

class ImageCard extends StatelessWidget {
  ImageCard({
    Key? key,
    required this.title,
    required this.category,
    required this.discount,
    required this.price,
    required this.rating,
    required this.pid,
    required this.description,
    required this.image1,
    required this.id,
    required this.iscart,
  }) : super(key: key);

  final String id, title, pid, description, image1;
  final int category, price, discount;
  final double rating;
  final bool iscart;
  final DatabaseService _firebaseServices = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(id: id, pid: pid)),
        );
      },
      child: Container(
        width: iscart ? 350 : 250,
        height: 160,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: kwhite,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: kblack.withOpacity(.2),
              offset: Offset.zero,
              blurRadius: 15.0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      color: kpink,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "${discount}% off",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        height: 1.5,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      height: 1.5,
                      color: kblack,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '\u{20B9} ${price}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: kpurple,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    itemSize: 20,
                    ignoreGestures: true,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.zero,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) => print(rating),
                  ),
                  Text(
                    "${rating}",
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            Hero(
              tag: pid,
              child: Container(
                height: double.infinity,
                width: iscart ? 130 : 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: NetworkImage(image1),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            if (iscart) const SizedBox(width: 30),
            if (iscart)
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      _firebaseServices.removeFromCart(id: id);
                      Cart.of(context)!.minusPrice(price);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 30,
                    )),
              ),
          ],
        ),
      ),
    );
  }
}
