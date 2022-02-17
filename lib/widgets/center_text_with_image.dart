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
      child: SizedBox(
        height: 400,
        child: Column(
          children: [
            Image.asset(image),
            Text(
              title,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                // height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
