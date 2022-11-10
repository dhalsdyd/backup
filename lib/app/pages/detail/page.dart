import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/pages/detail/widget/story.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class AlbumDetailPage extends StatelessWidget {
  AlbumDetailPage({Key? key}) : super(key: key);

  final AlbumDetail albumDetail = Get.arguments["detail"];
  final String thumbnail = Get.arguments["thumbnail"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 4,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(thumbnail, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //backIcon
                          GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white)),
                          Text(
                            albumDetail.name,
                            style: FGBPTextTheme.head1
                                .copyWith(color: Colors.white),
                          ),
                          Text(
                            albumDetail.description ?? "",
                            style: FGBPTextTheme.text2
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            "Memory With :",
                            style: FGBPTextTheme.text2
                                .copyWith(color: Colors.white),
                          ),
                          const SizedBox(height: 8),

                          Row(
                              children: albumDetail.contributors
                                  .map((e) => Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                          image: DecorationImage(
                                              image: NetworkImage(e.picture),
                                              fit: BoxFit.cover),
                                        ),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                      ))
                                  .toList()),
                        ],
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${albumDetail.story.length} Stories",
                            style: FGBPTextTheme.text4Bold),
                        const SizedBox(height: 16),
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: albumDetail.story
                              .map((e) => BaseStoryItem(story: e))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
