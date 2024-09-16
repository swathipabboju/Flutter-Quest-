part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;
  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {}

// action states
class HomeNavigationToWishlistPageActionState extends HomeActionState {}

class HomeNavigationToCartPageActionState extends HomeActionState {}

class HomeProductItemWhsihlistActionState extends HomeActionState {}

class HomeProductItemCartActionState extends HomeActionState {}
