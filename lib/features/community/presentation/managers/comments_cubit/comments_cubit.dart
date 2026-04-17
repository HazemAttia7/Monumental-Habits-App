import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/community/data/models/comment_model.dart';
import 'package:pixel_true_app/features/community/data/services/comments_repo.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  final CommentsRepo commentRepo;
  CommentsCubit(this.commentRepo) : super(CommentsInitial());

  Future<void> getComments(String postId) async {
    emit(CommentsLoading());
    final result = await commentRepo.getComments(postId);
    result.fold(
      (failure) => emit(CommentsError(failure.errMessage)),
      (comments) => emit(CommentsSuccess(comments)),
    );
  }
}
