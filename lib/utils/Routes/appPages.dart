import 'package:TalkNest/view/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:TalkNest/features/cart/ui/cart_page.dart';
import 'package:TalkNest/features/home/ui/home.dart';
import 'package:TalkNest/features/post/ui/post_page.dart';
import 'package:TalkNest/features/wishlist/ui/whishlist_page.dart';
import 'package:TalkNest/view/explore_folder/scratch_card_screen.dart';
import 'package:TalkNest/view/Login/setMpin.dart';
import 'package:TalkNest/view/Login/signup.dart';
import 'package:TalkNest/view/Login/validateMpin.dart';
import 'package:TalkNest/view/app_life_cycle.dart';
import 'package:TalkNest/view/cubit/add_todo.dart';
import 'package:TalkNest/view/cubit/counter_bloc_page.dart';
import 'package:TalkNest/view/cubit/counter_page.dart';
import 'package:TalkNest/view/cubit/display_todo_list.dart';
import 'package:TalkNest/view/excel_data_view.dart';
import 'package:TalkNest/view/sign_in_with_phone.dart';
import '../../view/Login/forgotpassword.dart';
import '../../view/Login/signin.dart';
import '../../view/Login/loginWithMobileView.dart';
import '../../view/Login/otp.dart';
import 'appRoutes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes {
    return {
      AppRoutes.login: (context) => SignIn(),
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
      AppRoutes.cartpage: (context) => CartPage(),
      AppRoutes.whishlistPage: (context) => WhishListPage(),
      AppRoutes.excelDataView: (context) => ExcelDataView(
            title: "Excel data",
          ),
      AppRoutes.applifecycle: (context) => MyAppLifecycleObserver(),
      AppRoutes.chatScreen: (context) => ChatScreen(
            receiverId: '',
          ),
    };
  }
}
