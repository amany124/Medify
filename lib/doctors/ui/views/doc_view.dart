import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/widgets/bottom_navigation_content.dart';
//import 'package:graduation_project/features/about%20us/ui/views/aboutus_view.dart';
import '../../../about us/ui/views/aboutus_view.dart';
import '../widgets/CustomSearchBar.dart';
import '../widgets/doc_card.dart';

class DocsView extends StatelessWidget {
  const DocsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomnavigationContent(),
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
                    Gap(14),
                    CustomSearchBar(),
                    Gap(15),
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
