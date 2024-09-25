import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/features/post/bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc postBloc = PostBloc();
  @override
  void initState() {
    postBloc.add(PostsInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post Page"),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingSuccesfulState:
              final successState = state as PostFetchingSuccesfulState;
              return Container(
                child: ListView.builder(
                  itemCount: successState.postList?.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${successState.postList?[index].title}",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "${successState.postList?[index].body}",
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );

            case PostLoadingState:
              return Center(child: CircularProgressIndicator());
            case PostFailureCaseState:
              final failureState = state as PostFailureCaseState;
              return Center(child: Text("${failureState.msg}"));
          }
          return Container();
        },
      ),
    );
  }
}
