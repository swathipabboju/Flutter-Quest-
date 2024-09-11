import 'package:flutter/material.dart';
import 'package:sample_app/features/home/ui/home.dart';
import 'package:sample_app/view/Login/scratch_card_screen.dart';
import 'package:sample_app/view/Login/setMpin.dart';
import 'package:sample_app/view/Login/signup.dart';
import 'package:sample_app/view/Login/validateMpin.dart';
import 'package:sample_app/view/cubit/add_todo.dart';
import 'package:sample_app/view/cubit/counter_bloc_page.dart';
import 'package:sample_app/view/cubit/counter_page.dart';
import 'package:sample_app/view/cubit/display_todo_list.dart';
import 'package:sample_app/view/insta/post_page.dart';
import 'package:sample_app/view/sign_in_with_phone.dart';
import '../../view/Login/forgotpassword.dart';
import '../../view/Login/login.dart';
import '../../view/Login/loginWithMobileView.dart';
import '../../view/Login/otp.dart';
import 'appRoutes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.login: (context) => LoginScreen(),
      AppRoutes.forgotpassword: (context) => ForgotPasswordPage(),
      AppRoutes.loginWithMobile: (context) => LoginWithMobileScreen(),
      AppRoutes.otpScreen: (context) => Otp(),
      AppRoutes.signupScreen: (context) => SignInScreen(),
      AppRoutes.SetMpinScreen: (context) => SetMPINPage(),
      AppRoutes.ValidateMpin: (context) => ValidateMpin(),
      AppRoutes.dismissableWidget: (context) => ScratchCardScreen(),
      AppRoutes.signupScreenMobile: (context) => PhoneSignInScreen(),
      AppRoutes.counterPage: (context) => CounterPage(),
      AppRoutes.counterBlocPage: (context) => CounterBlocPage(),
      AppRoutes.displayTodoList: (context) => DisplayTodoList(),
      AppRoutes.addtodo: (context) => AddTodo(),
      AppRoutes.postpage: (context) => PostPage(),
      AppRoutes.homepage: (context) => HomePage(),
    };
  }
}
