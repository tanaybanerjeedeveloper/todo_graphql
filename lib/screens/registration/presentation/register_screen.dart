import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_graphql_app/screens/home/presentation/home_screen.dart';
import 'package:todo_graphql_app/screens/registration/presentation/resgister_controller.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(registerControllerProvider, (previousState, state) {
      if (!state.isLoading && state.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(state.error.toString()),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ));
      }
    });

    final state = ref.watch(registerControllerProvider);

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
                  'Create New Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Your Name'),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Your Email',
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _dobController,
                  decoration: InputDecoration(
                    labelText: 'Your Date of birth',
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(
                    labelText: 'male/female',
                  ),
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
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                    ),
                    onPressed: () async {
                      final success = await ref
                          .read(registerControllerProvider.notifier)
                          .register(
                              _nameController.text,
                              _emailController.text,
                              _dobController.text,
                              _genderController.text,
                              _passwordController.text);
                      print('success: $success');
                      if (success) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage(
                                    title: 'something',
                                  )),
                        );
                      }
                    },
                    child: (state.isLoading)
                        ? Padding(
                            padding: EdgeInsets.all(5),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
