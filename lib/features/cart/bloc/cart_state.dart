part of 'cart_bloc.dart';

/* sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
} */

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartItems;
  CartSuccessState({required this.cartItems});
  
}

