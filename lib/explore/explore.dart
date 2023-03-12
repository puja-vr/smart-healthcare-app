import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smarthealthcare/components/loading.dart';
import 'package:smarthealthcare/explore/tile.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/shared/constants.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late dynamic data;
  bool isfiltered = false;
  final DatabaseService _firebaseServices = DatabaseService();

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
                hintText: 'Search...',
              ),
            ),
          ),
          StreamBuilder(
            stream: isfiltered
                ? data
                : _firebaseServices.blogCollection.snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: snapshot.data!.docs.map((doc) {
                      return Tile(
                        id: doc.id,
                        bid: doc['bid'],
                        title: doc['title'],
                        content: doc['content'],
                        image: doc['image'],
                        date: doc['date'],
                        likes: doc['likes'],
                        author: doc['author'],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
