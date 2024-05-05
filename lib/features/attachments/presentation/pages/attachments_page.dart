import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/presentation/widgets/attachment_selector_modal_sheet.dart';
import 'package:think_tank/features/attachments/presentation/widgets/list_of_attachments.dart';

class AttachmentsPage extends StatelessWidget {
  static const routeName = '/attachments';
  const AttachmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          attachmentSelector(context);
        },
        child: const FaIcon(FontAwesomeIcons.plus),
      ),
      appBar: AppBar(
        title: Text('attachments'.tr()),
      ),
      body: const ListOfAttachments(),
    );
  }
}
