import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/utils/ReusableWidgets/password_textformfield.dart';
import '../../utils/ReusableWidgets/TextButton.dart';
import '../../utils/ReusableWidgets/button.dart';
import '../../utils/ReusableWidgets/phone_textformfield.dart';
import '../../utils/Routes/appRoutes.dart';
import '../../viewModel/loginWithMobileViewModel.dart';

class LoginWithMobileScreen extends StatelessWidget {
  LoginWithMobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _mobile = TextEditingController();
    TextEditingController _Password = TextEditingController();
    FocusScopeNode _node = FocusScopeNode();
    final loginProvider = Provider.of<LoginWithMobileViewModel>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhoneTextformfield(
              controller: _mobile,
              hintText: 'Mobile Number',
              TextLength: 10,
              keyboardInputType: TextInputType.phone,
              obscureText: false,
              node: _node,
              onEditingComplete: () {
                _node.nextFocus();
              },
              action: TextInputAction.next,
              errorMessage: 'Please Enter Mobile Number',
            ),
            PasswordTextformfield(
                hintText: "Password",
                controller: _Password,
                keyboardInputType: TextInputType.visiblePassword,
                obscureText: false,
                TextLength: 30,
                node: _node,
                action: TextInputAction.done,
                onEditingComplete: () {
                  _node.nextFocus();
                },
                errorMessage: "Please Enter Password"),
            ReusableTextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.forgotpassword);
              },
              ButtonText: "Forgot Password",
              decoration: TextDecoration.underline,
            ),
            ReusableButton(
              ButtonText: "Login",
              onPressed: () {
                loginProvider.UserLogin(_mobile.text, _Password.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
