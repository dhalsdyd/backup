import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:flutter/material.dart';

class BaseStoryItem extends StatelessWidget {
  const BaseStoryItem({Key? key, required this.story, this.height, this.width})
      : super(key: key);

  final Story story;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 5,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(story.image, fit: BoxFit.cover)),
                ],
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                decoration: const BoxDecoration(
                    color: Color(0xffd1d1d1), shape: BoxShape.circle),
                child: Icon(Icons.more_horiz),
              ),
            )
          ],
        ),
        const SizedBox(height: 8),
        Text(
          story.description ?? "",
          style: FGBPTextTheme.text2,
        ),
      ],
    );
  }
}
