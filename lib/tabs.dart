import 'package:flutter/material.dart';
import 'package:smarthealthcare/explore/explore.dart';
import 'package:smarthealthcare/home/home.dart';
import 'package:smarthealthcare/me/me.dart';
import 'package:smarthealthcare/services/database.dart';
import 'package:smarthealthcare/shop/cart.dart';
import 'package:smarthealthcare/shop/shop.dart';
import 'package:smarthealthcare/starters/splash.dart';
import 'package:smarthealthcare/services/auth.dart';
import 'package:smarthealthcare/shared/constants.dart';

class Tabs extends StatefulWidget {
  static String routeName = "/tabs";
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  late TabController _controller;
  final AuthService _auth = AuthService();
  final DatabaseService _firebaseServices = DatabaseService();

  @override
  void initState() {
    _controller = TabController(vsync: this, length: 4);

    _controller.addListener(() {
      setState(() {});
    });

    super.initState();
    _controller.index = 0;
  }

  @override
  Widget build(BuildContext context) {
    final uid = _firebaseServices.getUserId();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "FITNESS MATE",
            style: TextStyle(color: kpinkdark),
          ),
          actions: [
            if (_controller.index == 2)
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Cart.routeName);
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            if (_controller.index == 3)
              IconButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, SplashScreen.routeName, (route) => true);
                },
                icon: const Icon(Icons.logout),
              ),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            )),
          ),
          child: TabBar(
            controller: _controller,
            indicatorColor: Colors.transparent,
            unselectedLabelColor: kgrey,
            labelColor: kpinkdark,
            labelStyle: const TextStyle(fontSize: 10),
            tabs: [
              Tab(
                icon: Icon(
                    _controller.index == 0 ? Icons.home : Icons.home_outlined,
                    color: _controller.index == 0 ? kpinkdark : kgrey),
                text: "Home",
              ),
              Tab(
                icon: Icon(
                    _controller.index == 1
                        ? Icons.explore
                        : Icons.explore_outlined,
                    color: _controller.index == 1 ? kpinkdark : kgrey),
                text: "Explore",
              ),
              Tab(
                icon: Icon(
                    _controller.index == 2
                        ? Icons.shopping_bag
                        : Icons.shopping_bag_outlined,
                    color: _controller.index == 2 ? kpinkdark : kgrey),
                text: "Shop",
              ),
              Tab(
                icon: Icon(
                    _controller.index == 3
                        ? Icons.person
                        : Icons.person_outlined,
                    color: _controller.index == 3 ? kpinkdark : kgrey),
                text: "ME!",
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            Home(uid: uid),
            const Explore(),
            const Shop(),
            Me(uid: uid),
          ],
        ),
      ),
    );
  }
}
