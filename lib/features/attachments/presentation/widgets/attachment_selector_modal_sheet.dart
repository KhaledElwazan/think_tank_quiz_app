import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/attachments/presentation/blocs/bloc/attachments_bloc.dart';

Future<dynamic> attachmentSelector(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (_) => SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text('audio'.tr()),
            leading: const FaIcon(
              FontAwesomeIcons.microphone,
            ),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('feature_not_supported_yet'.tr()),
                ),
              );
            },
          ),
          ListTile(
            title: Text('camera'.tr()),
            leading: const FaIcon(
              FontAwesomeIcons.camera,
            ),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('feature_not_supported_yet'.tr()),
                ),
              );
            },
          ),
          ListTile(
            title: Text('gallery'.tr()),
            leading: const FaIcon(
              FontAwesomeIcons.images,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowMultiple: false,
                dialogTitle: 'select_image'.tr(),
                allowedExtensions: [
                  'jpg',
                  'png',
                  'jpeg',
                ],
              );

              BlocProvider.of<AttachmentsBloc>(context, listen: false).add(
                AddAttachmentEvent(File(result!.files.single.path!)),
              );
            },
          ),
          ListTile(
            title: Text('file'.tr()),
            leading: const FaIcon(
              FontAwesomeIcons.file,
            ),
            onTap: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('feature_not_supported_yet'.tr()),
                ),
              );
            },
          ),
          ListTile(
            title: Text('video'.tr()),
            leading: const FaIcon(
              FontAwesomeIcons.video,
            ),
            onTap: () async {
              Navigator.of(context).pop();
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: [
                  'mp4',
                  'avi',
                ],
              );

              BlocProvider.of<AttachmentsBloc>(context, listen: false).add(
                AddAttachmentEvent(File(result!.files.single.path!)),
              );
            },
          ),
        ],
      ),
    ),
  );
}
