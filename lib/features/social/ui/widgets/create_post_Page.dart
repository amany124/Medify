import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/core/di/di.dart';
import 'dart:io';

import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/social/data/models/update_post_request_model.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import '../../data/models/create_post_request_model.dart';
import '../cubits/create_post_cubit/create_post_cubit.dart';

class CreatePostPage extends StatelessWidget {
  final bool isEditing;
  final String? contentText;
  final String? postId;
  const CreatePostPage(
      {super.key, this.isEditing = false, this.contentText, this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SocialCubit>(),
      child: CreatePostView(
        isEditing: isEditing,
        contentText: contentText,
        postId: postId,
      ),
    );
  }
}

class CreatePostView extends StatefulWidget {
  final bool isEditing;
  final String? contentText;
  final String? postId;

  const CreatePostView(
      {super.key, required this.isEditing, this.contentText, this.postId});
  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _contentController = TextEditingController();
  File? selectedImage;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  Future<void> _editPost() async {
    final UpdatePostsRequestModel requestModel = UpdatePostsRequestModel(
      postId: widget.postId!,
      token: LocalData.getAuthResponseModel()!.token,
      content: _contentController.text,
    );
    
    await BlocProvider.of<SocialCubit>(context)
        .updatePost(requestModel: requestModel);
        Navigator.pop(context);
  }

  Future<void> _submitPost() async {
    final contentText = _contentController.text.trim();

    if (contentText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please write something before posting."),
        ),
      );
      return;
    }

    final token = LocalData.getAuthResponseModel()?.token;
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User not authenticated."),
        ),
      );
      return;
    }
    // the code for creating a post
    final createPostRequest = CreatePostRequestModel(
      content: contentText,
      token: token,
    );

    await context.read<SocialCubit>().createPost(
          requestModel: createPostRequest,
        );

    // Debug log
    print("✅ Content sent: $contentText");
    print("🖼️ Image path: ${selectedImage?.path}");

    Navigator.pop(context);
  }

  @override
  void initState() {
    widget.isEditing
        ? _contentController.text = widget.contentText!
        : 'no text';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isEditing ? Text("Edit Post") : Text("Create Post"),
        centerTitle: true,
        // backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _contentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your post...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            selectedImage != null
                ? Image.file(selectedImage!, height: 150)
                : Text("No image selected"),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: Icon(Icons.image),
              label: Text("Add Image"),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: widget.isEditing ? _editPost : _submitPost,
                  child: Text("OK"),
                ),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
