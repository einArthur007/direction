import 'package:flutter/material.dart';
import 'package:direction/widgets/background.dart';
import 'package:direction/widgets/button.dart';
import 'package:direction/global/global.dart';
import 'package:direction/widgets/container-default.dart';
import 'package:direction/widgets/text-field.dart';
import 'package:direction/hiveLocation.dart';

class AdjustLocation extends StatelessWidget {
  const AdjustLocation({
    super.key,
    required this.locationName,
    required this.coordinates,
  });
  final String locationName;
  final String coordinates;

  @override
  Widget build(BuildContext context) {
    TextEditingController newLocationNameController = TextEditingController();
    TextEditingController newCoordinatesController = TextEditingController();
    TextEditingController newMessageController = TextEditingController();
    HiveLocation location = boxLocations.get(locationName);

    newLocationNameController.text = locationName;
    newCoordinatesController.text = coordinates;

    return Scaffold(
      body: Stack(
        children: [
          const Background(),
          Button(
            alignment: Alignment.topLeft,
            widthModifier: 0.15,
            heightModifier: 0.06,
            margin: space,
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          ContainerD(
            alignment: Alignment.topCenter,
            margin: space,
            widthModifier: 0.5,
            child: const Text('adjust location'),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                children: [
                  TextFieldCostum(
                    controller: newLocationNameController,
                    suffixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onChanged: () {},
                    hintText: 'new name',
                    labelText: location.locationName,
                    textInputType: TextInputType.name,
                  ),
                  TextFieldCostum(
                    controller: newCoordinatesController,
                    suffixIcon: Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onChanged: () {},
                    hintText: 'new coordinates',
                    labelText: location.coordiantes,
                    textInputType: TextInputType.name,
                  ),
                  TextFieldCostum(
                    controller: newMessageController,
                    suffixIcon: Icon(
                      Icons.message,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onChanged: () {
                      boxLocations.clear();
                    },
                    hintText: 'new message to ${location.locationName}',
                    labelText: 'TODO',
                    textInputType: TextInputType.name,
                  ),
                ],
              ),
            ),
          ),
          Button(
            alignment: Alignment.bottomCenter,
            margin: space * 2,
            color: Theme.of(context).colorScheme.onSecondary,
            onTap: () {
              boxLocations.put(
                newLocationNameController.text,
                HiveLocation(
                  locationName: newLocationNameController.text,
                  coordiantes: newCoordinatesController.text,
                ),
              );
              boxLocations.delete(locationName);
              if (newMessageController.text == 'clear') {
                boxLocations.clear();
              }
              newLocationNameController.text = '';
              newCoordinatesController.text = '';
              newMessageController.text = '';
              print(boxLocations.get(newLocationNameController.text));
              Navigator.pop(context);
            },
            child: Text(
              'save',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
