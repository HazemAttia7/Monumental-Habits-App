import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_true_app/features/friends/data/repos/friends_repo.dart';
import 'package:pixel_true_app/models/user_profile_model.dart';

part 'user_search_state.dart';

class UserSearchCubit extends Cubit<UserSearchState> {
  final FriendsRepo _friendsRepo;
  UserSearchCubit(this._friendsRepo) : super(UserSearchInitial());

  Timer? _searchDebounce;
  List<UserProfile> searchResults = [];

  void searchUsers(String query) {
    _searchDebounce?.cancel();

    if (query.trim().isEmpty) {
      searchResults = [];
      emit(const UserSearchResults([]));
      return;
    }

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      emit(UserSearchLoading());
      final result = await _friendsRepo.searchUsersByUsername(query);
      result.fold((failure) => emit(UserSearchFailure(failure.errMessage)), (
        users,
      ) {
        searchResults = users;
        emit(UserSearchResults(users));
      });
    });
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
