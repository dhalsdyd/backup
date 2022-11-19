import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/album.dart';
import 'package:backup/app/pages/add/controller.dart';
import 'package:backup/app/pages/add/view/capsule.dart';
import 'package:backup/app/pages/add/view/make.dart';
import 'package:backup/app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlbumPage extends StatelessWidget {
  AlbumPage({Key? key}) : super(key: key);

  final AddPageController controller = Get.find<AddPageController>();

  Widget _empty() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/empty.svg"),
        Text("There's no Album yet...",
            style: FGBPTextTheme.text4.copyWith(color: FGBPColors.Black3))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Album",
          style: FGBPTextTheme.text4Bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 16),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 35, right: 35, bottom: 35),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _albumOrCapsule(),
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

  Column _albumOrCapsule() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("RECENT", style: FGBPTextTheme.head2),
                  _addButton("+ Create-New-Album",
                      () => Get.to(() => MakeAlbumPage())),
                ],
              ),
              const SizedBox(height: 8),
              //album gridview
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Obx(() {
                  if (controller.albums.value.isEmpty) {
                    return Center(child: _empty());
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 149 / 172),
                    itemCount: controller.albums.value.length,
                    itemBuilder: (context, index) {
                      return albumItem(controller.albums.value[index], index);
                    },
                  );
                }),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Time Capsule", style: FGBPTextTheme.head2),
                  _addButton("+ Create-New-Capsule",
                      () => Get.to(() => MakeCapsulePage())),
                ],
              ),
              const SizedBox(height: 8),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 400),
                child: Obx(() {
                  if (controller.capsules.value.isEmpty) {
                    return Center(child: _empty());
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1),
                    itemCount: controller.capsules.value.length,
                    itemBuilder: (context, index) {
                      return albumItem(controller.capsules.value[index], index,
                          isCapsule: true);
                    },
                  );
                }),
              ),
            ],
          ),
        )),
        const SizedBox(height: 40),
        FGBPMediumTextButton(text: "Select-Album", onTap: controller.upload),
      ],
    );
  }

  GestureDetector _addButton(String text, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: FGBPColors.Black4),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(text,
                style: FGBPTextTheme.text2Bold.copyWith(
                    color: FGBPColors.Black2, fontWeight: FontWeight.w500)),
          ),
        ),
      ),
    );
  }

  Widget albumItem(Album album, int index, {bool isCapsule = false}) {
    return Obx(
      () => GestureDetector(
        onTap: () => isCapsule
            ? controller.selectCapsule(index)
            : controller.selectAlbum(index),
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            color: FGBPColors.Brown1,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(album.thumbnail ?? ""),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 10,
                offset: const Offset(0, 4), // changes position of shadow
              ),
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
                    style:
                        FGBPTextTheme.text2Bold.copyWith(color: Colors.white)),
              ),
              if (isCapsule
                  ? controller.checkCapsuleSelected(index)
                  : controller.checkSelected(index))
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
