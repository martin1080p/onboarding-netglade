import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding/bloc/app/app_bloc.dart';
import 'package:onboarding/bloc/app/app_state.dart';
import 'package:onboarding/models/user_model.dart';
import 'package:onboarding/repositories/auth_repository.dart';
import 'package:onboarding/screens/widgets/error_page.dart';
import 'package:onboarding/screens/widgets/favorite_page.dart';
import 'package:onboarding/screens/widgets/profile_page.dart';
import 'package:onboarding/screens/widgets/telemetry_page.dart';
import 'package:onboarding/screens/widgets/user_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserModel user = AuthRepository.i.user;
    bool isAdmin = user.isAdmin;

    List<Widget> tabs = [
      const Tab(icon: Icon(Icons.home_outlined), text: 'Home'),
      const Tab(icon: Icon(Icons.map_outlined), text: 'Graphs'),
      const Tab(icon: Icon(Icons.favorite_outline), text: 'Favorites'),
      const Tab(icon: Icon(Icons.error_outline), text: 'Errors'),
      const Tab(icon: Icon(Icons.person_outline), text: 'Profile'),
    ];

    List<Widget> tabViews = [
      TelemetryPage(),
      const Icon(Icons.map_outlined),
      FavoritePage(),
      ErrorPage(),
      ProfilePage(),
    ];

    if (isAdmin) {
      tabs.add(const Tab(icon: Icon(Icons.settings_outlined), text: 'Admin Dashboard'));
      tabViews.add(UserPage());
    }

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (!state.isLoggedIn) {
          Navigator.of(context).pushReplacementNamed('/');
          if (state.hasSessionExpired) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Session has expired. Please login again.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: DefaultTabController(
        length: isAdmin ? 6 : 5,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Satellite App'),
              bottom: TabBar(
                isScrollable: true,
                tabs: tabs,
              ),
            ),
            body: TabBarView(
              children: tabViews,
            )),
      ),
    );
  }
}
