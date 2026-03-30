import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pixel_true_app/core/enums/profile_enums.dart';
import 'package:pixel_true_app/core/helper/build_not_implemented_yet_dialog.dart';
import 'package:pixel_true_app/core/managers/cubits/habits_cubit/habits_cubit.dart';
import 'package:pixel_true_app/core/utils/app_router.dart';
import 'package:pixel_true_app/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:pixel_true_app/features/home/data/models/habit_model.dart';
import 'package:provider/provider.dart';

class ProfileController extends ChangeNotifier {
  String _query = '';
  String get query => _query;

  bool _isDialogLoading = false;
  bool get isDialogLoading => _isDialogLoading;

  bool _isPasswordVerifying = false;
  bool get isPasswordVerifying => _isPasswordVerifying;

  String? _passwordError;
  String? get passwordError => _passwordError;

  enProfileFilterBy _filterBy = enProfileFilterBy.week;
  enProfileFilterBy get filterBy => _filterBy;

  void setQuery(String query) {
    _query = query;
    notifyListeners();
  }

  void onHabitMenuTapped(BuildContext context, Habit habit) {
    GoRouter.of(context).push(
      AppRouter.kHabitAnalysis,
      extra: {"habit": habit, "cubit": context.read<HabitsCubit>()},
    );
  }

  Future<bool> changeUsername(
    username,
    BuildContext context,
    AuthCubit cubit,
  ) async {
    final success = await cubit.changeUsername(newUsername: username.trim());
    if (context.mounted) {
      Navigator.pop(context);
    }
    return success;
  }

  Future<void> handleCredentialConfirm({
    required BuildContext context,
    required String value,
    required Future<bool> Function(String) onConfirm,
    Function(String)? afterPop,
  }) async {
    if (_isDialogLoading) return;

    _isDialogLoading = true;
    notifyListeners();

    final success = await onConfirm(value);

    _isDialogLoading = false;
    notifyListeners();

    if (success && context.mounted) {
      Navigator.of(context).pop();
      afterPop?.call(value);
    }
  }

  Future<void> verifyPassword({
    required BuildContext context,
    required String password,
    required AuthCubit cubit,
    required VoidCallback onSuccess,
  }) async {
    if (_isPasswordVerifying) return;

    _isPasswordVerifying = true;
    _passwordError = null;
    notifyListeners();

    final isCorrect = await cubit.verifyPassword(password: password);

    _isPasswordVerifying = false;
    notifyListeners();

    if (!context.mounted) return;

    if (isCorrect) {
      onSuccess();
    } else {
      _passwordError = "Incorrect password, please try again.";
      notifyListeners();
    }
  }

  void clearPasswordError() {
    _passwordError = null;
    notifyListeners();
  }

  void setFilterBy(enProfileFilterBy filterBy) {
    if (filterBy == _filterBy) return;
    _filterBy = filterBy;
    notifyListeners();
  }

  void onBillingMethodsTap(BuildContext context) {
    buildNotImplementedYetDialog(context, featureName: "Biiling Methods");
  }

  void onHabitsAnalyticsTap(BuildContext context) {
    context.push(
      AppRouter.kProfileHabitsAnalytics,
      extra: context.read<HabitsCubit>(),
    );
  }
}
