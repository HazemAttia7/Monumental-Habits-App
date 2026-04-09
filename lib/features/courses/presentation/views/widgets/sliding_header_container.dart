import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:pixel_true_app/core/widgets/custom_icon_button.dart';
import 'package:pixel_true_app/core/widgets/custom_text_form_field.dart';
import 'package:pixel_true_app/features/courses/presentation/views/widgets/header_container.dart';

class SlidingHeaderContainer extends StatefulWidget {
  final void Function(String) onSearchChanged;
  final void Function(bool isSearchOpen) onTap;
  const SlidingHeaderContainer({
    super.key,
    required this.onSearchChanged,
    required this.onTap,
  });

  @override
  State<SlidingHeaderContainer> createState() => _SlidingHeaderContainerState();
}

class _SlidingHeaderContainerState extends State<SlidingHeaderContainer>
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
    widget.onTap(true);
    _ctrl.forward();
    Future.delayed(const Duration(milliseconds: 200), _focus.requestFocus);
  }

  void _close() {
    widget.onTap(false);
    searchController.clear();
    widget.onSearchChanged('');
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
                    onChanged: widget.onSearchChanged,
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
            child: HeaderContainer(onSearchTap: _open),
          ),
        ],
      ),
    );
  }
}
