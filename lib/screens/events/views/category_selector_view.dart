import 'package:evently_app/common/theme/app_colors.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';

class CategorySelectorView extends StatelessWidget {
  const CategorySelectorView({
    super.key,
    required this.selectedCatId,
    required this.onChanged,
  });
  final int selectedCatId;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = CategoryModel.categories.sublist(1);
    return Column(
      spacing: 16,

      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(16),
          child: Image.asset(
            categories
                .firstWhere((element) => element.id == selectedCatId)
                .image!,
            height: 200,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),

        SizedBox(
          height: 40,
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(width: 8);
            },
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel currantCat = categories[index];
              bool isSelected = currantCat.id == selectedCatId;
              return FilterChip(
                selectedColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(46),
                ),
                side: BorderSide(color: AppColors.mainColor),
                backgroundColor: isSelected
                    ? AppColors.mainColor
                    : Theme.of(context).scaffoldBackgroundColor,
                showCheckmark: false,

                label: Row(
                  spacing: 5,
                  children: [
                    Icon(
                      currantCat.icon,
                      color: isSelected
                          ? AppColors.lightBgColors
                          : AppColors.mainColor,
                    ),
                    Text(
                      currantCat.title,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.lightBgColors
                            : AppColors.mainColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                onSelected: (value) {
                  onChanged(currantCat.id);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
