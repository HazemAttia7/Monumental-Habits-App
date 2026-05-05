import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/community_enums.dart';

class CommunityViewController extends ChangeNotifier {
  enCommentsFilterBy _commentsFilterBy = enCommentsFilterBy.newest;
  enCommentsFilterBy get commentsFilterBy => _commentsFilterBy;
  bool _isEditCommentMode = false;
  bool get isEditCommentMode => _isEditCommentMode;
  bool _isEditReplyMode = false;
  bool get isEditReplyMode => _isEditReplyMode;
  String? commentIdToEdit, replyIdToEdit;
  bool _isEditPostMode = false;
  bool get isEditPostMode => _isEditPostMode;
  String? postIdToEdit;

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

  void onEditPostTap(String postId) {
    postIdToEdit = postId;
    _isEditPostMode = true;
    notifyListeners();
  }

  void onDoneEditPost() {
    postIdToEdit = null;
    _isEditPostMode = false;
    notifyListeners();
  }
}
