import 'package:flutter/material.dart';
import 'package:smarthealthcare/services/database.dart';

class Likes extends StatefulWidget {
  final int likes;
  final String id;
  const Likes({Key? key, required this.id, required this.likes})
      : super(key: key);
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _ani;
  late Animatable _curve, _tween;
  final DatabaseService _firebaseServices = DatabaseService();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    _curve = CurveTween(curve: Curves.ease);
    _tween = Tween<double>(begin: 30, end: 40);
    _ani = _controller.drive(_curve).drive(_tween);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) _controller.reverse();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return IconButton(
              icon: Icon(
                Icons.thumb_up_alt,
                size: _ani.value,
              ),
              onPressed: () {
                _controller.forward();
                setState(() {
                  print(widget.likes);
                  _firebaseServices.updateBlogLikes(widget.id, widget.likes);
                });
              });
        });
  }
}
