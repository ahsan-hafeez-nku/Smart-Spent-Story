import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/configs/app_config.dart';
import 'package:smart_spent_story/core/dependency_injection/service_locator.dart';
import 'package:smart_spent_story/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:smart_spent_story/core/routes/app_router.dart';

class SmartSpentApp extends StatefulWidget {
  const SmartSpentApp({super.key});

  @override
  State<SmartSpentApp> createState() => _SmartSpentAppState();
}

class _SmartSpentAppState extends State<SmartSpentApp> {
  late final AuthBloc _authBloc;
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _authBloc = sl<AuthBloc>();
    _appRouter = AppRouter(authBloc: _authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocProvider.value(
          value: _authBloc,
          child: MaterialApp.router(
            title: 'Smart Spent Story',
            theme: AppTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            routerConfig: _appRouter.router,
          ),
        );
      },
    );
  }
}
