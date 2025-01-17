import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignInWithMobileEvent>(onSignInWithMobileEvent);
    on<SignInWithEmailEvent>(onSignInWithEmailEvent);
    on<SignUpWithEmailEvent>(onSignUpWithEmailEvent);
    on<ToggleSignInMethodEvent>(onToggleSignInMethodEvent);
    on<ToggleSignUpMethodEvent>(onToggleSignUpMethodEvent);
  }

  Future<void> onSignInWithMobileEvent(
      SignInWithMobileEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      // Step 1: Verify phone number
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "+91${event.mobileNumber}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto-retrieved OTP or instant validation
          await _firebaseAuth.signInWithCredential(credential);
          emit(AuthSuccessState());
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(AuthErrorState(
              errorMessage: e.message.toString(), source: 'LoginWithMobile'));
        },
        codeSent: (String verificationId, int? resendToken) {
          // OTP is sent, now wait for the user to enter it
          // You can pass verificationId to the UI screen to enter the OTP
          // emit(AuthOtpSentState(verificationId: verificationId));

          print("otp sent ^^^^^^^^^^^^^^^^^");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      emit(AuthErrorState(
          errorMessage: "Unable to verify phone number",
          source: 'LoginWithMobile'));
    }
  }

  Future<void> onSignUpWithMobileEvent(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);
      print('User signed in: ${userCredential.user?.email}');
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(
          errorMessage: "Unable to insert data", source: 'SignInWithEmail'));
    }
  }

  Future<void> onSignInWithEmailEvent(
      SignInWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password);
      print('User signed in: ${userCredential.user?.email}');
      emit(AuthSuccessState());
    } catch (e) {
      String errorMessage = "";

      if (e is FirebaseAuthException) {
        print("e... ${e.code}");
        // Handle specific error codes
        switch (e.code) {
          case 'user-not-found':
            errorMessage = "No user found for that email.";
            break;
          case 'wrong-password':
            errorMessage = "Incorrect password.";
            break;
          case 'invalid-email':
            errorMessage = "The email address is badly formatted.";
            break;
          case 'invalid-credential':
            errorMessage =
                "invalid-credentials. Please try with valid credentials";

          default:
            errorMessage = "Invalid credential";
            break;
        }
      }
      emit(AuthErrorState(
          errorMessage: errorMessage, source: 'SignInWithEmail'));
    }
  }

  Future<void> onSignUpWithEmailEvent(
      SignUpWithEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      print('User signed up the gmail: ${userCredential.user?.email}');
      // Send email verification after sign-up
      await userCredential.user?.sendEmailVerification();
      if (userCredential.user?.emailVerified ?? false) {
        emit(AuthSuccessState());
      } else {
        emit(AuthErrorState(
          errorMessage: "Email verification failed or wasn't sent.",
          source: 'EmailVerification',
        ));
      }
    } catch (e) {
      emit(AuthErrorState(
        errorMessage: "Unable to Register the user",
        source: 'SignUpWithEmail',
      ));
    }
  }

  FutureOr<void> onToggleSignInMethodEvent(
      ToggleSignInMethodEvent event, Emitter<AuthState> emit) {
    final currentState = state;
    if (currentState is ToggleSignInMethodState) {
      emit(ToggleSignInMethodState(
          isSignInWithMobile: !currentState.isSignInWithMobile));
    } else {
      emit(ToggleSignInMethodState(
          isSignInWithMobile: true)); // Default if no state yet
    }
  }

  FutureOr<void> onToggleSignUpMethodEvent(
      ToggleSignUpMethodEvent event, Emitter<AuthState> emit) {
    final currentState = state;
    if (currentState is ToggleSignUpMethodState) {
      emit(ToggleSignUpMethodState(
          isSignUpWithMobile: !currentState.isSignUpWithMobile));
    } else {
      emit(ToggleSignUpMethodState(
          isSignUpWithMobile: true)); // Default if no state yet
    }
  }
}
