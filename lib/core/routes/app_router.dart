import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:smart_spent_story/core/routes/route_names.dart';

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({required this.authBloc});

  late final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    redirect: _redirect,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const _SplashPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) =>
            const _PlaceholderPage(title: 'Onboarding'),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const _PlaceholderPage(title: 'Login'),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const _PlaceholderPage(title: 'Register'),
      ),
      ShellRoute(
        builder: (context, state, child) => _MainShell(
          state: state,
          child: child,
        ),
        routes: [
          GoRoute(
            path: RouteNames.dashboard,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Dashboard'),
          ),
          GoRoute(
            path: RouteNames.analytics,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Analytics'),
          ),
          GoRoute(
            path: RouteNames.addTransaction,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Add Transaction'),
          ),
          GoRoute(
            path: RouteNames.transactionList,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Transactions'),
          ),
          GoRoute(
            path: RouteNames.profile,
            builder: (context, state) =>
                const _PlaceholderPage(title: 'Profile'),
          ),
        ],
      ),
    ],
  );

  String? _redirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = authBloc.state is AuthAuthenticated;
    final location = state.matchedLocation;

    const publicRoutes = [
      RouteNames.splash,
      RouteNames.onboarding,
      RouteNames.login,
      RouteNames.register,
    ];

    final isOnPublicRoute = publicRoutes.contains(location);

    if (!isAuthenticated && !isOnPublicRoute) {
      return RouteNames.login;
    }

    if (isAuthenticated &&
        (location == RouteNames.login || location == RouteNames.register)) {
      return RouteNames.dashboard;
    }

    return null;
  }
}

class _SplashPage extends StatelessWidget {
  const _SplashPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Smart Spent Story',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _PlaceholderPage extends StatelessWidget {
  final String title;

  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class _MainShell extends StatelessWidget {
  final GoRouterState state;
  final Widget child;

  const _MainShell({required this.state, required this.child});

  int _selectedIndex(String location) {
    if (location.startsWith(RouteNames.dashboard)) return 0;
    if (location.startsWith(RouteNames.analytics)) return 1;
    if (location.startsWith(RouteNames.addTransaction)) return 2;
    if (location.startsWith(RouteNames.transactionList)) return 3;
    if (location.startsWith(RouteNames.profile)) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _selectedIndex(state.matchedLocation);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => _onTap(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            activeIcon: Icon(Icons.analytics),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            activeIcon: Icon(Icons.add_circle),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            activeIcon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.dashboard);
      case 1:
        context.go(RouteNames.analytics);
      case 2:
        context.go(RouteNames.addTransaction);
      case 3:
        context.go(RouteNames.transactionList);
      case 4:
        context.go(RouteNames.profile);
    }
  }
}
