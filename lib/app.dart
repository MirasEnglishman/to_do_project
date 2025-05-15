
import 'package:asyl_project/presentation/auth/bloc/auth_bloc.dart';
import 'package:asyl_project/presentation/initial_screen.dart';
import 'package:asyl_project/presentation/quote/bloc/quote_bloc.dart';
import 'package:asyl_project/presentation/tasks/bloc/tasks_cubit.dart';
import 'package:asyl_project/service_locator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => serviceLocator<TasksCubit>(),),
        BlocProvider(create: (context) => serviceLocator<QuoteCubit>(),),
        BlocProvider(create: (context) => serviceLocator<AuthCubit>(),),


      ],
      child: ScreenUtilInit(
        designSize: const Size(380, 810),
        useInheritedMediaQuery: true,
        builder: (context, snapshot) {
          return MaterialApp(
                        localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
              debugShowCheckedModeBanner: false,
              home: InitialScreen(),
          );
        },
      ),
    );
  }
}
