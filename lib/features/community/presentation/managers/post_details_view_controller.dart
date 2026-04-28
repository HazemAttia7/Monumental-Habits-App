import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/community_enums.dart';

class PostDetailsViewController extends ChangeNotifier {
  enCommentsFilterBy _commentsFilterBy = enCommentsFilterBy.newest;
  enCommentsFilterBy get commentsFilterBy => _commentsFilterBy;
  bool _isEditCommentMode = false;
  bool get isEditCommentMode => _isEditCommentMode;
  bool _isEditReplyMode = false;
  bool get isEditReplyMode => _isEditReplyMode;
  String? commentIdToEdit, replyIdToEdit;

  void onSortCommentsTap() {
    _commentsFilterBy = _commentsFilterBy.next();
    notifyListeners();
  }

  void onEditCommentTap(String commentId) {
    onDoneEditReply();
    commentIdToEdit = commentId;
    _isEditCommentMode = true;
    notifyListeners();
  }

  void onDoneEditComment() {
    commentIdToEdit = null;
    _isEditCommentMode = false;
    notifyListeners();
  }

  void onEditReplyTap(String replyId) {
    onDoneEditComment();
    replyIdToEdit = replyId;
    _isEditReplyMode = true;
    notifyListeners();
  }

  void onDoneEditReply() {
    replyIdToEdit = null;
    _isEditReplyMode = false;
    notifyListeners();
  }
}
