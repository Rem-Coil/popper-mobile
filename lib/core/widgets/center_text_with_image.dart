import 'package:flutter/material.dart';

class CenterTextWithImage extends StatelessWidget {
  final String image;
  final String title;

  const CenterTextWithImage({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 385,
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            Image.asset(image),
            Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 34),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
