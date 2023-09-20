import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:todo_graphql_app/utils/local_storage.dart';

Localstorage localstorage = Localstorage();

var token = localstorage.setToken();

HttpLink link = HttpLink("http://localhost:8000/graphql");

HttpLink authLink = HttpLink("http://localhost:8000/graphql", defaultHeaders: {
  'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1MGFhMzdmMmI1YTBmYjkwOWYwNGZhOSIsIm5hbWUiOiJsb2xvIiwiZW1haWwiOiJsb2xvQGdtYWlsLmNvbSIsImlhdCI6MTY5NTIxMzI0NX0.DhqZlcTmXN_GM9DVvWIVqIpQcDy8unvel7Y5LsbEN6Q'
});

GraphQLClient qlClient = GraphQLClient(
  // craete a graphql client
  link: link,
  cache: GraphQLCache(
    store: HiveStore(),
  ),
);
