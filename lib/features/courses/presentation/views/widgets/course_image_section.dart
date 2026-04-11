import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';
import 'package:shimmer/shimmer.dart';

class CourseImageSection extends StatelessWidget {
  const CourseImageSection({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Ink.image(
        image: const AssetImage(AssetsData.imagePlaceholder),
        height: 166.h,
        fit: BoxFit.cover,
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      height: 166.h,
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
