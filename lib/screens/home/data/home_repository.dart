import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_graphql_app/screens/home/domain/todo_model.dart';
import 'package:todo_graphql_app/utils/http_link.dart';

class HomeRepository {
  List<Todo> todos = [];
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
        todos = res
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

  Stream<List> watchToDos() async* {
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
        yield [];
      } else {
        todos = res
            .map<Todo>((item) => Todo(
                description: item["description"],
                id: item["id"],
                title: item["title"]))
            .toList();
        yield todos;
      }
    } catch (error) {
      print('error from repo');
      throw Exception('Something went wrong');
    }
  }

  Future<void> createTodo(String? title, String? description) async {
    try {
      QueryResult result = await util.getGQLAuthClient().mutate(MutationOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql('''
    mutation Mutation(\$title: String!, \$description: String!) {
  createTodo(title: \$title, description: \$description) {
    title
  }
}
'''),
            variables: {"title": title, "description": description},
          ));
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        // var data = result.data?["createTodo"];
        // Todo todoData.title = data
        print('success from repo');
      }
    } catch (error) {
      print('failed from repo');

      throw Exception('something went wrong!!');
    }
  }

  Future<void> deleteTodo(String? todoId) async {
    try {
      QueryResult result = await util.getGQLAuthClient().mutate(MutationOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql('''
mutation Mutation(\$todoId: ID!) {
  deleteTodo(todoId: \$todoId)
}
'''),
            variables: {"todoId": todoId},
          ));
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        // var data = result.data?["createTodo"];
        // Todo todoData.title = data
        print('success from repo');
      }
    } catch (error) {
      print('failed from repo');

      throw Exception('something went wrong!!');
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

final watchTodosProvider = StreamProvider<List>((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return homeRepository.watchToDos();
});



// final createTodoProvider = FutureProvider<void>((ref) async {
//    final homeRepository = ref.watch(homeRepositoryProvider);
//   return homeRepository.createTodo(title, description);
// });
