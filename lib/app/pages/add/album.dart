import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/pages/add/controller.dart';
import 'package:backup/app/pages/add/make.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({Key? key}) : super(key: key);

  final AddPageController controller = Get.find<AddPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Select Album",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 35),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("RECENT", style: FGBPTextTheme.head2),
                  //album gridview
                  Expanded(
                    child: Obx(
                      () => GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: controller.albums.value.length,
                        itemBuilder: (context, index) {
                          return albumItem(
                              controller.albums.value[index], index);
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.to(() => MakeAlbumPage()),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: FGBPColors.Black3),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 4), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text("+ Create-New-Album",
                              style: FGBPTextTheme.text2Bold.copyWith(
                                  color: FGBPColors.Black2,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  FGBPMediumTextButton(
                      text: "Select-Album", onTap: controller.upload),
                ],
              ),
              Obx(() => controller.isUploading.isTrue
                  ? Center(
                      child: Stack(
                        children: <Widget>[
                          const Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                strokeWidth: 5,
                                color: FGBPColors.Brown1,
                              ),
                            ),
                          ),
                          Center(
                              child: Text(
                            "${controller.progress}%",
                            style: FGBPTextTheme.text2Bold,
                          )),
                        ],
                      ),
                    )
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

  Widget albumItem(Album album, int index) {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.selectAlbum(index),
        child: Container(
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
              if (controller.checkSelected(index))
                Positioned(
                  left: 14,
                  top: 14,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xff8ED967),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
