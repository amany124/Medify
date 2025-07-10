import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/widgets/app_logo.dart';
import 'package:medify/core/widgets/app_name.dart';
import 'package:medify/core/widgets/custom_image_picker_widget.dart';
import 'package:medify/features/HeartAnaysis/data/models/heart_models.dart';
import 'package:medify/features/HeartAnaysis/ui/cubit/heart_analysis_cubit.dart';

class HeartAnalysisPage extends StatelessWidget {
  const HeartAnalysisPage({super.key});
  static const String routeName = '/heart-analysis';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FE),
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppLogo(height: 45),
            Gap(7),
            AppName(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => context.pushNamed(Routes.sidebar),
          icon: const Icon(Icons.menu, color: Colors.black),
        ),
        // actions: [
        //   Avatar.small(),
        //   const Gap(10),
        // ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: BlocBuilder<HeartAnalysisCubit, HeartAnalysisState>(
          builder: (context, state) {
            if (state is HeartAnalysisLoading) {
              return LoadingAnimationWidget.threeArchedCircle(
                color: Colors.blueAccent,
                size: 50,
              );
            } else if (state is HeartAnalysisSuccess) {
              return _ResultsContainer(result: state.result);
            } else if (state is HeartAnalysisError) {
              return Text(state.message);
            } else {
              return Image.asset(
                'assets/images/gif-unscreen.gif',
                width: 200,
                height: 200,
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final cubit = context.read<HeartAnalysisCubit>();
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (ctx) {
              return BlocProvider.value(
                value: cubit,
                child: CustomImagePickerWidget(
                  onImageSelected: (File image) {
                    Navigator.pop(ctx);
                    cubit.analyzeImage(image);
                  },
                ),
              );
            },
          );
        },
        backgroundColor: const Color(0xFF1E88E5),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _ResultsContainer extends StatelessWidget {
  final HeartAnalysisResultModel result;

  const _ResultsContainer({required this.result});

  @override
  Widget build(BuildContext context) {
    final imageBytes = base64Decode(result.heatmapImageBase64);

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Analysis Result",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E88E5),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "• Diagnosis: ${result.predictedClass}",
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.memory(imageBytes),
          ),
        ],
      ),
    );
  }
}
