import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MentionTextEditingController extends TextEditingController {
  final String mention;

  MentionTextEditingController({required this.mention}) {
    text = '$mention ';
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final mentionText = '$mention ';
    final fullText = text;

    if (fullText.startsWith(mentionText)) {
      return TextSpan(
        style: style,
        children: [
          TextSpan(
            text: mentionText,
            style: style?.copyWith(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),
          TextSpan(text: fullText.substring(mentionText.length), style: style),
        ],
      );
    }

    return TextSpan(text: fullText, style: style);
  }
}
