import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:musicplayer_app/screens/settings/privacy_policy_popup.dart';
import 'package:musicplayer_app/screens/settings/terms_and_conditions.dart';
import 'package:quickalert/quickalert.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(247, 10, 11, 20),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)),
          backgroundColor: const Color.fromARGB(247, 10, 11, 20),
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              title: const Text(
                'About',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              onTap: () {
                showAboutDialog(
                    context: context,
                    applicationName: "Melophile",
                    applicationVersion: "1.0.1",
                    applicationIcon: CircleAvatar(
                      foregroundImage:
                          AssetImage('assets/fonts/images/songicon.jpg'),
                    ),
                    children: [
                      const Text(
                          "Melophile is an offline music player app which allows use to hear music from their local storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("App developed by Akhil Jose")
                    ]);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.description_outlined,
                color: Colors.white,
              ),
              title: const Text(
                'Terms and Conditions',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return TermsAndConditions(
                          mdFileName: 'terms_and_conditions.md');
                    });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.lock_outline,
                color: Colors.white,
              ),
              title: const Text(
                'Privacy Policy',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return PrivacyPolicy(mdFileName: 'privacy_policy.md');
                    });
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              title: const Text(
                'Exit App',
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
              onTap: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Alert!',
                  text: 'Do you want to Exit?',
                  showCancelBtn: true,
                  confirmBtnText: 'Exit',
                  onConfirmBtnTap: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop();
                    } else {
                      exit(0);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
