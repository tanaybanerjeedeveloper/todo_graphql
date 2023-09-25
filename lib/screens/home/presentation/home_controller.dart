import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/screens/home/data/home_repository.dart';

class HomeController extends StateNotifier<AsyncValue> {
  HomeController({required this.homeRepository})
      : super(const AsyncValue<void>.data(null));

  final HomeRepository homeRepository;

  Future<bool> createTodo(String title, String description) async {
    try {
      state = const AsyncValue.loading();
      await homeRepository.createTodo(title, description);
      state = const AsyncValue.data(null);
      print('success from controller');
      return true;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      print('failure from controller');
      return false;
    }
  }

  Future<bool> deleteTodo(String id) async {
    try {
      state = const AsyncValue.loading();
      await homeRepository.deleteTodo(id);
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

final homeControllerProvider =
    StateNotifierProvider<HomeController, AsyncValue>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);

  return HomeController(homeRepository: homeRepository);
});
