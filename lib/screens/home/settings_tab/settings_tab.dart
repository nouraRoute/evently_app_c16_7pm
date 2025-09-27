import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/common/widgets/custom_drop_down.dart';
import 'package:evently_app/gen/assets.gen.dart';
import 'package:evently_app/screens/home/settings_tab/view/settingd_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsHeaderView(),
        CustomDropDown<String>(
          title: 'Language', //TODO:localization
          items: [
            DropdownMenuItem(
              child: Text(
                'Arabic',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.mainColor,
                ),
              ),
              value: '1',
            ),
            DropdownMenuItem(
              child: Text(
                'English',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.mainColor,
                ),
              ),
              value: '2',
            ),
          ],
        ),
        CustomDropDown<String>(
          title: 'Theme',
          items: [
            DropdownMenuItem(
              child: Text(
                'Light',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.mainColor,
                ),
              ),
              value: '1',
            ),
            DropdownMenuItem(
              child: Text(
                'Dark',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColors.mainColor,
                ),
              ),
              value: '2',
            ),
          ],
        ),
      ],
    );
  }
}
