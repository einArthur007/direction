import 'package:flutter/material.dart';
import 'package:direction/global/global.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:direction/hiveLocation.dart';
import 'package:direction/widgets/bottombar.dart';
import 'package:direction/widgets/background.dart';
import 'package:flutter/services.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:direction/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:direction/widgets/container-default.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveLocationAdapter());
  boxLocations = await Hive.openBox<HiveLocation>('locations');
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          theme: ThemeData(
            colorScheme: lightDynamic,
            scaffoldBackgroundColor: const Color.fromARGB(255, 175, 175, 175),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: darkDynamic,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color.fromARGB(255, 50, 50, 50),
            useMaterial3: true,
          ),
          home: const Scaffold(
            body: BottomBar(),
          ),
        );
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
    required this.refresh,
  });
  final Widget refresh;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController searchController = TextEditingController();
  double heightModifier = 0.06;
  String locationName = '';
  String locationNameTop = '';
  String coordinates = '';
  String headingText = '';
  double heigthSetting = 0;
  double widthSetting = 0;
  Icon? iconSettings;

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locationName = prefs.getString('locationName') ?? 'No Location';
    locationNameTop = prefs.getString('locationNameTop') ?? 'No Location';
    coordinates = prefs.getString('coordinates') ?? 'No Coordinates';
    headingText = prefs.getString('headingText') ?? 'active route:';
  }

  @override
  Widget build(BuildContext context) {
    readData();
    return Stack(
      children: [
        const Background(),
        Align(
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: standardAnimationDuration,
            child: widget.refresh,
          ),
        ),
        Stack(
          children: [
// SET FAVOURITE
            ContainerD(
              alignment: Alignment.topCenter,
              margin: space * 1.75,
              borderRadiusV: borderRadius * 0.3,
              heightModifier: heigthSetting,
              widthModifier: widthSetting,
              color: Theme.of(context).colorScheme.onSecondary,
              child: Padding(
                padding: EdgeInsets.only(top: space * 2),
                child: Stack(
                  children: [
                    Button(
                      alignment: Alignment.centerRight,
                      color: Colors.transparent,
                      widthModifier: 0.15,
                      onTap: () {},
                      child: Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.secondary,
                        size: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: space),
                      child: Text(
                        'set favourite:',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    PageView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: boxLocations.length,
                      itemBuilder: (context, index) {
                        HiveLocation location = boxLocations.getAt(index);
                        return Button(
                          margin: space,
                          alignment: Alignment.bottomCenter,
                          widthModifier: 0.6,
                          onTap: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString(
                                'locationNameTop', location.locationName);
                            prefs.setString('headingText', 'favourite:');
                            setState(() {});
                          },
                          child: Text(location.locationName),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
// HEADING STYLE
            Button(
              alignment: Alignment.topCenter,
              margin: space * 2,
              heightModifier: 0.15,
              borderRadiusV: borderRadius * 0.25,
              color: Theme.of(context).colorScheme.primary,
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('locationName', locationName);
                prefs.setString('coordinates', coordinates);
                setState(() {});
              },
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: space,
                      top: space * 0.5,
                    ),
                    child: Text(
                      headingText,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Theme.of(context).colorScheme.onSecondary,
                      ),
                    ),
                  ),
// HEADING
                  Center(
                    child: Text(
                      locationNameTop,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: MediaQuery.of(context).size.width * 0.075,
                      ),
                    ),
                  ),
// ARROW DOWN
                  Button(
                    alignment: Alignment.bottomCenter,
                    color: Colors.transparent,
                    heightModifier: 0.05,
                    onTap: () {
                      if (heigthSetting == 0) {
                        heigthSetting = 0.32;
                        widthSetting = 1.25;
                        iconSettings = Icon(
                          Icons.arrow_drop_up_outlined,
                          color: Theme.of(context).colorScheme.surface,
                        );
                      } else {
                        heigthSetting = 0;
                        widthSetting = 1;
                        iconSettings = Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Theme.of(context).colorScheme.surface,
                        );
                      }
                      setState(() {});
                    },
                    child: iconSettings ??
                        Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Theme.of(context).colorScheme.onSecondary,
                          size: MediaQuery.of(context).size.width * 0.05,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
