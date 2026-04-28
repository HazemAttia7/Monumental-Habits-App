import 'package:flutter/material.dart';
import 'package:pixel_true_app/core/enums/community_enums.dart';

class PostDetailsViewController extends ChangeNotifier {
  enCommentsFilterBy _commentsFilterBy = enCommentsFilterBy.newest;
  enCommentsFilterBy get commentsFilterBy => _commentsFilterBy;

  void onSortCommentsTap() {
    _commentsFilterBy = _commentsFilterBy.next();
    notifyListeners();
  }
}
