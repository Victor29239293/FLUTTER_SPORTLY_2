import 'package:flutter_sportly_2/presentation/screens/initial_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/initial', routes: [
  GoRoute(
    path: '/initial',
    name: InitialScreen.routeName,
    builder: (context, state) => const InitialScreen(),
  ),
]);
