import 'package:flutter/material.dart';
import 'package:med_sync/presentation/widgets/custom_appbar.dart';
import 'package:med_sync/presentation/widgets/custom_text.dart';

class GoogleSignin extends StatelessWidget {
  const GoogleSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: [
          
          SizedBox(height: 40),
        
             PrimaryHeading('Continue with Google!'),
        
        
        
        
        ]
        
        
        ),
      )),
    );
  }
}
