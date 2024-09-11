import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/cubit/todolist_cubit.dart';
import 'package:sample_app/firebase_options.dart';
import 'package:sample_app/viewModel/bloc/counter_bloc_view_model.dart';
import 'package:sample_app/viewModel/cubit/counter_cubit_view_model.dart';
import 'utils/Routes/appPages.dart';
import 'utils/Routes/appRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_)=> TodolistCubit()),
          BlocProvider(create: (_) => CounterCubit()),
          BlocProvider(create: (_) => CounterBlocViewModel())],
        child: MaterialApp(
          initialRoute: AppRoutes.initial,
          routes: AppPages.routes,
          debugShowCheckedModeBanner: false,
        ));
    /*  // to provide instances of bloc
    return BlocProvider(
        create: (_) => CounterCubit(),
        child: MaterialApp(
          initialRoute: AppRoutes.initial,
          routes: AppPages.routes,
          debugShowCheckedModeBanner: false,
        )); */
    /* MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginWithMobileViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => ResetPasswordModel()),
        ChangeNotifierProvider(create: (_) => OtpViewModel()),
        ChangeNotifierProvider(create: (_) => SetMpinViewModel()),
        ChangeNotifierProvider(create: (_) => ValidateMpinViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.title,
        initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
        theme: ThemeData(
          primarySwatch: AppColors.navy,
        ),
      ),
    ); */
  }
}
