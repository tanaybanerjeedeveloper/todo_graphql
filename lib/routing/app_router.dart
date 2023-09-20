import 'package:go_router/go_router.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_screen.dart';
import 'package:todo_graphql_app/screens/login/presentation/login_screen.dart';
import 'package:todo_graphql_app/screens/registration/presentation/register_screen.dart';

enum AppRoute {
  login,
  register,
  home,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.login.name,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      name: AppRoute.home.name,
      builder: (context, state) => MyHomePage(),
    ),
    GoRoute(
      path: '/register',
      name: AppRoute.register.name,
      builder: (context, state) => RegisterScreen(),
    ),
  ],
);
