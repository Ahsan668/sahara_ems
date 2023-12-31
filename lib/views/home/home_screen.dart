import 'package:sahara_ems/controller/data_controller.dart';
import 'package:sahara_ems/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../widgets/custom_app_bar.dart';
import '../../widgets/events_feed_widget.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.03),
      body: SafeArea(
        child: Column(
          children: [
            // Static Content
            CustomAppBar(),
            Text(
              "What's happening in Sahara today",
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventsFeed(),
                    Obx(() => dataController.isUsersLoading.value
                        ? Center(child: CircularProgressIndicator())
                        : EventsIJoined()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
