import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    required this.baseColor,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.checkColor,
    required this.textStyle,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final String text;
  final Color baseColor;
  final Color? checkColor;
  final TextStyle textStyle;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    final bool isChecked = widget.value;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        _buildCheckbox(isChecked),
        SizedBox(width: 11.sp),
        Flexible(child: _buildText(isChecked)),
      ],
    );
  }

  GestureDetector _buildText(bool isChecked) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Text(widget.text, style: widget.textStyle),
    );
  }

  Widget _buildCheckbox(bool isChecked) {
    return Transform.scale(
      scale: 1,
      child: SizedBox(
        width: 20.sp,
        height: 20.sp,
        child: Checkbox(
          value: isChecked,
          onChanged: widget.onChanged,
          checkColor: widget.checkColor ?? Colors.white,
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return widget.baseColor;
            }
            return Colors.white;
          }),
          side: BorderSide(color: widget.baseColor, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );
  }
}
