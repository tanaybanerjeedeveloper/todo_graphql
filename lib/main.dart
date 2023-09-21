import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_graphql_app/graphql_service.dart';
import 'package:todo_graphql_app/local_storage.dart';
import 'package:todo_graphql_app/routing/app_router.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_screen.dart';
import 'package:todo_graphql_app/screens/login/presentation/login_screen.dart';
import 'package:todo_graphql_app/screens/registration/presentation/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  // await graphQLService.init();
  await localStorageNew.init();
  runApp(
    const ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    //checkIfloggedin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        //useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: LoginScreen(),
      //home: redirectWidget,
    );
  }

  // void checkIfloggedin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  //   var token = sharedPreferences.getString('token');
  //   print(token);
  //   if (token != null) {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => MyHomePage()),
  //     );
  //   }
  // }
}
