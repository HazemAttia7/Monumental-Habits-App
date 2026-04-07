import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseImageSection extends StatelessWidget {
  const CourseImageSection({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: CachedNetworkImageProvider(imageUrl),
      height: 166.h,
      fit: BoxFit.cover,
    );
  }
}
