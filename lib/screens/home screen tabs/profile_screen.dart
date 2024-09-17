import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pets_app/cubit/auth_cubit.dart';
import 'package:flutter_pets_app/cubit/user_cubit.dart';
import 'package:flutter_pets_app/models/user_details_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  FirebaseAuth user = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.08),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              "Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: FutureBuilder<UserDetails?>(
            future: context
                .read<UserCubit>()
                .getUserDetails(user.currentUser!.uid.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                UserDetails user = snapshot.data!;
                return Column(
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 32),
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/person.jpg"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 64,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 16),
                      leading: const Icon(Icons.pets),
                      title: const Text("My Pets"),
                      onTap: () {
                        Navigator.pushNamed(context, '/myPets');
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/newPet');
                      },
                      child: const ListTile(
                        contentPadding: EdgeInsets.only(left: 16),
                        leading: Icon(Icons.add_circle),
                        title: Text("Add Pet"),
                      ),
                    ),
                    const ListTile(
                      contentPadding: EdgeInsets.only(left: 16),
                      leading: Icon(Icons.favorite),
                      title: Text("My Favourites"),
                    ),
                    const Divider(
                      height: 24,
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.only(left: 16),
                      leading: const Icon(Icons.logout),
                      title: const Text("Log Out"),
                      onTap: () {
                        context.read<AuthCubit>().logout();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signUp', ModalRoute.withName('/'));
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Logged out Successfully")));
                      },
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No user details found'));
              }
            }),
      ),
    );
  }
}
