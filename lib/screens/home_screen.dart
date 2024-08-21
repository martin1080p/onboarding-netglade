import 'package:flutter/material.dart';
import 'package:onboarding/models/user_model.dart';
import 'package:onboarding/repositories/auth_repository.dart';
import 'package:onboarding/screens/widgets/telemetry_page.dart';

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
      const Icon(Icons.favorite_outline),
      const Icon(Icons.error_outline),
      const Icon(Icons.person_outline),
    ];

    if (isAdmin) {
      tabs.add(const Tab(icon: Icon(Icons.settings_outlined), text: 'Admin Dashboard'));
      tabViews.add(const Icon(Icons.settings_outlined));
    }

    return DefaultTabController(
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
    );
  }
}
