import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_bloc/controllers/auth_bloc/auth_bloc.dart';
import 'package:flutter_ecommerce_bloc/core/utils/enums.dart';

import '../../core/utils/assets.dart';
import '../widgets/main_button.dart';
import '../widgets/social_media_button.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  String? email;
  String? password;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authBloc = BlocProvider.of<AuthBloc>(context);
    var authType = authBloc.state.toggleFormTypeStateUser;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 60.0,
            horizontal: 32.0,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authType == AuthFormType.login ? 'Login' : 'Register',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 80.0),
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    onChanged: (data) => email = data,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your email' : null,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email!',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    obscureText: true,
                    onChanged: (data) => password = data,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter your password' : null,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password!',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {},
                      child: Text(authType == AuthFormType.login
                          ? 'Forgot your password?'
                          : ''),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: MainButton(
                      text:
                          authType == AuthFormType.login ? 'Login' : 'Register',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _submit(authType, authBloc);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _emailController.clear();
                          _passwordController.clear();
                          BlocProvider.of<AuthBloc>(context)
                              .add(ToggleFormTypeEvent());
                        });
                      },
                      child: Text(authType == AuthFormType.login
                          ? "Don\'t have an account? Register'"
                          : "Have an account? Login"),
                    ),
                  ),
                  SizedBox(height: size.height * 0.09),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        authType == AuthFormType.login
                            ? 'Or Login with'
                            : 'Or Register with',
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        iconName: AppAssets.facebookIcon,
                        onPress: () {},
                      ),
                      const SizedBox(width: 16.0),
                      SocialMediaButton(
                        iconName: AppAssets.googleIcon,
                        onPress: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit(AuthFormType authType, AuthBloc myBloc) {
    if (authType == AuthFormType.login) {
      myBloc.add(LoginEvent(email: email!, password: password!));
      if (!mounted) return;
    } else {
      myBloc.add(RegisterEvent(email: email!, password: password!));
      if (!mounted) return;
    }
  }
}
