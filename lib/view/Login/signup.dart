import 'package:TalkNest/auth/bloc/auth_bloc.dart';
import 'package:TalkNest/res/styles/string_constants.dart';
import 'package:TalkNest/utils/ReusableWidgets/TextButton.dart';
import 'package:TalkNest/utils/ReusableWidgets/phone_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TalkNest/utils/Routes/appRoutes.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final FocusScopeNode mobileNode = FocusScopeNode();
  final FocusScopeNode pswdNode = FocusScopeNode();
  final FocusScopeNode emailNode = FocusScopeNode();

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(StringConstants.signUpTitle),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            // Redirect to Home or another screen on success
            Navigator.pushReplacementNamed(context, AppRoutes.login);
          } else if (state is AuthErrorState) {
            // Show error message if sign-up fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          bool isSignUpWithMobile = false; // Default value
          if (state is ToggleSignUpMethodState) {
            isSignUpWithMobile = state.isSignUpWithMobile;
          }

          return SingleChildScrollView(  // Wrap Column with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                if (!isSignUpWithMobile)
                  // Email Sign Up Form
                  Column(
                    children: [
                      PhoneTextformfield(
                        controller: _emailController,
                        hintText: StringConstants.emailHint,
                        node: emailNode,
                        errorMessage: StringConstants.enterEmailError,
                      ),
                      PhoneTextformfield(
                        controller: _passwordController,
                        hintText: StringConstants.passwordHint,
                        obscureText: true,
                        node: pswdNode,
                        errorMessage: StringConstants.enterPasswordError,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                SignUpWithEmailEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                ),
                              );
                        },
                        child: Text(StringConstants.signUpWithEmailButton),
                      ),
                    ],
                  )
                else
                  // Mobile Sign Up Form
                  Column(
                    children: [
                      PhoneTextformfield(
                        controller: _mobileController,
                        hintText: StringConstants.mobileNumberHint,
                        obscureText: true,
                        node: mobileNode,
                        errorMessage: StringConstants.enterMobileNumberError,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(
                                SignUpWithMobileEvent(
                                  mobileNumber: _mobileController.text,
                                ),
                              );
                        },
                        child: Text(StringConstants.signUpWithMobileButton),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringConstants.alreadyHaveAccountText),
                      ReusableTextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        ButtonText: StringConstants.signInHereButtonText,
                        decoration: TextDecoration.underline,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(ToggleSignUpMethodEvent());
                  },
                  child: Text(
                    isSignUpWithMobile
                        ? StringConstants.switchToEmailSignUpText
                        : StringConstants.switchToMobileSignUpText,
                    style: TextStyle(
                      color: Colors.amber,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                if (state is AuthLoadingState) CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
    ),
  );
}


}
