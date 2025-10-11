import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/common/widgets/custom_text_field.dart';

import 'package:evently_app/providers/auth_provider.dart';
import 'package:evently_app/screens/home/home_tab/views/events_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavTab extends StatelessWidget {
  const FavTab({super.key});

  @override
  Widget build(BuildContext context) {
    CurrantAuthProvider provider = Provider.of<CurrantAuthProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomTextField(
              borderColor: AppColors.mainColor,
              hintColor: AppColors.mainColor,
              hintText: 'Search for Event',
              prefixIcon: Icon(Icons.search, color: AppColors.mainColor),
            ),
          ),
          EventsListView(events: provider.userModel?.favEvents ?? []),
        ],
      ),
    );
  }
}
