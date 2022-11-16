import 'package:backup/app/core/theme/color_theme.dart';
import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageFamilyPage extends StatelessWidget {
  ManageFamilyPage({Key? key, required this.members}) : super(key: key);

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Family",
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
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                NetworkImage(members[index].picture),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(members[index].name,
                                  style: FGBPTextTheme.text1Bold),
                              Text(members[index].email,
                                  style: FGBPTextTheme.text1
                                      .copyWith(color: FGBPColors.Black3)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
