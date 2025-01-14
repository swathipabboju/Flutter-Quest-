import 'dart:async';


import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:TalkNest/model/post_data_response.dart';
import 'package:TalkNest/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostAddNewPostEvent>(postAddNewPostEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    try {
      List<PostDataResponse>? postList =
          await PostRepository().getPostDetails();
      emit(PostFetchingSuccesfulState(postList: postList));
    } catch (e) {
      emit(PostFailureCaseState(msg: e.toString()));
    }
  }

  Future<void> postAddNewPostEvent(
      PostAddNewPostEvent event, Emitter<PostState> emit) async {
    try {
      bool? success = await PostRepository().addPost();
      if (success ?? false) {
        debugPrint("Post added successfully");
        emit(PostAdditionSuccesfulState(msg: "Post added successfully"));
      } else {
        debugPrint("Failed to add post");
        emit(PostAdditionErrorState(msg: "Unable to add post"));
      }
    } catch (e) {
      emit(PostAdditionErrorState(msg: e.toString()));
      debugPrint("Error occurred while adding post: $e");
    }
  }
}
