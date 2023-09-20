import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_graphql_app/routing/app_router.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_screen.dart';
import 'package:todo_graphql_app/screens/login/presentation/login_controller.dart';
import 'package:todo_graphql_app/screens/registration/presentation/register_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(loginControllerProvider, (previousState, state) {
      if (!state.isLoading && state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });

    final state = ref.watch(loginControllerProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login To Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'Your Email'),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Your Password',
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final success = await ref
                          .read(loginControllerProvider.notifier)
                          .login(
                              _emailController.text, _passwordController.text);
                      print('success: $success');
                      if (success) {
                        context.pushNamed(AppRoute.home.name);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => MyHomePage()),
                        // );
                      }
                    },
                    child: (state.isLoading)
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Login'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.register.name);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RegisterScreen()),
                    // );
                  },
                  child: Text('Create New account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
