import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ugdlayout2/database/review_database.dart';
import 'package:ugdlayout2/entity/review.dart';
import 'package:ugdlayout2/View/review/edit_review.dart';

class Homepage extends ConsumerWidget {
  Homepage({super.key});

  //provider untuk mengambil list data review dari API
  final listReviewProvider = FutureProvider<List<Review>>((ref) async {
    return await ReviewClient.fetchAll();
  });

  //aksi ketika floating button ditekan
  void onAdd(context, ref) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const EditReview())).then((value) => ref.refresh(
        listReviewProvider)); //refresh list data review ketika kembali ke halaman ini
  }

  //aksi ketika tombol delete ditekan
  void onDelete(id, context, ref) async {
    try {
      await ReviewClient.destroy(id); //hapus data review berdasarkan ID
      ref.refresh(listReviewProvider); //refresh list data review
      showSnackBar(context, "Delete Success", Colors.green);
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }

  //Widget untuk item dalam list
  ListTile scrollViewItem(Review b, context, ref) => ListTile(
      title: Text(b.nama),
      subtitle: Text(b.review),
      onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditReview(id: b.id)))
          .then((value) => ref.refresh(listReviewProvider)),
      trailing: IconButton(
          onPressed: () => onDelete(b.id, context, ref),
          icon: const Icon(Icons.delete)));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listener = ref.watch(listReviewProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('GD_API_1306'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => onAdd(context, ref),
      ),
      body: listener.when(
        data: (reviews) => SingleChildScrollView(
          child: Column(
            children: reviews
                .map((review) => scrollViewItem(review, context, ref))
                .toList(),
          ),
        ),
        error: (err, s) => Center(child: Text(err.toString())),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
          label: 'hide', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}
