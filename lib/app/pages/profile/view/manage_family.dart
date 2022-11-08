import 'package:backup/app/core/theme/text_theme.dart';
import 'package:backup/app/data/models/user.dart';
import 'package:flutter/material.dart';

class ManageFamilyPage extends StatelessWidget {
  ManageFamilyPage({Key? key, required this.members}) : super(key: key);

  final List<Member> members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Manage Family",
          style: FGBPTextTheme.text4Bold,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(members[index].picture),
                    ),
                    title: Text(members[index].name),
                    subtitle: Text(members[index].email),
                    trailing: const Icon(Icons.more_vert),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
