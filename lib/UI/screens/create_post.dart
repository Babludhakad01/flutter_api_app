import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/createPost/create_post_bloc.dart';
import 'package:youtub_flutter_project/logic/Blocs/createPost/create_post_event.dart';
import 'package:youtub_flutter_project/logic/Blocs/createPost/create_post_state.dart';
import 'package:youtub_flutter_project/utils/enum.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreen();
}

class _CreatePostScreen extends State<CreatePostScreen> {
  final titleController = TextEditingController();
  final userIdController = TextEditingController();
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Post"),
        backgroundColor: Colors.orangeAccent,
      ),

      body: Padding(
        padding: EdgeInsets.all(12),

        child: Column(
          children: [


            //Title
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.person,
                  color: Colors.orangeAccent,
                ),
                labelText: "Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 10),
            
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: "UserId",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
            TextField(



            ),

            SizedBox(height: 30),
            BlocListener<CreatePostBloc, CreatePostState>(
              listener: (context, state) {
                if (!state.isEditing!) {
                  titleController.clear();
                  userIdController.clear();
                }
              },

              child: BlocBuilder<CreatePostBloc, CreatePostState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () {
                      if (!state.isEditing!) {
                        context.read<CreatePostBloc>().add(
                          PostCreated(
                            title: titleController.text,
                            userId: userIdController.text,
                          ),
                        );
                      } else {
                        context.read<CreatePostBloc>().add(
                          UpdatePostEvent(
                            title: titleController.text,
                            userId: userIdController.text,
                            id: selectedId.toString(),
                          ),
                        );
                      }
                      //
                      titleController.clear();
                      userIdController.clear();
                      selectedId = null;

                    },

                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.orangeAccent, Colors.deepOrange],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orangeAccent.withValues(alpha: 0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          state.isEditing! ? "Update Post" : "Add Post",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<CreatePostBloc, CreatePostState>(
                builder: (context, state) {
                  if (state.postStatus == PostStatus.loading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.postStatus == PostStatus.initial) {
                    return Center(
                      child: Text(
                        "No Post Added..",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state.createPostList.length,
                      itemBuilder: (context, index) {
                        final post = state.createPostList[index];
                        // print(state.createPostList.length);

                        return Card(
                          child: ListTile(
                            onTap: () {
                              selectedId = post.id;
                              print(selectedId);
                              titleController.text = post.title ?? "";
                              userIdController.text = post.userId ?? "";
                              context.read<CreatePostBloc>().add(
                                SelectEditPostEvent(post),
                              );
                            },
                            leading: Text(post.id.toString(),style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                            title: Text(post.title.toString(),style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                            subtitle: Text(post.userId.toString(), style: TextStyle(fontSize: 12, color: Colors.brown),),
                            iconColor: Colors.red,
                            trailing: IconButton(onPressed: (){
                              // print("Delete");
                              context.read<CreatePostBloc>().add(DeletePostEvent(post.id.toString()));


                            }, icon: Icon(Icons.delete),
                            )
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
