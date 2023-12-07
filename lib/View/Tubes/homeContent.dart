import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ugdlayout2/View/inputHotel.dart';
import 'package:ugdlayout2/entity/hotel.dart';
import 'package:ugdlayout2/database/login_database.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  late Future<List<Hotel>> popularHotels;

  final List<String> imgList = [
    'image/iklan1.png',
    'image/iklan2.png',
    'image/iklan3.png'
  ];

  @override
  void initState() {
    super.initState();
    popularHotels = HotelClient.fetchAll();
  }

  void _performSearch() {
    String searchTerm = _searchController.text;
    print('Performing search for: $searchTerm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Hotel', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      inputHotel(), 
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView(
      children: [
      //     ClipPath(
      //       clipper: BottomClipper(),
      //       child: Container(
      //         height: 150.0,
      //         color: Colors.grey[700],
      //         padding: EdgeInsets.all(8.0),
      //         child: Row(
      //           children: [
      //             Expanded(
      //               child: Container(
      //                 height: 40.0,
      //                 padding: EdgeInsets.symmetric(horizontal: 16.0),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(30.0),
      //                 ),
      //                 child: Row(
      //                   children: [
      //                     GestureDetector(
      //                       onTap: _performSearch,
      //                       child: Icon(Icons.search),
      //                     ),
      //                     SizedBox(width: 8.0),
      //                     Expanded(
      //                       child: TextField(
      //                         controller: _searchController,
      //                         decoration: InputDecoration(
      //                           hintText: 'Search',
      //                           border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
          SizedBox(width: 20.0),
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
              'Popular',
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
                    return HotelCard(hotel: hotel);
                  }).toList(),
                );
              }
            },
          ),
          Divider(
            color: const Color.fromARGB(255, 53, 53, 53),
            thickness: 1.0,
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

  const HotelCard({
    Key? key,
    required this.hotel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HotelDetailPage(hotel: hotel),
        //     ),
        //   );
        // },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                image: DecorationImage(
                  image: AssetImage('image/iklan1.png'),
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
                    Text(
                      hotel.nama,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
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
