import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pixel_true_app/core/helper/build_not_implemented_yet_dialog.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:shimmer/shimmer.dart';

class CourseVideo extends StatelessWidget {
  final String? imageUrl;
  const CourseVideo({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: imageUrl ?? '',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Material(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // play leeson using cdn
              buildNotImplementedYetDialog(
                context,
                featureName: 'Video Player',
              );
            },
            borderRadius: BorderRadius.circular(16.r),
            splashColor: AppColors.primaryColor.withValues(alpha: .1),
            highlightColor: AppColors.primaryColor.withValues(alpha: .1),
            child: Stack(
              children: [
                _CourseImage(imageUrl: imageUrl),
                Positioned.fill(
                  child: Container(color: Colors.black.withValues(alpha: .2)),
                ),
                const Positioned.fill(child: _PlayButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 45.h,
        width: 45.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2.sp),
        ),
        child: Center(
          child: Icon(FontAwesomeIcons.play, color: Colors.white, size: 16.sp),
        ),
      ),
    );
  }
}

class _CourseImage extends StatelessWidget {
  const _CourseImage({required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? '',
      height: 200.h,
      fit: BoxFit.cover,
      imageBuilder: (context, imageProvider) =>
          Ink.image(image: imageProvider, height: 166.h, fit: BoxFit.cover),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 166.h,
          width: double.infinity,
          color: Colors.grey.shade300,
        ),
      ),
      errorWidget: (context, url, error) => Ink.image(
        image: const AssetImage(AssetsData.imagePlaceholder),
        height: 166.h,
        fit: BoxFit.cover,
      ),
    );
  }
}
