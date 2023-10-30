import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth/login_signup.dart';

class OnBoardingScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            SizedBox(
              height: 50,
            ),

            Text("Welcome to SEOS!",style: TextStyle(
              color: Color(0xff0a064f),
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),),

            SizedBox(
              height: 5,
            ),

            Text("Sahara Event Organiser System",style: TextStyle(fontSize: 16),),

            SizedBox(
              height: 50,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Image.asset('assets/saharalogo.png'),
            ),

            SizedBox(
              height: 50,
            ),


            Expanded(
              child: Container(
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2
                      )
                    ],
                    borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [



                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Text("The social media platform designed for students to organize and arrange events",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xff0a064f),
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),),
                    ),



                    Padding(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Text("SEOS is an app where students of Sahara University can leverage their social network to create, discover, share, and monetize events or services within the university campus.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,

                        ),),
                    ),





                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                        right: 15
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        color: Color(0xff0a064f),
                        elevation: 2,
                        onPressed: (){
                          Get.to(()=> LoginView());
                          },

                        child: Text("Get Organizing",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                          ),),),
                    )

                  ],
                ),
              ),
            ),

          ],

        ),
      ),
    ));
  }
}
