import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:think_tank/features/tags/domain/entities/tag/tag.dart';
import 'package:think_tank/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:think_tank/features/tags/presentation/widgets/select_tag_widget.dart';

class CreateTagPage extends StatefulWidget {
  static const routeName = '/create-tag';
  const CreateTagPage({super.key});

  @override
  State<CreateTagPage> createState() => _CreateTagPageState();
}

class _CreateTagPageState extends State<CreateTagPage> {
  final TextEditingController titleController = TextEditingController();
  Color color = Colors.blue;

  // create a key for the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('create_tag'.tr()),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.listUl),
            onPressed: () async {
              // Navigator.of(context).pop();
              return await showModalBottomSheet(
                context: context,
                builder: (context) => const SelectTagModal(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // validate the form
          if (!_formKey.currentState!.validate()) {
            return;
          }

          int colorInt = convertColor(color);
          String title = titleController.text;
          Tag tag = Tag(title: title, color: colorInt);
          BlocProvider.of<TagsBloc>(context).add(CreateTagEvent(tag: tag));

          _formKey.currentState!.reset();
          Navigator.of(context).pop();
        },
        child: const FaIcon(FontAwesomeIcons.check),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<TagsBloc, TagsState>(
            listener: (context, state) {
              if (state is TagCreatedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('success'.tr()),
                  ),
                );
              } else if (state is TagsFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('error'.tr()),
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                children: <Widget>[
                  Text(
                    'tag_title'.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Card(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'please_enter_a_title'.tr();
                            }
                            return null;
                          },
                          autocorrect: true,
                          enableSuggestions: true,
                          maxLines: 1,
                          maxLength: 10,
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: 'title'.tr(),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'tag_color'.tr(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ColorPicker(
                            color: color,
                            onColorChanged: (color) {
                              setState(() {
                                this.color = color;
                              });
                            },
                            borderRadius: 22,
                            heading: Text(
                              'select_color'.tr(),
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            subheading: Text(
                              'select_color_shade'.tr(),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // convert color to int
  int convertColor(Color color) {
    return int.parse(color.hexAlpha, radix: 16);
  }
}
