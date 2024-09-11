part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// event 1
class HomeProductWishlistButtonClickedEvent extends HomeEvent {}

// event 2
class HomeProductCartWishlistButtonClickedEvent extends HomeEvent {}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCarttButtonNavigateEvent extends HomeEvent {}
