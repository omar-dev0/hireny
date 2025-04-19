import 'package:go_router/go_router.dart';
import '../technical_info/presentation/technical_view.dart';

abstract class AppRouter {
  static const KHome = '/';

  static final router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const technicalInfoView(),
    ),
  ]);
}