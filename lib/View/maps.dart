import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Position? _position;

  void _getCurrentLocation() async {
    Position position = await _askPermission();

    setState(() {
      _position = position;
    });
  }

  Future<Position> _askPermission() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MAPS"),
        leading: IconButton(
           icon: Icon(Icons.arrow_back), // Ikon panah ke belakang
             onPressed: () {
             Navigator.of(context).pop(); // Pergi kembali ke halaman sebelumnya
           },
      )),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * (1),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  _position != null
                      ? FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(
                                _position!.latitude, _position!.longitude),
                            initialZoom: 15,
                          ),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayer(markers: [
                              Marker(
                                point: LatLng(
                                    _position!.latitude, _position!.longitude),
                                child: Icon(
                                  Icons.person_pin_circle,
                                  color: Colors.blue,
                                  size: 50,
                                ),
                              ),
                              Marker(
                                point: LatLng(-7.7524801, 110.4910196),
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.green,
                                  size: 36,
                                ),
                              ),
                              Marker(
                                point: LatLng(-7.7788882, 110.4153298),
                                child: Icon(
                                  Icons.pin_drop,
                                  color: Colors.green,
                                  size: 36,
                                ),
                              ),
                            ])
                          ],
                        )
                      : Center(child: CircularProgressIndicator()),
                ],
              ),
            )),
      ),
    );
  }
}
