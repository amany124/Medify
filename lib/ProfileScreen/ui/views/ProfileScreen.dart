import 'package:flutter/material.dart';
import 'package:medify/ProfileScreen/ui/widgets/ProfileAppbarContent.dart';
import 'package:medify/ProfileScreen/ui/widgets/ProfileTextField.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isEditing = false;

  final TextEditingController fullNameController =
      TextEditingController(text: "James Martin");
  final TextEditingController emailController =
      TextEditingController(text: "james012@gmail.com");
  final TextEditingController phoneController =
      TextEditingController(text: "1234567891");
  final TextEditingController bloodTypeController =
      TextEditingController(text: "A+");
  final TextEditingController heightController =
      TextEditingController(text: "170 cm");
  final TextEditingController weightController =
      TextEditingController(text: "70 kg");
  final TextEditingController dobController =
      TextEditingController(text: "01/01/1990");
  final TextEditingController genderController =
      TextEditingController(text: "Male");
  final TextEditingController chronicController =
      TextEditingController(text: "None");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              snap: false,
              elevation: 0,
              expandedHeight: 300,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/profile background2 png.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ProfileAppbarContent(),
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  },
                ),
              ],
            ),
          ];
        },
        // profile user info content
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight, // Ensure full height
                ),
                child: IntrinsicHeight(
                  // Adjust height properly
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ProfileTextField(
                            label: "Full Name",
                            controller: fullNameController,
                            icon: Icons.person,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Email",
                            controller: emailController,
                            icon: Icons.email,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Phone Number",
                            controller: phoneController,
                            icon: Icons.phone,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Blood Type",
                            controller: bloodTypeController,
                            icon: Icons.bloodtype,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Height",
                            controller: heightController,
                            icon: Icons.height,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Weight",
                            controller: weightController,
                            icon: Icons.monitor_weight,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Date of Birth",
                            controller: dobController,
                            icon: Icons.cake,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Gender",
                            controller: genderController,
                            icon: Icons.wc,
                            enabled: isEditing),
                        const Divider(),
                        ProfileTextField(
                            label: "Chronic Conditions",
                            controller: chronicController,
                            icon: Icons.medical_services,
                            enabled: isEditing),
                        const Spacer(),
                        if (isEditing)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                isEditing = false;
                              });
                            },
                            child: const Text("Save"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
