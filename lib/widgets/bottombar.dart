import 'package:direction/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:direction/main.dart';
import 'package:direction/pages/add-location.dart';
import 'package:direction/pages/journey.dart';
import 'package:direction/pages/location-list.dart';
import 'package:direction/global/global.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:direction/hiveLocation.dart';
import 'package:direction/pages/started-journey.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Widget refresh = const LocationList();
  Alignment align = Alignment.bottomCenter;
  String locationName = nameController.text;
  String coordinates = coordinatesController.text;
  final controller = PageController(
    initialPage: 1,
  );

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locationName = prefs.getString('locationName') ?? 'choose a route';
    coordinates = prefs.getString('coordinates') ?? 'choose a route';
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> bottomIcons = [
      {
        'label': 'add location',
        'icon': Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        'indexLine': Alignment.bottomLeft,
        'prefixIcon': null,
        'suffixIcon': Icon(
          Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        'onTap': () async {
          if (coordinatesController.text != '') {
            SharedPreferences prefs = await SharedPreferences.getInstance();
// CREATE EMPTY NAME
            if (nameController.text == '') {
              nameController.text = 'empty$emptyCounter';
              emptyCounter++;
              prefs.setInt('emptyCounter', emptyCounter);
            }
// ADD LOCATION
            boxLocations.put(
              nameController.text,
              HiveLocation(
                locationName: nameController.text,
                coordiantes: coordinatesController.text,
              ),
            );
            nameController.text = '';
            coordinatesController.text = '';
          }
        },
      },
      {
        'label': 'locations',
        'icon': Icon(
          Icons.location_on,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        'indexLine': Alignment.bottomCenter,
        'prefixIcon': Icon(
          Icons.arrow_back_ios_rounded,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        'suffixIcon': Icon(
          Icons.arrow_forward_ios_rounded,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        'onTap': () {},
      },
      {
        'label': 'start route',
        'icon': Icon(
          Icons.route,
          color: Theme.of(context).colorScheme.onSurface,
        ),
        'indexLine': Alignment.bottomRight,
        'prefixIcon': Icon(
          Icons.arrow_back_ios_rounded,
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        'suffixIcon': null,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StartedJourney(
                locationName: locationName,
                coordinates: coordinates,
              ),
            ),
          );
        },
      },
    ];

    readData();

    return Stack(
      children: [
        Home(
          refresh: refresh,
        ),
        Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: space),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: Stack(
              children: [
                PageView(
                  controller: controller,
                  onPageChanged: (value) {
// CHANGE CONTENT
                    if (value == 0) {
                      align = Alignment.bottomLeft;
                      refresh = AddLocation(
                        coordinatesIcon: coordinatesIcon,
                      );
                    }
                    if (value == 1) {
                      align = Alignment.bottomCenter;
                      refresh = const LocationList();
                    }
                    if (value == 2) {
                      align = Alignment.bottomRight;
                      refresh = const Journey();
                    }
                    setState(() {});
                  },
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ...bottomIcons.map(
                      (e) => Row(
                        children: [
// SPACING
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: e['prefixIcon'],
                          ),
// BODY
                          Button(
                            heightModifier: 0.2,
                            borderRadiusV: borderRadius * 0.25,
                            onTap: () {
                              e['onTap']();
                              setState(() {});
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                e['icon'],
                                Text(
                                  e['label'],
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
// SPACING
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: e['suffixIcon'],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
// SLIDER
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: EdgeInsets.only(
                    right: space,
                    left: space,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: AnimatedAlign(
                    alignment: align,
                    duration: standardAnimationDuration,
                    child: Container(
                      height: 3,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
