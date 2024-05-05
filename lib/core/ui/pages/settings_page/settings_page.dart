import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatefulWidget {
  static const String routeName = '/settings';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      isDark = AdaptiveTheme.of(context).mode.isDark;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr()),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('common'.tr()),
            tiles: [
              SettingsTile.switchTile(
                onToggle: (value) {
                  if (value) {
                    AdaptiveTheme.of(context).setDark();
                  } else {
                    AdaptiveTheme.of(context).setLight();
                  }

                  setState(() {
                    isDark = !isDark;
                  });
                },
                initialValue: isDark,
                leading: isDark
                    ? const Icon(Icons.nightlight_round)
                    : const Icon(Icons.wb_sunny),
                title: Text('theme_mode'.tr()),
              ),
              SettingsTile(
                title: Text('language'.tr()),
                leading: const Icon(Icons.language),
                onPressed: (context) {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'select_language'.tr(),
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Text('English'),
                              onTap: () {
                                EasyLocalization.of(context)!
                                    .setLocale(const Locale('en'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('العربية'),
                              onTap: () {
                                EasyLocalization.of(context)!
                                    .setLocale(const Locale('ar'));
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('Deutsch'),
                              onTap: () {
                                EasyLocalization.of(context)!
                                    .setLocale(const Locale('de'));

                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              title: const Text('日本語'),
                              onTap: () {
                                EasyLocalization.of(context)!
                                    .setLocale(const Locale('ja'));
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
