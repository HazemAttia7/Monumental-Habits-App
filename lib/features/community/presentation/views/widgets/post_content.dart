import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostContent extends StatefulWidget {
  final String content;
  final int maxLines;

  const PostContent({super.key, required this.content, this.maxLines = 3});

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  bool isExpanded = false;

  final GlobalKey _postKey = GlobalKey();

  void _toggle() {
    if (isExpanded) {
      final context = _postKey.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero);

        final scrollable = Scrollable.of(context);
        final controller = scrollable.position;

        controller.jumpTo(controller.pixels + position.dy);
      }
    }

    setState(() => isExpanded = !isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      height: 1.35,
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
    );

    return LayoutBuilder(
      builder: (context, size) {
        final span = TextSpan(text: widget.content, style: textStyle);

        final tp = TextPainter(
          text: span,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        );

        tp.layout(maxWidth: size.maxWidth);

        final isOverflowing = tp.didExceedMaxLines;

        return Container(
          key: _postKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.content,
                maxLines: isExpanded ? null : widget.maxLines,
                overflow: TextOverflow.fade,
                style: textStyle,
              ),
              if (isOverflowing)
                GestureDetector(
                  onTap: _toggle,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      isExpanded ? 'See less' : 'See more',
                      style: textStyle.copyWith(
                        fontSize: 12.sp,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
