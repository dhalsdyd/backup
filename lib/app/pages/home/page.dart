import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _gallary(),
                ],
              ),
            ),
          )
        ],
      )),
      drawer: MainDrawer(),
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
          FGBPIconButton("assets/icons/hamburger.png",
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
