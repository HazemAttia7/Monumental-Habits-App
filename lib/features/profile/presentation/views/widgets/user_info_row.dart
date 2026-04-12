import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/enums/profile_enums.dart';
import 'package:pixel_true_app/core/widgets/profile_placeholder.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/enum_dropdown.dart';
import 'package:pixel_true_app/features/profile/presentation/views/widgets/name_widget.dart';

class UserInfoRow extends StatelessWidget {
  final void Function(enProfileFilterBy) onDropdownChanged;
  const UserInfoRow({super.key, required this.onDropdownChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfilePlaceholder(
          width: 60.w,
          height: 60.h,
          fontSize: 20.sp,
          userName: context.watch<AuthCubit>().currentUser?.name ?? "",
        ),
        Gap(10.w),
        const NameWidget(),
        const Spacer(),
        EnumDropdown<enProfileFilterBy>(
          options: enProfileFilterBy.values,
          initialValue: enProfileFilterBy.week,
          labelBuilder: (v) => 'This ${v.name}',
          onSelected: onDropdownChanged,
        ),
      ],
    );
  }
}
