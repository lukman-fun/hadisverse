import 'package:flutter/material.dart';
import 'package:hadisverse/detail_article.dart';
import 'package:hadisverse/models/article_model.dart';
import 'package:hadisverse/models/author_article_mode.dart';
import 'package:hadisverse/models/image_article_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class ArticleAllPage extends StatefulWidget {
  const ArticleAllPage({super.key});

  @override
  State<ArticleAllPage> createState() => _ArticleAllPageState();
}

class _ArticleAllPageState extends State<ArticleAllPage> {
  List<Article>? dataArticle = null;

  Future<void> getArticle() async {
    final response = await http
        .get(Uri.parse('https://hadisverse.rushd.id/wp-json/wp/v2/posts'));

    List<Article> newData = [];
    for (Article item in articleFromJson(response.bodyBytes)) {
      item.links.wpFeaturedmedia[0].href = item
          .links.wpFeaturedmedia[0].href = item.links.wpFeaturedmedia[0].href ==
              ''
          ? 'https://i0.wp.com/kubalubra.is/wp-content/uploads/2017/11/default-thumbnail.jpg?ssl=1'
          : await getImageArticle(item.links.wpFeaturedmedia[0].href);
      item.links.author[0].href =
          await getAuthorArticle(item.links.author[0].href);
      newData.add(item);
    }

    setState(() {
      dataArticle = newData;
    });

    print(dataArticle![0].links.wpFeaturedmedia[0].toJson());
  }

  Future<String> getImageArticle(String uri) async {
    final response = await http.get(Uri.parse(uri));
    return imageArticleFromJson(response.body).sourceUrl.toString();
  }

  Future<String> getAuthorArticle(String uri) async {
    final response = await http.get(Uri.parse(uri));
    return authorArticleFromJson(response.body).name.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Semua Artikel',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: dataArticle != null
              ? articleSection(context, dataArticle!)
              : Container(),
        ),
      ),
    );
  }
}

Widget articleSection(BuildContext context, List<Article> data) {
  return Column(
    children: data.map(
      (item) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailArticlePage(data: item),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                width: double.infinity,
                height: 200,
                child: Stack(
                  children: [
                    Image.network(
                      item.links.wpFeaturedmedia[0].href,
                      // 'https://hadisverse.rushd.id/wp-content/uploads/2023/08/pexels-pixabay-460680-930x620.jpg',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black, Colors.transparent],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title.rendered.toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "By : ${item.links.author[0].href}",
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  DateFormat('dd MMM y').format(
                                    DateTime.parse(
                                      item.date.toString(),
                                    ),
                                  ),
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).toList(),
  );
}
