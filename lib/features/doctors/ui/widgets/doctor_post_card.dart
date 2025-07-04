import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/models/doctor_public_profile_model.dart';

class DoctorPostCard extends StatefulWidget {
  final DoctorPost post;

  const DoctorPostCard({
    super.key,
    required this.post,
  });

  @override
  State<DoctorPostCard> createState() => _DoctorPostCardState();
}

class _DoctorPostCardState extends State<DoctorPostCard> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1877F2).withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/doctor.png'),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. ${widget.post.doctorName}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        widget.post.formattedDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.post.content,
              style: const TextStyle(
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          if (widget.post.image != null && widget.post.image!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  widget.post.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey[200],
                    child: const Center(child: Text('Image not available')),
                  ),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[100],
                      child: Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xff1877F2),
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    Text(
                      widget.post.likes.toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const Gap(16),
                    IconButton(
                      icon: Icon(
                        Icons.comment_outlined,
                        color: Colors.grey[600],
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      '0', // API doesn't provide comment count
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.share_outlined,
                    color: Colors.grey[600],
                  ),
                  onPressed: () {
                    _sharePost();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to share a doctor's post
  void _sharePost() {
    final post = widget.post;
    String shareText;

    if (post.content.isNotEmpty) {
      shareText = '''
Medical post by Dr. ${post.doctorName}:

"${post.content}"

Posted on ${post.formattedDate}

${post.image != null && post.image!.isNotEmpty ? 'View image in the Medify app.' : ''}

Open the Medify app to see more posts and book appointments!
''';
    } else {
      shareText = '''
Dr. ${post.doctorName} shared a medical post on ${post.formattedDate}.

Open the Medify app to view the full content and book appointments!
''';
    }

    Share.share(
      shareText,
      subject: 'Dr. ${post.doctorName}\'s Medical Post',
    );
  }
}
