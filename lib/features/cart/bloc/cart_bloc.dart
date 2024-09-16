import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_app/data/cart_items.dart';
import 'package:sample_app/model/bloc_model/home_product_data.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<RemoveFromCartEvent>(removeFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: cartItemsList));
  }

  FutureOr<void> removeFromCartEvent(RemoveFromCartEvent event, Emitter<CartState> emit) {
    cartItemsList.remove(event.productTobeRemoved);
    print("cartitems ${cartItemsList.length}");
    //to re build the screen we are emiting cartsuccestate only instead of creating new state again 
    emit(CartSuccessState(cartItems: cartItemsList));

  }
}
