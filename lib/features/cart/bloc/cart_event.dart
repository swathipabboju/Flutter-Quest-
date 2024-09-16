part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitialEvent extends CartEvent {}
class RemoveFromCartEvent extends CartEvent {
  final ProductDataModel productTobeRemoved;
  RemoveFromCartEvent({required this.productTobeRemoved});
}


