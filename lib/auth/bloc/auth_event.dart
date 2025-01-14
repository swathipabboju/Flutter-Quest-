part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithMobileEvent extends AuthEvent {
  final String mobileNumber;
  SignInWithMobileEvent({required this.mobileNumber});
}

class SignInWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignInWithEmailEvent({required this.email, required this.password});
}
class SignUpWithEmailEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpWithEmailEvent({required this.email, required this.password});
}
class SignUpWithMobileEvent extends AuthEvent {
   final String mobileNumber;
  SignUpWithMobileEvent({required this.mobileNumber});
}
class ToggleSignInMethodEvent extends AuthEvent {
}
class ToggleSignUpMethodEvent extends AuthEvent {
}
