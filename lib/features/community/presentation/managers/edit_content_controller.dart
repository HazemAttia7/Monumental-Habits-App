import 'package:flutter/cupertino.dart';

class EditContentController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController textController;
  bool isLoading = false;
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  EditContentController(String initialText) {
    textController = TextEditingController(text: initialText);
  }

  bool validate() {
    if (formKey.currentState?.validate() ?? false) {
      return true;
    }
    autovalidateMode = AutovalidateMode.always;
    notifyListeners();
    return false;
  }

  Future<void> submit(Future Function(String text) onConfirm) async {
    if (!validate()) return;
    isLoading = true;
    notifyListeners();
    await onConfirm(textController.text.trim());
    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
