import 'package:flutter/material.dart';
import 'package:direction/location-service/location-controller.dart';
import 'package:direction/location-service/location-service.dart';
import 'package:get/get.dart';
import 'package:direction/widgets/background.dart';
import 'package:direction/widgets/container-default.dart';
import 'package:direction/widgets/button.dart';
import 'package:direction/global/global.dart';

class StartedJourney extends StatefulWidget {
  const StartedJourney({
    super.key,
    required this.locationName,
    required this.coordinates,
  });
  final String locationName;
  final String coordinates;

  @override
  State<StartedJourney> createState() => _StartedJourneyState();
}

class _StartedJourneyState extends State<StartedJourney> {
  @override
  void initState() {
    LocationService.instance.getLocation(controller: locationController);
    super.initState();
  }

  final LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Obx(
            () {
              return locationController.isAccessingLocation.value
                  ? Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircularProgressIndicator(),
                            Text('Finding Your Possition')
                          ],
                        ),
                      ),
                    )
                  : locationController.errorDescription.value.isNotEmpty ||
                          locationController.userLocation.value == null
                      ? Center(
                          child: Column(
                            children: [
                              Text(locationController.errorDescription.value),
                            ],
                          ),
                        )
                      : Stack(
                          children: [
// HEADING
                            ContainerD(
                              alignment: Alignment.topCenter,
                              heightModifier: 0.1,
                              margin: space,
                              borderRadiusV: borderRadius,
                              color: Theme.of(context).colorScheme.primary,
                              child: Text(
                                widget.locationName,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                              ),
                            ),
// LOCATION
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ContainerD(
                                      child: Text(
                                        'your location: ${locationController.userLocation.value?.latitude}° N, ${locationController.userLocation.value?.latitude}° E',
                                      ),
                                    ),
                                    ContainerD(
                                      child: Text(
                                        '${widget.locationName} location: ${widget.coordinates}',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
// CANCEL
                            Button(
                              alignment: Alignment.bottomCenter,
                              heightModifier: 0.1,
                              widthModifier: 0.6,
                              borderRadiusV: borderRadius * 0.25,
                              margin: space * 2,
                              color: Theme.of(context).colorScheme.onError,
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text('cancel journey'),
                            )
                          ],
                        );
            },
          ),
        ],
      ),
    );
  }
}
