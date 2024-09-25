import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sample_app/model/post_data_response.dart';
import 'package:sample_app/repository/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
  }

  FutureOr<void> postsInitialFetchEvent(
      PostsInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostLoadingState());
    List<PostDataResponse>? postList = await PostRepository().getPostDetails();
    emit(PostFetchingSuccesfulState(postList: postList));



    
    /* var client = http.Client();
    List<PostDataResponse> postDataList = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body) as List;
        postDataList = jsonResponse
            .map((post) => PostDataResponse.fromJson(post))
            .toList();
        emit(PostFetchingSuccesfulState(postList: postDataList));
      } else {
        // emit(PostFailureCaseState(msg: '{response.statusCode}'));
        emit(PostFailureCaseState(msg: 'No data Found'));
      }
    } catch (e) {
      emit(PostFailureCaseState(msg: '${e.toString()}'));
    } finally {
      client.close();
    } */
  }
}
