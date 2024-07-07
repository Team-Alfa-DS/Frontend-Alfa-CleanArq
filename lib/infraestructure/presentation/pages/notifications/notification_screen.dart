import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/admin/adminHome.dart';
import 'package:alpha_gymnastic_center/infraestructure/presentation/pages/course/Course.dart';
import 'package:flutter/material.dart';

import '../../widgets/navegation.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  // Simulamos algunos datos de notificaciones
  final List<Map<String, String>> notifications = [
    // {
    //   'time': 'Today 9:47 AM',
    //   'message': 'How do I start doing yoga at home?',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'Today 9:47 AM',
    //   'message': 'What is the best time to do yoga?',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'Yesterday 8:30 PM',
    //   'message': 'Tips for improving your meditation practice',
    //   'status': 'Unseen',
    // },
    // {
    //   'time': 'Yesterday 5:42 PM',
    //   'message': 'New yoga classes available this weekend',
    //   'status': 'Unseen',
    // },
    // {
    //   'time': 'Yesterday 3:15 PM',
    //   'message': '5 poses to relieve back pain',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'Yesterday 1:00 PM',
    //   'message': 'Join our live webinar on mindfulness',
    //   'status': 'Unseen',
    // },
    // {
    //   'time': 'May 2, 10:24 AM',
    //   'message': 'How to maintain a healthy diet as a yogi',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'May 1, 9:00 AM',
    //   'message': 'Explore our new line of eco-friendly yoga mats',
    //   'status': 'Unseen',
    // },
    // {
    //   'time': 'April 30, 7:45 PM',
    //   'message': 'Weekly newsletter: Yoga poses for beginners',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'April 30, 7:45 PM',
    //   'message': 'Weekly newsletter: Yoga poses for beginners',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'April 30, 7:45 PM',
    //   'message': 'Weekly newsletter: Yoga poses for beginners',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'April 30, 7:45 PM',
    //   'message': 'Weekly newsletter: Yoga poses for beginners',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'April 30, 7:45 PM',
    //   'message': 'Weekly newsletter: Yoga poses for beginners',
    //   'status': 'Seen',
    // },
    // {
    //   'time': 'April 30, 7:45 PM',
    //   'message': 'Weekly newsletter: Yoga poses for beginners',
    //   'status': 'Seen',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YogaAppBar(title: "Notifications"),
      body: notifications.isEmpty
          ? buildNoNotifications(context)
          : buildNotificationsList(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 70.0,
        width: 70.0,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4F14A0), Color(0xFF8066FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Image.asset('assets/icons/rayo.png',
              color: Colors.white, width: 35.0, height: 35.0),
        ),
      ),
      bottomNavigationBar: const BarraNavegacion(),
    );
  }

  Widget buildNoNotifications(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 150,
            height: 170,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/notiBell.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            "Can't find notifications",
            style: TextStyle(
              fontSize: 18,
              //PT Sans
              fontFamily: 'PTSans',
              fontWeight: FontWeight.bold,
              color: Color(0xFF222222),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Let's explore more content around you.",
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF4F14A0),
                  Color(0xFF8066FF),
                ],
              ),
            ),
            child: TextButton(
              onPressed: () {
                //Navigator.pop(context);
                //Ruta para pasar a la pestaña de administrador, SOLO PARA PRUEBA
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminDashboardScreen()),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text(
                'Back to Feed',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNotificationsList(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          leading: const Icon(Icons.notifications),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notification['time'] ?? '',
                  style: const TextStyle(fontSize: 10)),
              Text(
                notification['title'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          subtitle: Text(notification['message'] ?? ''),
          trailing: Text(notification['status'] ?? ''),
        );
      },
    );
  }
}
