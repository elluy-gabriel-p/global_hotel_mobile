import 'package:flutter/material.dart';
import 'package:ugdlayout2/View/review/edit_review_page.dart';
import 'package:ugdlayout2/repository/booking_repository.dart';

class ReviewListPage extends StatefulWidget {
  const ReviewListPage({super.key});

  @override
  State<ReviewListPage> createState() => _ReviewListPageState();
}

class _ReviewListPageState extends State<ReviewListPage> {
  final BookingRepository bookingRepository = BookingRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("My Reviews")),
        body: FutureBuilder(
          future: bookingRepository.GetMyReview(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Card(
                  child: Column(
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          'https://source.unsplash.com/random/?room,hotel',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text("Nama: ${snapshot.data![index].username}"),
                      Text("TIpe Kamar: ${snapshot.data![index].tipe}"),
                      Text("Komentar: ${snapshot.data![index].komentar}"),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () async {
                                await bookingRepository.DeleteRoomReview(
                                    snapshot.data![index].id);
                                    setState(() {
                                      
                                    });
                              },
                              icon: Icon(Icons.delete)),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => EditReviewPage(
                                    id: snapshot.data![index].id,
                                    komentar: snapshot.data![index].komentar,
                                  ),
                                ))
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              icon: Icon(Icons.edit)),
                        ],
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
