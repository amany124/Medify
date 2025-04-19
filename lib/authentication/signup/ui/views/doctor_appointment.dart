import 'package:flutter/material.dart';


class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment ({super.key});

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
      "name": "Dr. Randy Wigham",
      "specialty": "General Medical Checkup",
      "rating": "4.8 ",
      "date": "Wed, 17 May | 08:30 AM",
      "image": "assets/images/doc.png"
    },
    {
      "name": "Dr. Jack Sulivan",
      "specialty": "General Medical Checkup",
      "rating": "4.8 ",
      "date": "Wed, 17 May | 08:30 AM",
      "image": "assets/images/doc.png"
    },
    {
      "name": "Drg. Hanna Stanton",
      "specialty": "General Medical Checkup",
      "rating": "4.8 ",
      "date": "Wed, 17 May | 08:30 AM",
      "image": "assets/images/doc.png"
    },
    {
      "name": "Dr. Emily Carter",
      "specialty": "Cardiologist",
      "rating": "4.9 ",
      "date": "Thu, 18 May | 10:00 AM",
      "image": "assets/images/doc.png"
    },
    {
      "name": "Dr. John Smith",
      "specialty": "Neurologist",
      "rating": "4.7 ",
      "date": "Fri, 19 May | 11:00 AM",
      "image": "assets/images/doc.png"
    },
    {
      "name": "Dr. John Smith",
      "specialty": "Neurologist",
      "rating": "4.7 ",
      "date": "Fri, 19 May | 11:00 AM",
      "image": "assets/images/doc.png"
    },
    {
      "name": "Dr. John Smith",
      "specialty": "Neurologist",
      "rating": "4.7 ",
      "date": "Fri, 19 May | 11:00 AM",
      "image": "assets/images/doc.png"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("My Appointment")),

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
                        if (status == "Cancelled") // ✅ إظهار رسالة الإلغاء
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
                          appointment["specialty"]!,
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 18),
                            SizedBox(width: 4),
                            Text(
                              appointment["rating"]!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Text(
                          appointment["date"]!,
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

