import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    /*  on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    }); */
    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
    on<HomeWishlistButtonClickedEvent>(homeWishlistButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCarttButtonNavigateEvent>(homeCarttButtonNavigateEvent);
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("cart");
  }

  FutureOr<void> homeWishlistButtonClickedEvent(
      HomeWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint("whislist");
    // now we need to emit a state
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    debugPrint("whislist navigate");
    emit(HomeNavigationToWishlistPageActionState());
  }

  FutureOr<void> homeCarttButtonNavigateEvent(
      HomeCarttButtonNavigateEvent event, Emitter<HomeState> emit) {
    debugPrint("cart navigate");
    emit(HomeNavigationToCartPageActionState());
  }
}
