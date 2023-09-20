import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/screens/login/data/login_repository.dart';

class LoginController extends StateNotifier<AsyncValue> {
  LoginController({required this.loginRepository})
      : super(const AsyncValue<void>.data(null));

  final LoginRepository loginRepository;

  Future<bool> login(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      await loginRepository.login(email, password);
      state = const AsyncValue.data(null);
      print('success from controller');
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      print('failure from controller');
      return false;
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue>((ref) {
  final loginRepository = ref.watch(loginRepositoryProvider);
  return LoginController(loginRepository: loginRepository);
});
