import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:backup/app/pages/home/widget/album.dart';
import 'package:backup/app/pages/home/widget/drawer.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:backup/app/widgets/empty.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: FGBPColors.White1,
        onPressed: controller.onTabFAB,
        child: SvgPicture.asset("assets/icons/add.svg"),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          _header(),
          const SizedBox(height: 24),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _gallary(),
                    const SizedBox(height: 24),
                    _todayStory(),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
      drawer: MainDrawer(),
    );
  }

  Widget _todayStory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Today's Story",
            style: FGBPTextTheme.head1,
          ),
          const SizedBox(height: 16),
          Obx(() {
            if (controller.todayStory == null) {
              return const Empty();
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.todayStory!.story.length,
              itemBuilder: (context, index) {
                Story item = controller.todayStory!.story[index];
                Profile user = controller.getProfile(item.userId!);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(user.picture),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${user.name} add this to ${item.album}",
                                style: FGBPTextTheme.text1Bold,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.createdAt.nowAgo,
                                style: FGBPTextTheme.text1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: FGBPColors.Brown4,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(item.image),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: FGBPColors.Black3,
                      thickness: 1,
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            );
          }),
        ],
      ),
    );
  }

  Widget _gallary() {
    return controller.obx(
      (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Gallary", style: FGBPTextTheme.head1),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: TabBar(
                          isScrollable: true,
                          controller: controller.tabController,
                          splashBorderRadius: BorderRadius.circular(100),

                          labelPadding: EdgeInsets.zero,

                          labelStyle: FGBPTextTheme.text4Bold,
                          unselectedLabelStyle:
                              FGBPTextTheme.text4Bold.copyWith(
                            color: FGBPColors.Black3,
                          ),

                          // circle indicaotr
                          indicator: CircleTabIndicator(
                              color: FGBPColors.Brown1, radius: 4),
                          indicatorPadding:
                              const EdgeInsets.only(left: 0, right: 16),
                          indicatorSize: TabBarIndicatorSize.label,

                          tabs: controller.myTabs.value
                              .map((e) => Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Text(e.name,
                                        style: FGBPTextTheme.text4Bold),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    FGBPIconButton("assets/icons/schedule.svg", onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 150, maxHeight: 350),
            child: Obx(
              () => TabBarView(
                controller: controller.tabController,
                children: controller.myTabs.value
                    .map((e) => _categoryAlbum(e))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
      onLoading: const Center(
          child: CircularProgressIndicator(
              color: FGBPColors.Brown1, strokeWidth: 10)),
    );
  }

  Widget _categoryAlbum(Category category) {
    List<Album> albums = controller.getAlbumsByCategory(category.id);

    if (albums.isEmpty) {
      return const Empty();
    }
    // horizontal axis
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: albums.map((album) => AlbumItem(album: album)).toList(),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FGBPIconButton("assets/icons/hamburger.svg",
              onTap: controller.openDrawer),
          Row(
            children: [
              const FGBPIconButton("assets/icons/search.svg"),
              const SizedBox(width: 16),
              const FGBPIconButton("assets/icons/notification.svg"),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {
                  //Open Drawer
                  controller.logout();
                },
                child: Obx(
                  () => Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(color: FGBPColors.Brown4, width: 2),
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(controller
                                .profileController.profile.value?.picture ??
                            "https://thumbs.gfycat.com/DrearyVastBighorn-size_restricted.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
}

class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height + radius);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}

extension NowAgo on DateTime {
  // 30분전
  String get nowAgo {
    final now = DateTime.now();
    final diff = now.difference(this);
    //몇년전
    if (diff.inDays > 365) {
      return "${diff.inDays ~/ 365}년전";
    }
    //몇달전
    if (diff.inDays > 30) {
      return "${diff.inDays ~/ 30}달전";
    }
    //몇주전
    if (diff.inDays > 7) {
      return "${diff.inDays ~/ 7}주전";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays}일 전";
    } else if (diff.inHours > 0) {
      return "${diff.inHours}시간 전";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}분 전";
    } else {
      return "방금 전";
    }
  }
}
