import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/post_model.dart';
import 'package:pixel_true_app/features/community/data/services/post_repo.dart';

part 'community_state.dart';

class CommunityCubit extends Cubit<CommunityState> {
  PostRepo postRepo;
  CommunityCubit(this.postRepo) : super(CommunityInitial());

  Future<void> getPosts() async {
    emit(CommunityLoading());
    final result = await postRepo.getPosts();
    result.fold(
      (failure) => emit(CommunityError(failure.errMessage)),
      (posts) => emit(CommunityLoaded(posts)),
    );
  }
}
