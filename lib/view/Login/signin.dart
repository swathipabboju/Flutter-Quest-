import 'package:TalkNest/res/styles/string_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/ReusableWidgets/TextButton.dart';
import '../../utils/ReusableWidgets/button.dart';
import '../../utils/ReusableWidgets/phone_textformfield.dart';
import '../../utils/Routes/appRoutes.dart';
import 'package:TalkNest/auth/bloc/auth_bloc.dart';


class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  TextEditingController _mobile = TextEditingController(text: "7995490649");
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  FocusScopeNode _mobilenode = FocusScopeNode();
  FocusScopeNode _emailnode = FocusScopeNode();
  FocusScopeNode _passwordnode = FocusScopeNode();

  // Handle sign-in action
  void _handleSignIn(BuildContext context, bool isSignInWithMobile) {
    if (isSignInWithMobile) {
      context.read<AuthBloc>().add(
            SignInWithMobileEvent(mobileNumber: _mobile.text),
          );
    } else {
      context.read<AuthBloc>().add(
            SignInWithEmailEvent(
              email: _email.text,
              password: _password.text,
            ),
          );
    }
  }

  // Widget for form fields based on the sign-in method
  Widget _buildSignInUi(bool isSignInWithMobile) {
    if (isSignInWithMobile) {
      return PhoneTextformfield(
        controller: _mobile,
        hintText: StringConstants.mobileNumberHint,
        TextLength: 10,
        keyboardInputType: TextInputType.phone,
        obscureText: false,
        node: _mobilenode,
        onEditingComplete: () => _mobilenode.nextFocus(),
        action: TextInputAction.next,
        errorMessage: StringConstants.errorMobileNumber,
      );
    } else {
      return Column(
        children: [
          PhoneTextformfield(
            controller: _email,
            hintText: StringConstants.emailHint,
            node: _emailnode,
            errorMessage: StringConstants.errorEmail,
          ),
          SizedBox(height: 10),
          PhoneTextformfield(
            controller: _password,
            hintText: StringConstants.passwordHint,
            node: _passwordnode,
            obscureText: true,
            errorMessage: StringConstants.errorPassword,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, state) {
            if (state is AuthErrorState) {
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                  SnackBar(content: Text("${state.errorMessage} ")));
            }
            if (state is AuthSuccessState) {
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                  SnackBar(content: Text("Successfully authenticated")));
              Navigator.pushNamed(context, AppRoutes.signupScreenMobile);
            }
          },
          builder: (BuildContext context, state) {
            bool isSignInWithMobile = false; // Default value
            if (state is ToggleSignInMethodState) {
              isSignInWithMobile = state.isSignInWithMobile;
            }

            if (state is AuthLoadingState) {
              return CircularProgressIndicator(); // Show loading spinner
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSignInUi(isSignInWithMobile),
                SizedBox(height: 20),
                ReusableButton(
                  ButtonText: isSignInWithMobile
                      ? StringConstants.loginWithMobileButtonText
                      : StringConstants.loginWithEmailButtonText,
                  onPressed: () => _handleSignIn(context, isSignInWithMobile),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringConstants.signUpText),
                      ReusableTextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signupScreen);
                        },
                        ButtonText: StringConstants.signUpButtonText,
                        decoration: TextDecoration.underline,
                      )
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(ToggleSignInMethodEvent());
                  },
                  child: Text(
                    isSignInWithMobile
                        ? StringConstants.switchToEmailText
                        : StringConstants.switchToMobileText,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
