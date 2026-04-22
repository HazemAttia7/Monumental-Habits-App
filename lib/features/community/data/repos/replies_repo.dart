import 'package:dartz/dartz.dart';
import 'package:pixel_true_app/core/errors/failure.dart';
import 'package:pixel_true_app/features/community/data/models/reply_model.dart';

abstract class RepliesRepo {
  Stream<Either<Failure, List<Reply>>> watchReplies(
    String postId,
    String commentId,
  );
  Future<Either<Failure, Unit>> addReply(Reply reply);
  String generateReplyId(String postId, String commentId);
}
