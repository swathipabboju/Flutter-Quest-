part of 'post_bloc.dart';

// it is for builders
sealed class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

// for listners
abstract class PostActionState extends PostState {}

final class PostInitial extends PostState {}

final class PostLoadingState extends PostState {}
final class PostFailureCaseState extends PostState {
  final String msg;
  PostFailureCaseState({required this.msg});
}

final class PostFetchingSuccesfulState extends PostState {
  final List<PostDataResponse>? postList;
  PostFetchingSuccesfulState({required this.postList});
}
