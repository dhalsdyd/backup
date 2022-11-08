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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(story.image, fit: BoxFit.cover)),
          Text(
            story.description ?? "",
            style: FGBPTextTheme.text2,
          ),
        ],
      ),
    );
  }
}
