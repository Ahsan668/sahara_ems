import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../utils/app_color.dart';
import '../views/notification_screen/notification_screen.dart';
import 'my_widgets.dart';
// Make sure to import the required packages, including your AuthController and other dependencies.

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Container(
            width: 200,
            height: 35,
            child: myText(
                text: ' SEOS',
                style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 30)),
          ),
          Spacer(),
          Container(
            width: 24,
            height: 22,
            child: InkWell(
              onTap: () {
                Get.to(() => UserNotificationScreen());
              },
              child: Image.asset(
                'assets/Frame.png',
                height: 50,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.04,
          ),
          PopupMenuButton<String>(
            icon: Image.asset(
              'assets/menu.png',
              fit: BoxFit.contain,
              width: 30,
            ),
            iconSize: 10,
            onSelected: (value) {
              if (value == 'Logout') {
                AuthController authController = Get.find();
                authController.logout();
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}