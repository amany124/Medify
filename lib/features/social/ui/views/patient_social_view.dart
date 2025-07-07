import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

import '../../../../core/utils/keys.dart';
import '../widgets/patient_post_list_view.dart';

class PatientSocialView extends StatelessWidget {
  const PatientSocialView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SocialCubit, SocialState>(
          listener: (context, state) {
            if (state is CreatePostCubitSuccess) {
              // Refresh patient social posts after successful create
              context.read<SocialCubit>().getPatientSocialPosts(
                    token: CacheManager.getData(key: Keys.token) ?? '',
                  );
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                'Social Feed',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff223A6A),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Gap(20),
              Expanded(child: PatientSearchBarWidget()),
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          surfaceTintColor: Colors.white,
        ),
        body: const PatientPostListView(),
        floatingActionButton: FloatingActionButton.extended(
          heroTag: 'patient_social_refresh',
          backgroundColor: const Color(0xff223A6A),
          onPressed: () {
            // Refresh posts
            context.read<SocialCubit>().getPatientSocialPosts(
                  token: CacheManager.getData(key: Keys.token) ?? '',
                );
          },
          icon: const Icon(
            Icons.refresh,
            color: Colors.white,
          ),
          label: const Text(
            'Refresh',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class PatientSearchBarWidget extends StatefulWidget {
  const PatientSearchBarWidget({super.key});

  @override
  State<PatientSearchBarWidget> createState() => _PatientSearchBarWidgetState();
}

class _PatientSearchBarWidgetState extends State<PatientSearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        textAlign: TextAlign.center,
        onChanged: (value) {
          setState(() {}); // Trigger rebuild to update suffix icon
          if (value.isEmpty) {
            context.read<SocialCubit>().clearSearch();
          } else {
            context.read<SocialCubit>().searchPosts(value);
          }
        },
        decoration: InputDecoration(
          hintText: 'Search social posts...',
          hintStyle: const TextStyle(color: Colors.black54),
          border: InputBorder.none,
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                    context.read<SocialCubit>().clearSearch();
                  },
                )
              : const Icon(Icons.search, color: Colors.black54),
        ),
      ),
    );
  }
}
