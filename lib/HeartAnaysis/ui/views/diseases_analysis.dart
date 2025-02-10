import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/core/utils/widgets/app_logo.dart';
import 'package:medify/core/utils/widgets/app_name.dart';
import 'package:medify/core/utils/widgets/avatar.dart';
import 'package:medify/core/utils/widgets/bottom_navigation_content.dart';

class HeartAnalysisPage extends StatefulWidget {
  const HeartAnalysisPage({super.key});

  @override
  _HeartAnalysisPageState createState() => _HeartAnalysisPageState();
}

class _HeartAnalysisPageState extends State<HeartAnalysisPage> {
  bool showResults = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F8FE),
      appBar: AppBar(
        title: const Row(
      children: [
        AppLogo(height:45),
        Gap(7),
        AppName(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.normal,

        ),
      ],
    ),
        leading: const Icon(Icons.menu, color: Colors.black,),
        actions: [
          Avatar.small(),
          const Gap(10),
        ],
        backgroundColor:  Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: showResults
            ? _ResultsContainer() // Displays the analysis results.
            : Image.asset(
                'assets/images/gif.gif',
                width: 150,
                height: 150,
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => _ImagePickerWidget(
            onImageSelected: () {
              setState(() {
                showResults = true;
              });
            },
          ),
        ),
        backgroundColor: const Color(0xFF1E88E5),
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: bottomnavigationContent(),
    );
  }
}

class _ImagePickerWidget extends StatelessWidget {
  final VoidCallback onImageSelected;

  const _ImagePickerWidget({required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Open gallery'),
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageSelected();
            }
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Open camera'),
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              onImageSelected();
            }
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class _ResultsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Analysis Results",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E88E5),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "• Blood Pressure: 120/80",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "• Heart Rate: 72 bpm",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "• Oxygen Level: 98%",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
