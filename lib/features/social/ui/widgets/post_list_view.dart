import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/social/data/models/get_posts_request_model.dart';
import 'package:medify/features/social/data/models/get_posts_response_model.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/widgets/post_widget.dart';

class PostListView extends StatefulWidget {
  const PostListView({super.key});

  @override
  State<PostListView> createState() => _PostListViewState();
}

class _PostListViewState extends State<PostListView> {
  List<Posts>? posts = [];
  @override
  void initState() {
    super.initState();
    // if (LocalData.getIsLogin() == true) {
    //   final user = LocalData.getAuthResponseModel();
    //   context.read<GetPostsCubit>().getAllPosts(
    //         requestModel: GetPostsRequestModel(
    //           doctorId: user!.user.id.toString(),
    //           token: user.token,
    //         ),
    //       );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        return switch (state) {
          SocialInitial() => SizedBox(),
          GetPostsLoading() => _buildLoading(),
          GetPostsError() => _buildError(state),
          GetPostsSuccess() => _buildSuccess(state),
          CreatePostCubitLoading() => _buildLoading(),
          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildSuccess(GetPostsSuccess state) {
    posts = state.getPostsResponseModel.posts;

    if (posts != null && posts!.isNotEmpty) {
      return ListView.builder(
        itemCount: posts!.length,
        itemBuilder: (context, index) {
          final post = posts![index];
          return Column(
            children: [
              Post(
                  postId: post.sId ?? '',
                username: post.doctorName ?? 'Unknown',
                timestamp: post.formattedDate ?? '',
                content: post.content ?? '',
                imageUrl:
                    'https://th.bing.com/th/id/R.883a4952998ca380853326bc61805259?rik=eMV9tHDVFS63Mw&pid=ImgRaw&r=0',
              ),
              const Divider(thickness: 0.6),
            ],
          );
        },
      );
    } else {
      return const Center(child: Text('No posts found.'));
    }
  }

  Center _buildError(GetPostsError state) =>
      Center(child: Text('Error: ${state.message}'));

  Center _buildLoading() => const Center(child: CircularProgressIndicator());
}




// import 'package:flutter/material.dart';
// import 'package:medify/features/social/ui/widgets/post_widget.dart';


// class PostListView extends StatelessWidget {
//   const PostListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: const [
//         Divider(thickness: 0.6),
//         Post(
//           username: "Amany alzanfaly",
//           timestamp: "2 hours ago",
//           content:
//               "Dream big, work hard, stay focused, and surround yourself with good energy.",
//           imageUrl:
//               "https://th.bing.com/th/id/R.883a4952998ca380853326bc61805259?rik=eMV9tHDVFS63Mw&pid=ImgRaw&r=0",
//         ),
//         Post(
//           username: "Amany alzanfaly",
//           timestamp: "1 day ago",
//           content: "Keep pushing forward, no matter how hard it gets.",
//           imageUrl:
//               "https://th.bing.com/th/id/OIP.372HTY_zy6Hzf3s8KtEB6wAAAA?w=474&h=316&rs=1&pid=ImgDetMain",
//         ),
//         Post(
//           username: "Amany alzanfaly",
//           timestamp: "3 days ago",
//           content:
//               "Eating healthy food is very important not only for having a healthy life but also protecting our hearts.",
//           imageUrl:
//               "https://th.bing.com/th/id/OIP.k1trY7GGyoZw5nSWHkn2AQHaFf?w=640&h=475&rs=1&pid=ImgDetMain",
//         ),
//       ],
//     );
//   }
// }
