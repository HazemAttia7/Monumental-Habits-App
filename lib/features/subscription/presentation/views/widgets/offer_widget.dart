import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/helper/service_locator.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/countdown_from_date.dart';
import 'package:pixel_true_app/features/subscription/presentation/views/widgets/shimmer/count_down_from_date_shimmer.dart';
import 'package:provider/provider.dart';

class OfferWidget extends StatefulWidget {
  const OfferWidget({super.key});

  @override
  State<OfferWidget> createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  late Future<DateTime?> _initExpiryDate;

  @override
  void initState() {
    super.initState();
    _initExpiryDate = _fetchExpiryDate(context);
  }

  Future<DateTime?> _fetchExpiryDate(BuildContext context) async {
    final uid = context.read<AuthCubit>().currentUser?.uid;
    if (uid == null) return null;

    final doc = await sl<FirebaseFirestore>()
        .collection('users')
        .doc(uid)
        .get();

    final timestamp = doc.data()?['offerExpiresAt'] as Timestamp?;
    return timestamp?.toDate() ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.r),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          children: [
            Positioned(
              top: -42.sp,
              right: -85.sp,
              child: Image.asset(AssetsData.teepeeSwirly, width: 260.w),
            ),
            Container(
              padding: EdgeInsets.all(24.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "60% off your upgrade",
                    style: AppStyles.textStyle20.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    "Expires in",
                    style: AppStyles.textStyle12.copyWith(
                      color: AppColors.secondaryColor.withValues(alpha: .5),
                    ),
                  ),
                  Gap(8.h),
                  FutureBuilder<DateTime?>(
                    future: _initExpiryDate,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CountDownFromDateShimmer();
                      }
                      final endTime = snapshot.data;
                      if (endTime == null) return const SizedBox.shrink();
                      return CountdownFromDate(endTime: endTime);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
