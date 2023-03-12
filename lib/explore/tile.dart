import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/likes.dart';
import 'package:smarthealthcare/explore/blog.dart';
import 'package:smarthealthcare/shared/constants.dart';

class Tile extends StatelessWidget {
  final String id, title, content, author, date, image;
  final int likes, bid;

  const Tile({
    Key? key,
    required this.title,
    required this.likes,
    required this.author,
    required this.date,
    required this.bid,
    required this.content,
    required this.image,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Blog(id: id, bid: bid)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kback,
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 15.0,
            )
          ],
        ),
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Hero(
              tag: bid,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    height: 1.5,
                    color: kblack,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kpink,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "$date",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 80),
                    Likes(id: id, likes: likes),
                    Text(
                      "$likes",
                      style: const TextStyle(fontSize: 13, color: kpinkdark),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 220,
                  child: Text(
                    "$content",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
