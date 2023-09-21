// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// //import 'package:todo_graphql_app/graphql_config.dart';

// final graphQLService = GraphQLService._();

// class GraphQLService {
//   GraphQLService._();

  

//   static HttpLink link = HttpLink("http://localhost:8000/graphql");

//   GraphQLClient qlClient = GraphQLClient(
//     // craete a graphql client
//     link: link,
//     cache: GraphQLCache(
//       store: HiveStore(),
//     ),
//   );

//   late SharedPreferences sp;

//   Future<void> init() async {
//     sp = await SharedPreferences.getInstance();
//   }

//   //functin to Login-----------------------------------
//   Future<void> login(String? email, String? password) async {
//     try {
//       QueryResult result = await qlClient.mutate(
//         MutationOptions(
//           fetchPolicy: FetchPolicy.networkOnly,
//           document: gql('''
//      mutation LoginUser(\$email: String!, \$password: String!) {
//       loginUser(email: \$email, password: \$password) {
//     token
//       }
//     }
//     '''),
//           variables: {"email": email, "password": password},
//         ),
//       );
//       print('result: $result');
//       if (result.hasException) {
//         throw Exception(result.exception);
//       } else {
//         String token = result.data?["loginUser"]["token"];
//         print('token: $token');
//         sp.setString('token', token);

//         print('success from repo');
//       }
//     } catch (error) {
//       print('failed from repo');

//       throw Exception('something went wrong!!');
//     }
//   }

// //Register function-------------------------------------------
//   Future<void> register(String? name, String? email, String? dob,
//       String? gender, String? password) async {
//     print(name);
//     print(email);
//     print(dob);
//     print(gender);
//     print(password);
//     //HttpLink link = HttpLink("http://localhost:8000/graphql");
//     GraphQLClient qlClient = GraphQLClient(
//       // craete a graphql client
//       link: link,
//       cache: GraphQLCache(
//         store: HiveStore(),
//       ),
//     );

//     try {
//       QueryResult result = await qlClient.mutate(
//         MutationOptions(
//           fetchPolicy: FetchPolicy.networkOnly,
//           document: gql(
//               ''' mutation Mutation(\$name: String!, \$email: String!, \$dob: Date!, \$gender: String!, \$password: String!){
//         registerUser(name: \$name, email: \$email, dob: \$dob, gender: \$gender, password: \$password) {
//         token
//         user {
//         avatar
//         age
//         name
//         }}
//         }'''
//               // as tou graphql need query string
//               ),
//           variables: {
//             "name": name,
//             "email": email,
//             "dob": dob,
//             "gender": gender,
//             "password": password
//           },
//         ),
//       );
//       print('result: $result');
//       if (result.hasException) {
//         throw Exception(result.exception);
//       } else {
//         print('success from repo');
//       }
//     } catch (error) {
//       //throw Exception('something went wrong!!');
//       print('failed from repo');

//       throw Exception('something went wrong!!');
//     }
//   }

//   HttpLink authLink = HttpLink("http://localhost:8000/graphql",
//       defaultHeaders: {'Authorization': 'Bearer ${sp.getString('token')}'});
// }

// final graphQLServiceProvider = Provider<GraphQLService>((ref) {
//   return graphQLService;
// });
