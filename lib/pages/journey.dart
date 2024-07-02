import 'package:flutter/material.dart';
import 'package:direction/global/global.dart';
import 'package:direction/widgets/background.dart';
import 'package:direction/widgets/container-default.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Journey extends StatefulWidget {
  const Journey({super.key});

  @override
  State<Journey> createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {
  String locationName = 'no location';
  String coordinates = 'no coordinates';

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locationName = prefs.getString('locationName') ?? 'no location';
    coordinates = prefs.getString('coordinates') ?? 'no coordinates';
    setState(() {});
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Padding(
            padding: EdgeInsets.all(space),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerD(
                          child: Text(
                            locationName,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                        ContainerD(
                          child: Text(
                            coordinates,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
