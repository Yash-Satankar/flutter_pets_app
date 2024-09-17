import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pets_app/cubit/bottom_nav_cubit.dart';
import 'package:flutter_pets_app/screens/home%20screen%20tabs/home_screen.dart';
import 'package:flutter_pets_app/screens/home%20screen%20tabs/profile_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          switch (state) {
            case 1:
              return const Center(child: Text('Page 2'));
            case 2:
              return const ProfileScreen();
            default:
              return const HomeScreen();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, int>(
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state,
            onTap: (index) {
              context.read<BottomNavCubit>().updateIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.near_me_outlined),
                label: 'Nearby Pets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
