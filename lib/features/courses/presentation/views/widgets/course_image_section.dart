import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pixel_true_app/core/utils/assets_data.dart';

class CourseImageSection extends StatelessWidget {
  const CourseImageSection({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: imageUrl != null
          ? CachedNetworkImageProvider(imageUrl!)
          : const AssetImage(AssetsData.imagePlaceholder),
      height: 166.h,
      fit: BoxFit.cover,
    );
  }
}
