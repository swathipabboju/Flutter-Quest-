import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sample_app/data/cart_items.dart';
import 'package:sample_app/data/grocery_data.dart';
import 'package:sample_app/data/whishlist_items.dart';
import 'package:sample_app/model/bloc_model/home_product_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    /*  on<HomeEvent>((event, emit) {
      // TODO: implement event handler
    }); */
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
    on<HomeWishlistButtonClickedEvent>(homeWishlistButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCarttButtonNavigateEvent>(homeCarttButtonNavigateEvent);
  }

  Future<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 5));
    emit(
      HomeLoadedSuccessState(
          products: GroceryData.groceryProducts
              .map(
                (e) => ProductDataModel(
                    id: e['id'],
                    name: e['name'],
                    description: e['description'],
                    imageUrl: e['image_url'],
                    price: e['price']),
              )
              .toList()),
    );
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    cartItemsList.add(event.clickedProduct);
    emit(HomeProductItemWhsihlistActionState());
  }

  FutureOr<void> homeWishlistButtonClickedEvent(
      HomeWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    wishItemsList.add(event.clickedProduct);
    emit(HomeProductItemCartActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigationToWishlistPageActionState());
  }

  FutureOr<void> homeCarttButtonNavigateEvent(
      HomeCarttButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigationToCartPageActionState());
  }
}
