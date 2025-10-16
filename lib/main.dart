import 'package:TalkNest/auth/bloc/auth_bloc.dart';
import 'package:TalkNest/chat/bloc/chat_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:TalkNest/firebase_options.dart';
import 'package:TalkNest/utils/AppColors/colors.dart';
import 'package:TalkNest/utils/Strings/strings.dart';
import 'utils/Routes/appPages.dart';
import 'utils/Routes/appRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => ChatBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.title,
        initialRoute: AppRoutes.initial,
        routes: AppPages.routes,
        theme: ThemeData(
          primarySwatch: AppColors.navy,
        ),
      ),
    );
  }
}

/*
Flutter — Google Maps from scratch (single-file example)

What this file includes:
- Step-by-step setup notes (pubspec, Android/iOS API key placement)
- A working `main.dart` example using google_maps_flutter
- Requesting location permission and centering map on user
- Adding markers on tap, moving camera, simple polyline
- Toggling map type and a FAB to recenter

Dependencies (add to pubspec.yaml):
  google_maps_flutter: ^2.4.1
  geolocator: ^9.0.2
  permission_handler: ^10.2.0

Android setup (android/app/src/main/AndroidManifest.xml):
  <manifest ...>
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <application ...>
      <!-- Add your API key inside application tag -->
      <meta-data android:name="com.google.android.geo.API_KEY" android:value="YOUR_ANDROID_API_KEY"/>
    </application>
  </manifest>

iOS setup (ios/Runner/AppDelegate.swift or Info.plist):
- Add the API key in AppDelegate (Swift):
  import GoogleMaps
  // in didFinishLaunchingWithOptions:
  GMSServices.provideAPIKey("YOUR_IOS_API_KEY")

- Add location usage descriptions to Info.plist:
  NSLocationWhenInUseUsageDescription  - "We need your location to center the map"
  NSLocationAlwaysAndWhenInUseUsageDescription - optional

Notes:
- Replace the API keys above with the ones from Google Cloud Console (enable Maps SDK for Android/iOS).
- On Android Emulator, install Google Play images or use a real device.

----

Single-file example starts below. Copy this content into lib/main.dart.
*/
/* 
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps — From Scratch',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialCamera = CameraPosition(
    target: LatLng(20.5937, 78.9629), // Center of India as safe default
    zoom: 4.5,
  );

  MapType _currentMapType = MapType.normal;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  LatLng? _lastTapped;
  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _ensurePermissionsAndLocation();
  }

  Future<void> _ensurePermissionsAndLocation() async {
    // Request location permissions using permission_handler and Geolocator
    final status = await Permission.location.request();
    if (status.isDenied || status.isPermanentlyDenied) {
      // You might want to show a dialog directing user to app settings.
      return;
    }

    // Optionally check location service enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // You could prompt the user to enable location services.
      // For now we continue without current location.
      return;
    }

    // Get current position
    try {
      _currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _moveCameraToPosition(LatLng(_currentPosition!.latitude, _currentPosition!.longitude), zoom: 15);
      setState(() {});

      // Add a marker for current position
      final marker = Marker(
        markerId: const MarkerId('current_location'),
        position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        infoWindow: const InfoWindow(title: 'You are here'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      );

      _markers.add(marker);
    } catch (e) {
      // handle error
      debugPrint('Could not get location: $e');
    }
  }

  Future<void> _moveCameraToPosition(LatLng target, {double zoom = 14}) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: target, zoom: zoom)));
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onTap(LatLng tappedPoint) {
    setState(() {
      _lastTapped = tappedPoint;
      final markerId = MarkerId('marker_${_markers.length + 1}');
      _markers.add(
        Marker(
          markerId: markerId,
          position: tappedPoint,
          infoWindow: InfoWindow(title: 'Marker ${_markers.length + 1}', snippet: '${tappedPoint.latitude}, ${tappedPoint.longitude}'),
        ),
      );

      // If at least 2 markers, draw a polyline between last two
      if (_markers.length >= 2) {
        final pts = _markers.map((m) => m.position).toList();
        _polylines.clear();
        _polylines.add(Polyline(
          polylineId: const PolylineId('polyline_1'),
          points: pts,
          width: 4,
        ));
      }
    });
  }

  Future<void> _recenter() async {
    if (_currentPosition != null) {
      final target = LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
      await _moveCameraToPosition(target, zoom: 16);
    }
  }

  void _toggleMapType() {
    setState(() {
      _currentMapType = (_currentMapType == MapType.normal) ? MapType.satellite : MapType.normal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps — From Scratch'),
        actions: [
          IconButton(
            icon: const Icon(Icons.layers),
            onPressed: _toggleMapType,
            tooltip: 'Toggle map type',
          ),
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _recenter,
            tooltip: 'Recenter',
          ),
        ],
      ),
      body: GoogleMap(
        mapType: _currentMapType,
        initialCameraPosition: _initialCamera,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: _markers,
        polylines: _polylines,
        onTap: _onTap,
        compassEnabled: true,
        zoomControlsEnabled: false,
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'add_marker',
              onPressed: () async {
                // Add marker at center of map
                final controller = await _controller.future;
                final center = await controller.getLatLng(ScreenCoordinate(x: 200, y: 300));
                setState(() {
                  _markers.add(Marker(markerId: MarkerId('center_${_markers.length + 1}'), position: center));
                });
              },
              child: const Icon(Icons.add_location),
              tooltip: 'Add marker at center',
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'recenter',
              onPressed: _recenter,
              child: const Icon(Icons.my_location),
              tooltip: 'Center on current location',
            ),
          ],
        ),
      ),
    );
  }
}
 */