import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_graphql_app/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RegisterRepository {
  // static GraphQLConfig graphQLConfig = GraphQLConfig();
  // GraphQLClient client = graphQLConfig.clientToQuery();

  Future<void> register(String? name, String? email, String? dob,
      String? gender, String? password) async {
    print(name);
    print(email);
    print(dob);
    print(gender);
    print(password);
    HttpLink link = HttpLink("http://localhost:8000/graphql");
    GraphQLClient qlClient = GraphQLClient(
      // craete a graphql client
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    try {
      QueryResult result = await qlClient.mutate(
        MutationOptions(
            fetchPolicy: FetchPolicy.networkOnly,
            document: gql(
                ''' mutation Mutation(\$name: String!, \$email: String!, \$dob: Date!, \$gender: String!, \$password: String!){
        registerUser(name: \$name, email: \$email, dob: \$dob, gender: \$gender, password: \$password) {
        token
        user {
        avatar
        age
        name
        }}
        }'''
                // as tou graphql need query string
                ),
            variables: {
              "name": name,
              "email": email,
              "dob": dob,
              "gender": gender,
              "password": password
            }),
      );
      print('result: $result');
      if (result.hasException) {
        throw Exception(result.exception);
      } else {
        print('success from repo');
      }
    } catch (error) {
      //throw Exception('something went wrong!!');
      print('failed from repo');

      throw Exception('something went wrong!!');
    }
  }
}

final registerRepositoryProvider = Provider<RegisterRepository>((ref) {
  return RegisterRepository();
});
