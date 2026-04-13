import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pixel_true_app/features/community/presentation/managers/community_cubit/community_cubit.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/community_loaded_view.dart';
import 'package:pixel_true_app/features/community/presentation/views/widgets/community_loading_view.dart';

class CommunityViewBody extends StatelessWidget {
  const CommunityViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityCubit, CommunityState>(
      builder: (context, state) {
        if (state is CommunityLoading) {
          return const CommunityLoadingView();
        }

        if (state is CommunityError) {
          return Center(child: Text(state.errMessage));
        }

        if (state is CommunitySuccess) {
          final posts = state.posts;
          return CommunityLoadedView(posts: posts);
        }

        return const SizedBox.shrink();
      },
    );
  }
}
