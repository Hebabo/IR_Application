import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:information_retrieval/core/routes/app_routes.dart';
import 'package:information_retrieval/features/add%20document/cubit/add_document_cubit.dart';
import 'package:information_retrieval/features/add%20document/presentation/add_document_screen.dart';
import 'package:information_retrieval/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:information_retrieval/features/onboarding/presentation/onboarding_screen.dart';
import 'package:information_retrieval/features/search/cubit/search_cubit.dart';
import 'package:information_retrieval/features/search/presentation/search_screen.dart';

abstract class RoutesManager {
  static Route? router(RouteSettings settings) {
    switch (settings.name) {

      case AppRoutes.onboarding:
        {
          return CupertinoPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => OnboardingBloc(),
              child: OnboardingScreen(),
            ),
          );
        }

      case AppRoutes.search:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => SearchCubit(),
              child: SearchScreen(),
            ),

            // builder: (context) => SearchScreen(),

          );
        }

        case AppRoutes.addDocument:
        {
          return CupertinoPageRoute(
            builder: (context) => BlocProvider(
              create: (_) => AddDocumentCubit (),
              child: AddDocumentScreen (),
            ),

            // builder: (context) => SearchScreen(),

          );
        }
    }
    return null;
  }
}
