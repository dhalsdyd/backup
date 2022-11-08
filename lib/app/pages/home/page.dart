import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/data/models/category.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:backup/app/pages/home/widget/drawer.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomePageController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        child: const FGBPIconButton("assets/icons/add.svg"),
        closeButtonStyle: const ExpandableFabCloseButtonStyle(
            backgroundColor: Colors.transparent,
            child: FGBPIconButton("assets/icons/cross.svg")),
        distance: 70,
        type: ExpandableFabType.up,
        children: [
          FGBPIconButton("assets/icons/media.svg", onTap: controller.openVideo),
          FGBPIconButton("assets/icons/camera.png",
              onTap: controller.openCamera),
          FGBPIconButton("assets/icons/folder.png", onTap: controller.pickFile)
        ],
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const SizedBox(height: 36),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _gallary(),
                    const SizedBox(height: 36),
                    const Text("Recent", style: FGBPTextTheme.head1),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
      drawer: MainDrawer(),
    );
  }

  Widget _gallary() {
    return controller.obx(
      (_) => Column(
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
                      tabs: controller.myTabs.value
                          .map((e) => Text(
                                e.name,
                                style: FGBPTextTheme.text4Bold,
                              ))
                          .toList(),
                      unselectedLabelStyle: FGBPTextTheme.text4Bold.copyWith(
                        color: FGBPColors.Black3,
                      ),
                      // circle indicaotr
                      indicator: CircleTabIndicator(
                          color: FGBPColors.Brown1, radius: 3)),
                ),
              ),
              FGBPIconButton("assets/icons/schedule.svg", onTap: () {}),
            ],
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 150, maxHeight: 300),
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
    );
  }

  Widget _categoryAlbum(Category category) {
    List<Album> albums = controller.getAlbumsByCategory(category.id);

    if (albums.isEmpty) {
      return _empty();
    }

    // horizontal axis
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: albums
            .map(
              (album) => GestureDetector(
                onTap: () => controller.detailPage(album.id),
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  height: 250,
                  width: 200,
                  decoration: BoxDecoration(
                    color: FGBPColors.Brown1,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(album.thumbnail ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Text(
                          album.name,
                          style: FGBPTextTheme.text4Bold,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Text(album.description ?? ""),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/empty.svg"),
        Text("There's no memory yet...",
            style: FGBPTextTheme.text4.copyWith(color: FGBPColors.Black3))
      ],
    );
  }

  Row _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FGBPIconButton("assets/icons/hamburger.png",
            onTap: controller.openDrawer),
        Row(
          children: [
            const FGBPIconButton("assets/icons/search.svg"),
            const SizedBox(width: 12),
            const FGBPIconButton("assets/icons/notification.svg"),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                //Open Drawer
                controller.logout();
              },
              child: Obx(
                () => Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          controller.profileController.profile.value?.picture ??
                              ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
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
