import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hadisverse/models/article_model.dart';
import 'package:intl/intl.dart';

class DetailArticlePage extends StatefulWidget {
  const DetailArticlePage({super.key, required this.data});
  final Article data;

  @override
  State<DetailArticlePage> createState() => _DetailArticlePageState();
}

class _DetailArticlePageState extends State<DetailArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.data.title.rendered,
          style: TextStyle(color: Colors.green),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () async {
        //       Berita berita = Berita(
        //         berita_id: widget.data.id.toString(),
        //         title: widget.data.title.rendered,
        //         content: widget.data.toString(),
        //       );

        //       var res = await databaseHelper.insertBerita(berita);
        //       print("D : ${res}");
        //     },
        //     icon: const Icon(
        //       Icons.star_outline_rounded,
        //       color: Colors.black,
        //     ),
        //   )
        // ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(
                widget.data.title.rendered,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "By : ${widget.data.links.author[0].href}",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    DateFormat('dd MMM y').format(
                      DateTime.parse(
                        widget.data.date.toString(),
                      ),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Image.network(
                widget.data.links.wpFeaturedmedia[0].href,
                width: MediaQuery.of(context).size.width,
              ),
              Html(data: widget.data.content.rendered)
            ],
          ),
        ),
      ),
    );
  }
}
