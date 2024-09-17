import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pets_app/cubit/auth_cubit.dart';
import 'package:flutter_pets_app/cubit/user_cubit.dart';
import 'package:flutter_pets_app/models/user_details_model.dart';
import 'package:flutter_pets_app/widgets/custom_button.dart';
import 'package:flutter_pets_app/widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  FirebaseAuth user = FirebaseAuth.instance;

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
              content: Text("Registration Failed"),
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
                      image: AssetImage("assets/images/signup.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Create a new Account",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Please fill the required details to continue",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextField(
              controller: _nameController,
              hintText: 'Full name',
              icon: Icons.person,
            ),
            CustomTextField(
              controller: _emailController,
              hintText: 'Email address',
              icon: Icons.email,
              keyBoardType: TextInputType.emailAddress,
            ),
            CustomTextField(
              controller: _phoneController,
              hintText: 'Phone number',
              icon: Icons.phone,
              keyBoardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
            CustomTextField(
              maxLines: 1,
              obscureText: true,
              controller: _passwordController,
              hintText: 'Password',
              icon: Icons.lock,
              suffixIcon: Icons.remove_red_eye,
            ),
            CustomTextField(
              maxLines: 1,
              obscureText: true,
              controller: _confirmPasswordController,
              hintText: 'Confirm password',
              icon: Icons.lock,
              suffixIcon: Icons.remove_red_eye,
            ),
            CustomButton(
              text: 'Create Account',
              onTap: () async {
                final UserDetails userDetails = UserDetails(
                    name: _nameController.text,
                    email: _emailController.text,
                    phone: _phoneController.text,
                    userId: user.currentUser?.uid.toString() ?? '');
                if (_passwordController.text ==
                    _confirmPasswordController.text) {
                  await context.read<AuthCubit>().register(
                      _emailController.text, _passwordController.text);
                  context.read<UserCubit>().storeUserDetails(
                      user.currentUser!.uid.toString(), userDetails);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password does not match')),
                  );
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account?",
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade800),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signIn');
                      },
                      child: const Text(
                        "Login",
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
