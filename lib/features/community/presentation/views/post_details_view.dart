import 'package:flutter/material.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/post_details/post_details_view_body.dart';

class PostDetailsView extends StatelessWidget {
  final bool scrollToComments;
  const PostDetailsView({super.key, this.scrollToComments = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PostDetailsViewBody(scrollToComments: scrollToComments),
    );
  }
}
