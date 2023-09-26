import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_graphql_app/local_storage.dart';
import 'package:todo_graphql_app/utils/local_storage.dart';

class Util {
  var a = localStorageNew.getString('token');
  // static HttpLink link = HttpLink("http://localhost:8000/graphql");
  static HttpLink link = HttpLink("http://192.168.29.150/graphql");

  late Link authLink;

  // Link setAuthLink() {
  //   authLink = HttpLink("http://localhost:8000/graphql",
  //       defaultHeaders: {'Authorization': 'Bearer $a'});
  //   return authLink;
  // }

  Link setAuthLink() {
    authLink = HttpLink("http://192.168.29.150/graphql",
        defaultHeaders: {'Authorization': 'Bearer $a'});
    return authLink;
  }

  //  authLink = HttpLink("http://localhost:8000/graphql",
  //     defaultHeaders: {'Authorization': 'Bearer $a'});

  static GraphQLClient qlClient = GraphQLClient(
    // craete a graphql client
    link: link,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  );

  getGQLClent() {
    GraphQLClient qlClient = GraphQLClient(
      // craete a graphql client
      link: link,
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );
    return qlClient;
  }

  getGQLAuthClient() {
    GraphQLClient qlClientAuth = GraphQLClient(
      // craete a graphql client
      link: setAuthLink(),
      cache: GraphQLCache(
        store: HiveStore(),
      ),
    );

    return qlClientAuth;
  }
}

// HttpLink link = HttpLink("http://localhost:8000/graphql");

// HttpLink authLink = HttpLink("http://localhost:8000/graphql", defaultHeaders: {
//   'Authorization':
//       'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1MGFhMzdmMmI1YTBmYjkwOWYwNGZhOSIsIm5hbWUiOiJsb2xvIiwiZW1haWwiOiJsb2xvQGdtYWlsLmNvbSIsImlhdCI6MTY5NTIxMzI0NX0.DhqZlcTmXN_GM9DVvWIVqIpQcDy8unvel7Y5LsbEN6Q'
// });

// GraphQLClient qlClient = GraphQLClient(
//   // craete a graphql client
//   link: link,
//   cache: GraphQLCache(
//     store: HiveStore(),
//   ),
// );
