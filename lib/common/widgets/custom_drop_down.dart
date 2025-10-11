import 'package:evently_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomDropDown<T> extends StatelessWidget {
  CustomDropDown({
    super.key,
    required this.title,
    required this.items,
    required this.onChanged,
    required this.value,
  });
  List<DropdownMenuItem<T>>? items;
  String title;
  T? value;
  final void Function(T?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(
        context,
      ).copyWith(focusColor: Colors.grey.withValues(alpha: .1)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              child: DropdownButtonFormField(
                initialValue: value,
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: AppColors.mainColor,
                ),
                padding: EdgeInsets.zero,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  border: _getBorder(AppColors.mainColor),
                  errorBorder: _getBorder(AppColors.errorColors),
                  focusedBorder: _getBorder(AppColors.mainColor),
                  enabledBorder: _getBorder(AppColors.mainColor),
                ),

                items: items,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
//List<String>