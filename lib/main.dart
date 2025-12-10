import 'package:flutter/material.dart';
import 'package:information_retrieval/core/cache/shared_pref/shared_pref.dart';
import 'package:information_retrieval/core/routes/app_routes.dart';
import 'package:information_retrieval/core/routes/route_generator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  final bool completedOnboarding = SharedPref.getOnboardingCompleted();
  late final String initialRoute;
  if (completedOnboarding) {
    initialRoute = AppRoutes.search;
  } else{
    initialRoute = AppRoutes.onboarding;
  }
  runApp(SearchApp(initialRoute: initialRoute));
}

class SearchApp extends StatelessWidget {
  final String initialRoute;
  const SearchApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 841),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, _) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1300),
          switchInCurve: Curves.easeInCirc,
          switchOutCurve: Curves.easeInOutCirc,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: child,
          ),
          child: MaterialApp(

            debugShowCheckedModeBanner: false,
            // theme: ThemeManager.lightTheme,
            // darkTheme: ThemeManager.darkTheme,
            themeAnimationCurve: Curves.easeInCirc,
            themeAnimationDuration: const Duration(milliseconds: 1000),
            initialRoute: initialRoute,
            onGenerateRoute: RoutesManager.router,
          ),
        );
      },
    );
  }
}
