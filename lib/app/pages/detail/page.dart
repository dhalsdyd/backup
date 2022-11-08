import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/pages/detail/widget/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class AlbumDetailPage extends StatelessWidget {
  AlbumDetailPage({Key? key}) : super(key: key);

  final AlbumDetail albumDetail = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Album Detail",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                  child: StaggeredGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: albumDetail.story
                    .map((e) => BaseStoryItem(story: e))
                    .toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
