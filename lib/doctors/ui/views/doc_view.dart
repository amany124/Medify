import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/features/about%20us/ui/views/aboutus_view.dart';
import '../../../about us/ui/views/aboutus_view.dart';
import '../widgets/CustomSearchBar.dart';
import '../widgets/doc_card.dart';

class DocsView extends StatelessWidget {
  const DocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Top Rated Doctors',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchBar(),
                    Gap(20),
                  ],
                ),
              ),
              SliverList.builder(
                itemBuilder: (context, index) {
                  return const DocCard();
                },
                itemCount: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
