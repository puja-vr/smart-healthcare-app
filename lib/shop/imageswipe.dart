import 'package:flutter/material.dart';
import 'package:smarthealthcare/shared/constants.dart';

class ImageSwipe extends StatefulWidget {
  final List images;
  final String pid;
  const ImageSwipe({Key? key, required this.pid, required this.images})
      : super(key: key);

  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (no) {
              setState(() {
                _selectedPage = no;
              });
            },
            children: [
              for (var i = 0; i < widget.images.length; i++)
                Hero(
                  tag: widget.pid,
                  child: Container(
                    height: double.infinity,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      image: DecorationImage(
                        image: NetworkImage(widget.images[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
            ],
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.images.length; i++)
                  AnimatedContainer(
                    duration: kAnimationDuration,
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    width: _selectedPage == i ? 35.0 : 10.0,
                    height: 10.0,
                    decoration: BoxDecoration(
                        color: kpurple,
                        borderRadius: BorderRadius.circular(12.0)),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
