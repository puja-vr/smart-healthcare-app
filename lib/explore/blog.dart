import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smarthealthcare/components/likes.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/shared/constants.dart';

class Blog extends StatefulWidget {
  static String routeName = "/blog";
  final String id;
  final int bid;
  const Blog({Key? key, this.bid = 0, this.id = ''}) : super(key: key);

  @override
  _BlogState createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  final DatabaseService _firebaseServices = DatabaseService();
  late dynamic s;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _firebaseServices.blogCollection
            .where('bid', isEqualTo: widget.bid)
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
          s = snapshot.data!.docs[0];
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  Row(
                    children: [
                      Text(
                        '${s['likes']}',
                        style: const TextStyle(color: kpinkdark),
                      ),
                      Likes(id: widget.id, likes: s['likes']),
                    ],
                  ),
                ],
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${s['title']}",
                      style: const TextStyle(
                        color: kpurple,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "- ${s['author']}",
                      style: const TextStyle(
                        color: kpinkdark,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: kpink,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Text(
                        "${s['date']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          height: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${s['content']}",
                      style: const TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Hero(
                      tag: widget.bid,
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: DecorationImage(
                            image: NetworkImage(s['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "${s['content']}",
                      style: const TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );

          // Loading State
          // return const Loading();
        });
  }
}
