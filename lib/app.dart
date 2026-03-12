import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/configs/app_config.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:smart_spent_story/core/routes/app_router.dart';

class SmartSpentApp extends StatelessWidget {
  const SmartSpentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider(
          create: (_) => sl<AuthBloc>(),
          child: Builder(
            builder: (context) {
              final authBloc = context.read<AuthBloc>();
              final appRouter = AppRouter(authBloc: authBloc);

              return MaterialApp.router(
                title: 'Smart Spent Story',
                theme: AppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                routerConfig: appRouter.router,
              );
            },
          ),
        );
      },
    );
  }
}
