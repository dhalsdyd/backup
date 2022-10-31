import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
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
          FGBPIconButton("assets/icons/folder.svg", onTap: () {}),
          FGBPIconButton("assets/icons/media.svg", onTap: () {}),
          FGBPIconButton("assets/icons/camera.svg", onTap: () {}),
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
                    Text("Recent", style: FGBPTextTheme.head1),
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

  Column _gallary() {
    return Column(
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
                    tabs: controller.myTabs
                        .map((e) => Text(
                              e,
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
          constraints: const BoxConstraints(minHeight: 150, maxHeight: 250),
          child: TabBarView(
            controller: controller.tabController,
            children: [
              _empty(),
              _empty(),
              _empty(),
            ],
          ),
        ),
      ],
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
        const FGBPIconButton("assets/icons/hamburger.svg"),
        Row(
          children: [
            const FGBPIconButton("assets/icons/search.svg"),
            const SizedBox(width: 12),
            const FGBPIconButton("assets/icons/notification.svg"),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                //Open Drawer
                controller.openDrawer();
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8),
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
