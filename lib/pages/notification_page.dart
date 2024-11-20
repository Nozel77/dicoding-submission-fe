import 'package:flutter/material.dart';
import '../utils/themes.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: bgButton,)
            ),

            Text('Notification', style: tsTextSemiBoldWhite),
          ],
        ),
        iconTheme: IconThemeData(color: primaryText),
      ),
      body: Center(
        child: Text('Notification Page', style: tsTextSemiBoldWhite,),
      ),
    );
  }
}
