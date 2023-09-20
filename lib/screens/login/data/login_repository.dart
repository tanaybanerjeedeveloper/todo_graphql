import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_graphql_app/utils/http_link.dart';

class LoginRepository {
  Future<void> login(String? email, String? password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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
        String token = result.data?["loginUser"]["token"];
        print('token: $token');
        sharedPreferences.setString('token', token);

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
