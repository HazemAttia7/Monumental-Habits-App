import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';

class FAQWidget extends StatelessWidget {
  final Map<String, String> faq;
  final void Function(int, bool)? expansionCallback;
  final bool isOpen;
  const FAQWidget({
    super.key,
    required this.faq,
    this.expansionCallback,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 350),
          elevation: 0,
          expandedHeaderPadding: EdgeInsets.zero,
          expansionCallback: expansionCallback,
          children: [
            ExpansionPanel(
              isExpanded: isOpen,
              backgroundColor: Colors.transparent,
              canTapOnHeader: true,
              splashColor: AppColors.secondaryColor.withValues(alpha: .1),
              highlightColor: AppColors.secondaryColor.withValues(alpha: .1),
              headerBuilder: (context, isExpanded) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        faq['question']!,
                        style: AppStyles.textStyle16.copyWith(
                          fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
                          color: Colors.black,
                          overflow: isExpanded ? null : TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.only(
                  top: 8.w,
                  left: 18.w,
                  right: 18.w,
                  bottom: 16.w,
                ),
                child: Text(
                  faq['answer']!,
                  style: AppStyles.textStyle14.copyWith(
                    fontFamily: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w400,
                    ).fontFamily,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
