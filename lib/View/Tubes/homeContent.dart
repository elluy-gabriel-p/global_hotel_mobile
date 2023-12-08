import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ugdlayout2/View/Tubes/homeFix.dart';
import 'package:ugdlayout2/View/inputHotel.dart';
import 'package:ugdlayout2/entity/hotel.dart';
import 'package:ugdlayout2/database/login_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugdlayout2/entity/user.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  late Future<List<Hotel>> popularHotels;
  bool isAdmin = false;

  final List<String> imgList = [
    'image/iklan1.png',
    'image/iklan2.png',
    'image/iklan3.png'
  ];

  Future<void> loadUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int userId = prefs.getInt('userId') ?? 0;

      User res = await LoginClient.find(userId);

      setState(() {
        usernameController.text = res.username ?? '';
        isAdmin = res.username?.toLowerCase() == 'admin';
      });
    } catch (e) {
      print('Error loading user data : $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
    popularHotels = HotelClient.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Hotel', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
        automaticallyImplyLeading: false,
        actions: [
          if (isAdmin)
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputHotel(),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 30.0, bottom: 30.0),
            child: Text(
              'Hai, ${usernameController.text}',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 50.0),
          SingleChildScrollView(
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      onPageChanged: (index, carouselReason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: imgList
                      .map((item) => Container(
                            child: Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.asset(item,
                                          fit: BoxFit.cover, width: 1000.0),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ))
                      .toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Hotels',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder<List<Hotel>>(
            future: popularHotels,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No popular hotels available'));
              } else {
                print('Data: ${snapshot.data}');
                return Column(
                  children: snapshot.data!.map((hotel) {
                    return HotelCard(hotel: hotel, isAdmin: isAdmin);
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HotelCard extends StatelessWidget {
  final Hotel hotel;
  final bool isAdmin;

  const HotelCard({
    Key? key,
    required this.hotel,
    required this.isAdmin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: isAdmin
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InputHotel(
                        hotel: hotel), // Pass the hotel data to InputHotel
                  ),
                );
              }
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                image: DecorationImage(
                  image: AssetImage('image/hotel.jpg'),
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.center,
                ),
              ),
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotel.nama,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        if (isAdmin)
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _onDelete(context);
                            },
                          ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(hotel.alamat),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('RP. ${hotel.harga}/malam'),
                        SizedBox(width: 8),
                        Spacer(),
                        Row(
                          children: [
                            Text('${hotel.rating}'),
                            Icon(Icons.star,
                                color: Color.fromARGB(255, 255, 236, 66)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onDelete(BuildContext context) async {
    try {
      print("A");
      await HotelClient.destroy(hotel.id!);
      print("AA");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Delete Success'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeFix()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class HotelDetailPage extends StatelessWidget {
  final Hotel hotel;

  const HotelDetailPage({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hotel.nama),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text('Harga: RP ${hotel.harga}'),
            // Text('Rating: ${hotel.rating}'),
            // Text('Deskripsi: ${hotel.deskripsi}'),
          ],
        ),
      ),
    );
  }
}
