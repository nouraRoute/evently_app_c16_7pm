import 'package:evently_app/common/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.hintText,
    this.validator,
    this.prefixIcon,
    this.borderColor,
    this.hintColor,
    this.title,
    this.maxLines = 1,
    this.controller,
    this.isPAssword = false,
  });
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLines;
  final String? title;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Color? borderColor, hintColor;
  final bool isPAssword;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool isPAssword = widget.isPAssword;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        if (widget.title != null)
          Text(widget.title!, style: Theme.of(context).textTheme.titleMedium),
        TextFormField(
          obscureText: isPAssword,
          controller: widget.controller,
          validator: widget.validator,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).hoverColor,
          ),
          maxLines: widget.maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: widget.hintText,

            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: widget.hintColor ?? Theme.of(context).hoverColor,
            ),
            suffixIcon: widget.isPAssword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isPAssword = !isPAssword;
                      });
                    },
                    icon: Icon(
                      isPAssword ? Icons.visibility_off : Icons.remove_red_eye,
                    ),
                  )
                : null,
            prefixIcon: widget.prefixIcon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: widget.prefixIcon,
                  ),
            border: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            focusedBorder: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
            errorBorder: _getBorder(AppColors.errorColors),
            enabledBorder: _getBorder(
              widget.borderColor ?? Theme.of(context).hintColor,
            ),
          ),
        ),
      ],
    );
  }

  _getBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: color),
    );
  }
}
