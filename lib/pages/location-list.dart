import 'package:flutter/material.dart';
import 'package:direction/global/global.dart';
import 'package:direction/widgets/button.dart';
import 'package:direction/hiveLocation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:direction/pages/adjust-location.dart';

class LocationList extends StatefulWidget {
  const LocationList({super.key});

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.only(
          right: space,
          left: space,
        ),
        height: MediaQuery.of(context).size.height * 0.5,
        child: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.onSecondary,
                Colors.transparent,
                Theme.of(context).colorScheme.onSecondary,
              ],
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstOut,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: boxLocations.length,
              itemBuilder: (context, index) {
                HiveLocation location = boxLocations.getAt(index);
                return Button(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('locationName', location.locationName);
                    prefs.setString('coordinates', location.coordiantes);
                    if (prefs.getString('headingText') == null) {
                      prefs.setString('locationNameTop', location.locationName);
                    }
                  },
                  margin: space * 0.5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          location.locationName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Button(
                        alignment: Alignment.centerRight,
                        color: Colors.transparent,
                        widthModifier: 0.2,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdjustLocation(
                                locationName: location.locationName,
                                coordinates: location.coordiantes,
                              ),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
