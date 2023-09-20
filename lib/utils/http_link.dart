import 'package:graphql_flutter/graphql_flutter.dart';

HttpLink link = HttpLink("http://localhost:8000/graphql");

GraphQLClient qlClient = GraphQLClient(
  // craete a graphql client
  link: link,
  cache: GraphQLCache(
    store: HiveStore(),
  ),
);
