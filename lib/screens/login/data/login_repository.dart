import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_graphql_app/utils/http_link.dart';

class LoginRepository {
  Future<void> login(String? email, String? password) async {
    try {
      QueryResult result = await qlClient.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.networkOnly,
          document: gql('''
     mutation LoginUser(\$email: String!, \$password: String!) {
  loginUser(email: \$email, password: \$password) {
    token
  }
}
'''),
          variables: {"email": email, "password": password},
        ),
      );
      print('result: $result');
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        print('success from repo');
      }
    } catch (error) {
      print('failed from repo');

      throw Exception('something went wrong!!');
    }
  }
}

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});
