import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/pages/detail/widget/story.dart';
import 'package:backup/app/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlbumDetailPage extends StatelessWidget {
  AlbumDetailPage({Key? key}) : super(key: key);

  final AlbumDetail? albumDetail = Get.arguments["detail"];
  final String thumbnail = Get.arguments["thumbnail"];
  final bool isCapsule = Get.arguments["isCapsule"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: FGBPColors.White1,
        onPressed: () async {
          FGBPActionType? result = await FGBPBottomSheet([]).show();
        },
        child: SvgPicture.asset("assets/icons/add.svg"),
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Expanded(
                    flex: 4,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          thumbnail,
                          color: FGBPColors.Black1.withOpacity(0.4),
                          colorBlendMode: BlendMode.dstATop,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 36, vertical: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //backIcon
                              GestureDetector(
                                  onTap: () => Get.back(),
                                  child: const Icon(Icons.arrow_back_ios,
                                      color: Colors.white)),
                              const SizedBox(height: 16),
                              if (isCapsule)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      albumDetail!.name,
                                      style: FGBPTextTheme.head1
                                          .copyWith(color: Colors.white),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            albumDetail!.description ?? "",
                                            style: FGBPTextTheme.text2.copyWith(
                                                color: FGBPColors.Black4),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        const Icon(Icons.more_vert,
                                            color: Colors.white)
                                      ],
                                    ),
                                    const SizedBox(height: 30),
                                    Text(
                                      "Memory With :",
                                      style: FGBPTextTheme.text2.copyWith(
                                          color: FGBPColors.Black3,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 8),

                              if (isCapsule)
                                Row(
                                    children: albumDetail!.contributors
                                        .map((e) => Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                                image: DecorationImage(
                                                    image:
                                                        NetworkImage(e.picture),
                                                    fit: BoxFit.cover),
                                              ),
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                            ))
                                        .toList()),
                            ],
                          ),
                        ),
                      ],
                    )),
                const Expanded(
                  flex: 6,
                  child: SizedBox(),
                ),
              ],
            ),
            _modalSheet()
          ],
        ),
      ),
    );
  }

  DraggableScrollableSheet _modalSheet() {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: .65,
      minChildSize: .65,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xffd1d1d1),
                          borderRadius: BorderRadius.all(Radius.circular(100))),
                      height: 5,
                      width: 130,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (isCapsule)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "${albumDetail!.story.length} ${albumDetail!.story.length == 1 ? "Story" : "Stories"}",
                                style: FGBPTextTheme.text4Bold),
                            const Icon(Icons.more_horiz)
                          ],
                        ),
                        const SizedBox(height: 16),
                        StaggeredGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          children: albumDetail!.story
                              .map((e) => BaseStoryItem(story: e))
                              .toList(),
                        ),
                      ],
                    )
                  else
                    Center(
                      child: Text("LOCKED",
                          style: FGBPTextTheme.text4Bold.copyWith(
                              color: FGBPColors.Black3, fontSize: 16)),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
