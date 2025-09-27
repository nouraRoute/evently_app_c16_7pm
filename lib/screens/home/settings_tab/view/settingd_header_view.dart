import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

class SettingsHeaderView extends StatelessWidget {
  const SettingsHeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              spacing: 16,
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.only(
                    bottomLeft: Radius.circular(62),
                    bottomRight: Radius.circular(62),
                    topRight: Radius.circular(62),
                  ),
                  child: Assets.image.logoImage.image(
                    height: 124,
                    width: 124,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'data', //TODO:sow user data
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.lightBgColors,
                      ),
                    ),
                    Text(
                      'data',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightBgColors,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
