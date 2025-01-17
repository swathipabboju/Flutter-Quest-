import 'package:TalkNest/auth/bloc/auth_bloc.dart';
import 'package:TalkNest/chat/bloc/chat_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TalkNest/firebase_options.dart';
import 'package:TalkNest/utils/AppColors/colors.dart';
import 'package:TalkNest/utils/Strings/strings.dart';
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
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        )
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
