import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/pages/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumItem extends StatelessWidget {
  final Album album;

  const AlbumItem({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<HomePageController>()
          .detailPage(album.id, album.thumbnail ?? ""),
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        height: 335,
        width: 241,
        decoration: BoxDecoration(
          color: FGBPColors.Brown1,
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: NetworkImage(album.thumbnail ?? ""),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: FGBPColors.Black1.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 3,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              bottom: 10,
              child: Text(
                album.name,
                style: FGBPTextTheme.head2.copyWith(color: Colors.white),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Text(album.description ?? "",
                  style: FGBPTextTheme.text1Bold.copyWith(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
