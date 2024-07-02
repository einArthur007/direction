import 'package:hive/hive.dart';

part 'hiveLocation.g.dart';

@HiveType(typeId: 1)
class HiveLocation {
  HiveLocation({
    required this.locationName,
    required this.coordiantes,
  });
  @HiveField(0)
  String locationName;

  @HiveField(1)
  String coordiantes;
}
