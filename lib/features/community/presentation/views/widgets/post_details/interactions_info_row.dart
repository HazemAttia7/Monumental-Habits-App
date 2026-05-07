import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/utils/app_colors.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/post_interactions_avatars.dart';
import 'package:provider/provider.dart';

class InteractionsInfoRow extends StatefulWidget {
  final List<String> likedByUids;
  final int likesCount;

  const InteractionsInfoRow({
    super.key,
    required this.likedByUids,
    required this.likesCount,
  });

  @override
  State<InteractionsInfoRow> createState() => _InteractionsInfoRowState();
}

class _InteractionsInfoRowState extends State<InteractionsInfoRow> {
  List<String> _initials = [];

  @override
  void initState() {
    super.initState();
    _loadInitials();
  }

  @override
  void didUpdateWidget(InteractionsInfoRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.likedByUids, widget.likedByUids)) {
      _loadInitials();
    }
  }

  Future<void> _loadInitials() async {
    final initials = await context.read<AuthCubit>().getUsernameInitialsByUids(
      widget.likedByUids,
    );
    if (mounted) setState(() => _initials = initials);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        onTap: () => GoRouter.of(
          context,
        ).push(AppRouter.kLikesListView, extra: widget.likedByUids),
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.primaryColor.withValues(alpha: .1),
        highlightColor: AppColors.primaryColor.withValues(alpha: .1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PostInteractionsAvatars(
              firstInitial: _initials.isNotEmpty ? _initials[0] : null,
              secondInitial: _initials.length > 1 ? _initials[1] : null,
            ),
            LikesInfo(likesCount: widget.likesCount),
          ],
        ),
      ),
    );
  }
}

class LikesInfo extends StatelessWidget {
  final int likesCount;
  const LikesInfo({super.key, required this.likesCount});

  @override
  Widget build(BuildContext context) {
    return Text(_getLikesInfo(), style: AppStyles.textStyle14);
  }

  String _getLikesInfo() {
    return likesCount == 1 ? '$likesCount like' : '$likesCount likes';
  }
}
