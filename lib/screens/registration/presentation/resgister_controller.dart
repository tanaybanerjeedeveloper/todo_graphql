import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/screens/registration/data/register_repository.dart';

class RegisterController extends StateNotifier<AsyncValue> {
  RegisterController({required this.registerRepository})
      : super(const AsyncValue<void>.data(null));

  final RegisterRepository registerRepository;

  Future<bool> register(String name, String email, String dob, String gender,
      String password) async {
    try {
      state = const AsyncValue.loading();
      await registerRepository.register(name, email, dob, gender, password);
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

final registerControllerProvider =
    StateNotifierProvider<RegisterController, AsyncValue>((ref) {
  final registerRepository = ref.watch(registerRepositoryProvider);
  return RegisterController(registerRepository: registerRepository);
});
