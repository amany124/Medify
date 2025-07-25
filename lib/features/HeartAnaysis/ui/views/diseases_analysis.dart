import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/widgets/app_logo.dart';
import 'package:medify/core/widgets/app_name.dart';
import 'package:medify/core/widgets/avatar.dart';
import 'package:medify/core/widgets/bottom_navigation_content.dart';
import 'package:medify/features/HeartAnaysis/data/models/heart_models.dart';
import 'package:medify/features/HeartAnaysis/ui/views/cubit/heart_analysis_cubit.dart';

class HeartAnalysisPage extends StatelessWidget {
  const HeartAnalysisPage({super.key});
  static const String routeName = '/heart-analysis';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FE),
      appBar: AppBar(
        title: const Row(
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
        actions: [
          Avatar.small(),
          const Gap(10),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: BlocBuilder<HeartAnalysisCubit, HeartAnalysisState>(
          builder: (context, state) {
            if (state is HeartAnalysisLoading) {
              return const CircularProgressIndicator();
            } else if (state is HeartAnalysisSuccess) {
              return _ResultsContainer(result: state.result);
            } else if (state is HeartAnalysisError) {
              return Text(state.message);
            } else {
              return Image.asset(
                'assets/images/gif.gif',
                width: 150,
                height: 150,
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
                child: _ImagePickerWidget(
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
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: const BottomnavigationContent(),
    );
  }
}

class _ImagePickerWidget extends StatelessWidget {
  final Function(File image) onImageSelected;

  const _ImagePickerWidget({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Open gallery'),
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Open camera'),
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            }
          },
        ),
      ],
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
