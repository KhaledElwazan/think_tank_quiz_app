import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/presentation/pages/attachments_page.dart';

class CreateAttachmentPage extends StatefulWidget {
  static const routeName = '${AttachmentsPage.routeName}/create_attachment';
  const CreateAttachmentPage({super.key});

  @override
  State<CreateAttachmentPage> createState() => _CreateAttachmentPageState();
}

class _CreateAttachmentPageState extends State<CreateAttachmentPage> {
  // create a key for the form
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('create_attachment'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic here
        },
        child: const FaIcon(FontAwesomeIcons.floppyDisk),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
