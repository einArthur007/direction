import 'package:flutter/material.dart';
import 'package:direction/global/global.dart';
import 'package:direction/widgets/text-field.dart';

class AddLocation extends StatefulWidget {
  const AddLocation({
    super.key,
    required this.coordinatesIcon,
  });
  final Icon coordinatesIcon;

  @override
  State<AddLocation> createState() => _AddLocationState();
}

Icon coordinatesIcon = const Icon(Icons.location_on);
int emptyCounter = 1;

List locationList = [];

class _AddLocationState extends State<AddLocation> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(space),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldCostum(
                      controller: nameController,
                      suffixIcon: const Icon(Icons.person),
                      onChanged: () {},
                      hintText: 'add name',
                      labelText: 'name of location',
                      textInputType: TextInputType.name,
                    ),
                    TextFieldCostum(
                      controller: coordinatesController,
                      suffixIcon: coordinatesIcon,
                      onChanged: () {},
                      hintText: 'add coordinates',
                      labelText: 'coordinates',
                      textInputType: TextInputType.name,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
