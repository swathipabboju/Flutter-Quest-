part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {}

final class AuthErrorState extends AuthState {
  final String errorMessage;
  final String source;

  AuthErrorState({
    required this.errorMessage,
    required this.source,
  });
  @override
  List<Object> get props => [errorMessage, source];
}

class ToggleSignInMethodState extends AuthState {
  final bool isSignInWithMobile;
  ToggleSignInMethodState({required this.isSignInWithMobile});
  @override
  List<Object> get props => [isSignInWithMobile];
}
class ToggleSignUpMethodState extends AuthState {
  final bool isSignUpWithMobile;
  ToggleSignUpMethodState({required this.isSignUpWithMobile});
  @override
  List<Object> get props => [isSignUpWithMobile];
}
