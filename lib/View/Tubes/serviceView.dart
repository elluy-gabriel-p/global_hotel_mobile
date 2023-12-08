import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({Key? key}) : super(key: key);

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
        automaticallyImplyLeading: false,
      ),
    );
  }
}
