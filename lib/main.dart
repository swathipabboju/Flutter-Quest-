import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TalkNest/firebase_options.dart';
import 'package:TalkNest/utils/AppColors/colors.dart';
import 'package:TalkNest/utils/Strings/strings.dart';
import 'package:TalkNest/viewModel/loginViewModel.dart';
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
    /*  return MultiBlocProvider(
      /*   providers: [
          BlocProvider(create: (_)=> TodolistCubit()),
          BlocProvider(create: (_) => CounterCubit()),
          BlocProvider(create: (_) => CounterBlocViewModel())
          ], */
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
        )); */ */
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
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
    );
  }
}
