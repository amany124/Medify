import 'package:flutter/material.dart';

class PatientAppointment extends StatelessWidget {
  const PatientAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "My Appointment",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          bottom: TabBar(
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: "Upcoming"),
              Tab(text: "Completed"),
              Tab(text: "Cancelled"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AppointmentsList(status: "Upcoming"),
            AppointmentsList(status: "Completed"),
            AppointmentsList(status: "Cancelled"),
          ],
        ),
      ),
    );
  }
}


class AppointmentsList extends StatelessWidget {
  final String status;
  AppointmentsList({super.key, required this.status});

  final List<Map<String, String>> appointments = [
    {
      "name": " Ahmed Khaled",
      "phone": "+20 123 456 789",
      "date": "Wed, 17 May | 08:30 AM",
      "image": "assets/images/patient.jpg"
    },
    {
      "name": " Khaled Ali",
      "phone": "+20 987 654 321",
      "date": "Thu, 18 May | 10:00 AM",
      "image": "assets/images/patient.jpg"
    },
    {
      "name": "Karim Hassan",
      "phone": "+20 112 233 445",
      "date": "Fri, 19 May | 11:30 AM",
      "image": "assets/images/patient.jpg"
    },
    {
      "name": "Ali Mohamed",
      "phone": "+20 998 877 665",
      "date": "Sat, 20 May | 01:00 PM",
      "image": "assets/images/patient.jpg"
    },
    {
      "name": "Tamer Youssef",
      "phone": "+20 554 332 110",
      "date": "Sun, 21 May | 03:15 PM",
      "image": "assets/images/patient.jpg"
    },
     {
      "name": "Tamer Youssef",
      "phone": "+20 554 332 110",
      "date": "Sun, 21 May | 03:15 PM",
      "image": "assets/images/patient.jpg"
    },
     
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          final appointment = appointments[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            margin: EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      appointment["image"]!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (status == "Cancelled") // ✅ إظهار رسالة الإلغاء إذا كان الموعد ملغي
                          Text(
                            "Appointment cancelled",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        Text(
                          appointment["name"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          appointment["phone"]!,
                          style: TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                        Text(
                          appointment["date"]!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                  // IconButton(
                  //   icon: Icon(Icons.phone, color: Colors.blue),
                  //   onPressed: () {
                  //     // تنفيذ وظيفة الاتصال عند الضغط
                  //   },
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}