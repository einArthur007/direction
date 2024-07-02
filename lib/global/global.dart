// IMPORTS

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:url_launcher/url_launcher.dart';

// DESIGN

double borderRadius = 100;
double space = 20;

String telephonenumber = '+491603767575';

Duration standardAnimationDuration = const Duration(milliseconds: 300);

late Box boxLocations;

TextEditingController nameController = TextEditingController();
TextEditingController coordinatesController = TextEditingController();

// FUNCTION

void sendWhatsapp() {
  String whatsappurl = 'whatsapp://send?$telephonenumber';
  launchUrl(Uri.parse(whatsappurl));
}
