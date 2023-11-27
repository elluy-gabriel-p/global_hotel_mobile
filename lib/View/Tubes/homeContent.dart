import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final TextEditingController _searchController = TextEditingController();
  int _current = 0;
  final CarouselController _controller = CarouselController();

  final List<String> imgList = [
    'image/advertise/iklan1.jpg',
    'image/advertise/iklan2.jpg',
    'image/advertise/iklan3.jpg'
  ];

  void _performSearch() {
    String searchTerm = _searchController.text;
    print('Performing search for: $searchTerm');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Global Hotel', style: TextStyle(color: Colors.black)),
        backgroundColor: Color.fromARGB(217, 217, 217, 217),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: BottomClipper(),
            child: Container(
              height: 150.0,
              color: Colors.grey[700],
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 40.0,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _performSearch,
                            child: Icon(Icons.search),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
          Container(
            height: 80.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'image/advertise/iklan1.jpg',
                          height: 80.0,
                          width: 147.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          width: 8.0), // Add spacing between image and text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hotel 1', // Replace with your actual text
                            style: TextStyle(
                              fontSize: 18.0, // Adjust the font size as needed
                              fontWeight: FontWeight.bold, // Make the text bold
                            ),
                          ),
                          SizedBox(
                              height:
                                  10.0), // Add spacing between text and additional text
                          Text(
                            'Lokesyong Hotelnya', // Replace with your actual additional text
                            style: TextStyle(
                              fontSize: 14.0, // Adjust the font size as needed
                            ),
                          ),
                          SizedBox(
                              height:
                                  10.0), // Add spacing between text and additional text
                          Text(
                            'Rp. 10000', // Replace with your actual additional text
                            style: TextStyle(
                              fontSize: 14.0, // Adjust the font size as needed
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: const Color.fromARGB(
                255, 53, 53, 53), // Set the color of the line
            thickness: 1.0, // Set the thickness of the line
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
