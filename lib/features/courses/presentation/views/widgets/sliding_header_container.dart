import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/utils/app_styles.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/main/presentation/managers/main_view_controller.dart';
import 'package:provider/provider.dart';

class SlidingHeaderContainer extends StatefulWidget {
  const SlidingHeaderContainer({super.key});

  @override
  State<SlidingHeaderContainer> createState() => _SlidingHeaderContainerState();
}

class _SlidingHeaderContainerState extends State< SlidingHeaderContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slideOut;
  late final Animation<Offset> _slideIn;
  final _focus = FocusNode();
  final searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    final curve = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);

    _slideOut = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0),
    ).animate(curve);

    _slideIn = Tween<Offset>(
      begin: const Offset(1.0, 0),
      end: Offset.zero,
    ).animate(curve);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _focus.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _open() {
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 200), _focus.requestFocus);
  }

  void _close() {
    searchController.clear();
    _ctrl.reverse();
    _focus.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          SlideTransition(
            position: _slideIn,
            child: Row(
              children: [
                CustomIconButton(onTap: _close, icon: FontAwesomeIcons.xmark),
                Gap(8.w),
                Expanded(
                  child: CustomTextFormField(
                    controller: searchController,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    focusNode: _focus,
                    hintText: 'Search courses...',
                    fillColor: Colors.white.withValues(alpha: .5),
                  ),
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _slideOut,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  onTap: () => Provider.of<MainViewController>(
                    context,
                    listen: false,
                  ).openSideMenu(),
                  icon: FontAwesomeIcons.equals,
                ),
                Text('Courses', style: AppStyles.textStyle18),
                CustomIconButton(
                  onTap: _open,
                  icon: FontAwesomeIcons.magnifyingGlass,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
