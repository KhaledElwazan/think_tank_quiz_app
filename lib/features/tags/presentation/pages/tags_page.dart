import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:think_tank/features/tags/presentation/pages/create_tag_page.dart';
import 'package:think_tank/features/tags/presentation/widgets/list_of_tags.dart';

class TagsViewerPage extends StatelessWidget {
  static const routeName = '/tags-viewer';
  const TagsViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CreateTagPage.routeName);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('tags'.tr()),
      ),
      body: const ListOfTags(),
    );
  }
}
