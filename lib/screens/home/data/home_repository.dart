import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_graphql_app/screens/home/domain/todo_model.dart';
import 'package:todo_graphql_app/utils/http_link.dart';

class HomeRepository {
  Util util = Util();
  Future<List> fetchToDos() async {
    try {
      QueryResult result = await util.getGQLAuthClient().query(
          QueryOptions(fetchPolicy: FetchPolicy.networkOnly, document: gql('''
query GetTodosByUser {
  getTodosByUser {
    id
    description
    title
  }
}

''')));

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List res = result.data?["getTodosByUser"];

      if (res == null || res.isEmpty) {
        return [];
      } else {
        List<Todo> todos = res
            .map<Todo>((item) => Todo(
                description: item["description"],
                id: item["id"],
                title: item["title"]))
            .toList();
        return todos;
      }
    } catch (error) {
      print('error from repo');
      throw Exception('Something went wrong');
    }
  }
}

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

final fetchToDosProvider = FutureProvider<List>((ref) async {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return homeRepository.fetchToDos();
});
