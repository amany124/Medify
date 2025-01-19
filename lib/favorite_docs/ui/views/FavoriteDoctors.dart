import 'package:flutter/material.dart';
import '../../../about us/ui/views/aboutus_view.dart';
import '../../../doctors/ui/widgets/doc_card.dart';

class Favoritedoctors extends StatelessWidget {
  const Favoritedoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(
        title: 'Favorite Doctors',
      ),

      body: SafeArea(
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
          child: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
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