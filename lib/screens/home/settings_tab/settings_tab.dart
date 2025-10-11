import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/common/widgets/custom_drop_down.dart';
import 'package:evently_app/gen/assets.gen.dart';
import 'package:evently_app/providers/app_settings_provider.dart';
import 'package:evently_app/screens/home/settings_tab/view/settingd_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsHeaderView(),
        CustomDropDown<String>(
          value: Provider.of<AppSettingsProvider>(context).appLocalization,
          onChanged: (value) {
            if (value != null) {
              Provider.of<AppSettingsProvider>(
                context,
                listen: false,
              ).changeLocal(value);
            }
          },
          title: 'Language', //TODO:localization
          items: [
            DropdownMenuItem(
              value: 'ar',
              child: Text(
                'Arabic',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            DropdownMenuItem(
              value: 'en',
              child: Text(
                'English',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ],
        ),
        CustomDropDown<ThemeMode>(
          value: Provider.of<AppSettingsProvider>(context).currantThemeMode,
          onChanged: (ThemeMode? mode) {
            if (mode != null) {
              Provider.of<AppSettingsProvider>(
                context,
                listen: false,
              ).changeThemeMode(mode);
            }
          },
          title: 'Theme',

          items: [
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(
                'Light',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.mainColor,
                ),
              ),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(
                'Dark',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
