part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

// when home page is opened an initial event to be occur automatically for insta page
class HomeInitialEvent extends HomeEvent {}

// event 1
class HomeWishlistButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;
  HomeWishlistButtonClickedEvent({required this.clickedProduct});
}

// event 2
class HomeCartButtonClickedEvent extends HomeEvent {
  final ProductDataModel clickedProduct;

  HomeCartButtonClickedEvent({required this.clickedProduct});
}

class HomeWishlistButtonNavigateEvent extends HomeEvent {}

class HomeCarttButtonNavigateEvent extends HomeEvent {}
