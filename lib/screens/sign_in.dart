import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pets_app/cubit/auth_cubit.dart';
import 'package:flutter_pets_app/widgets/custom_button.dart';
import 'package:flutter_pets_app/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', ModalRoute.withName('/'));
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Login Failed"),
            ));
          }
        },
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 32),
                height: 180,
                width: 180,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Please sign in to continue",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email address',
              icon: Icons.email,
            ),
            CustomTextField(
              maxLines: 1,
              obscureText: true,
              controller: _passwordController,
              hintText: 'Password',
              icon: Icons.lock,
              suffixIcon: Icons.remove_red_eye,
            ),
            CustomButton(
              text: 'Login',
              onTap: () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                await context.read<AuthCubit>().login(email, password);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
