part of 'whishlist_bloc.dart';

sealed class WhishlistState extends Equatable {
  const WhishlistState();
  
  @override
  List<Object> get props => [];
}

final class WhishlistInitial extends WhishlistState {}
