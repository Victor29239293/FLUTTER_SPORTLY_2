import 'package:flutter_sportly_2/presentation/screens/home_screens.dart';
import 'package:flutter_sportly_2/presentation/screens/initial_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/initial',
  routes: [
    GoRoute(
      path: '/initial',
      name: InitialScreen.routeName,
      builder: (context, state) {
        return const InitialScreen();
      },
      routes: [
        GoRoute(
          path: 'home/:code/:page',
          name: HomeScreen.routeName,
          builder: (context, state) {
            final code = state.pathParameters['code'] ?? '';
            final pageIndex = int.parse(state.uri.queryParameters['page'] ?? '0');
            return HomeScreen(pageIndex: pageIndex, code: code);
          },
        ),
      ],
    ),
    //
    GoRoute(path: '/', redirect: (_, __) => '/initial'),
  ],
);
