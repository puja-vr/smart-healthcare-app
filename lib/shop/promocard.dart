import 'package:flutter/material.dart';
import 'package:smarthealthcare/shared/constants.dart';

class PromoCard extends StatelessWidget {
  final List<Color> bgColors = [kpinklight, kpinkdark];
  final String title;
  final String subtitle;
  String? caption = '';
  String? tag = '';
  String? imagePath = '';
  bool? reverseGradient = true;

  PromoCard({
    Key? key,
    required this.title,
    required this.subtitle,
    this.tag,
    this.caption,
    this.imagePath,
    this.reverseGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 250,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset.zero,
            blurRadius: 15.0,
          )
        ],
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: reverseGradient! ? bgColors.reversed.toList() : bgColors,
        ),
      ),
      child: Stack(
        children: [
          if (imagePath != null)
            Positioned(
              right: 0,
              bottom: 16.0,
              child: Image.asset(
                imagePath!,
              ),
            ),
          Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: tag != null
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                    decoration: BoxDecoration(
                      color: kpinkdark,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      tag!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        height: 1.5,
                      ),
                    ),
                  )
                : Text(
                    caption!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      height: 1.5,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
