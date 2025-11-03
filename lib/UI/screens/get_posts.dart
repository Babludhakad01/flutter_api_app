import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtub_flutter_project/core/navigation/navigation_service.dart';
import 'package:youtub_flutter_project/logic/Blocs/posts/posts_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/posts/posts_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/posts/posts_state.dart';
import 'package:youtub_flutter_project/routes/app_router.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreen();
}

class _PostScreen extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter API Implement"),
        backgroundColor: Colors.orangeAccent,
        actions: [
          IconButton(
            onPressed: () {
              NavigationService.pushNamed(AppRoutes.createPost);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: BlocBuilder<PostBloc, PostStates>(
        builder: (context, state) {
          switch (state.postStatus) {
            case PostStatus.initial:
              return Text("No data");
            case PostStatus.loading:
              return Center(child: CircularProgressIndicator());

            case PostStatus.failure:
              return Text("Error API Data ${state.message}");

            case PostStatus.success:
              return Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (filterKey) {
                      context.read<PostBloc>().add(SearchItem(filterKey));
                    },
                  ),
                  Expanded(
                    child: state.searchMessage.isNotEmpty
                        ? Center(child: Text(state.searchMessage.toString()))
                        : ListView.builder(
                            itemCount: state.tempPostList.isEmpty
                                ? state.postlist.length
                                : state.tempPostList.length,
                            itemBuilder: (context, index) {
                              if (state.tempPostList.isNotEmpty) {
                                final item = state.tempPostList[index];
                                print(item);
                                return Card(
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    title: Text(item.name.toString()),
                                    subtitle: Text(item.email.toString()),
                                  ),
                                );
                              } else {
                                final item = state.postlist[index];
                                print(item);
                                return Card(
                                  color: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: ListTile(
                                    title: Text(item.name.toString()),
                                    subtitle: Text(item.email.toString()),
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
