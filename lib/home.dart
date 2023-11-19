import 'package:flutter/material.dart';
import 'package:hadisverse/article_all.dart';
import 'package:hadisverse/book_detail.dart';
import 'package:hadisverse/detail_article.dart';
import 'package:hadisverse/models/article_model.dart';
import 'package:hadisverse/models/asmaul_husna_model.dart';
import 'package:hadisverse/models/author_article_mode.dart';
import 'package:hadisverse/utils/constants.dart';
import 'package:hadisverse/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'models/image_article_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.selectBNB});

  final Function(int) selectBNB;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article>? dataArticle = null;
  AsmaulHusna? asmaulHusna = null;

  Future<void> getAsmaulHusna() async {
    final response = await http
        .get(Uri.parse('https://api.akuari.my.id/islami/asmaulhusna'));
    setState(() {
      asmaulHusna = asmaulHusnaFromJson(response.bodyBytes);
    });
  }

  Future<void> getArticle() async {
    final response = await http.get(Uri.parse(
        'https://hadisverse.rushd.id/wp-json/wp/v2/posts?per_page=3'));

    List<Article> newData = [];
    for (Article item in articleFromJson(response.bodyBytes)) {
      item.links.wpFeaturedmedia[0].href = item.links.wpFeaturedmedia[0].href ==
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
    getAsmaulHusna();
    getArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            asmaulHusna != null ? quotesSection(asmaulHusna!) : Container(),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 3,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Kitab",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.selectBNB(1);
                    },
                    child: const Text(
                      "Semua Kitab",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bookSection(context),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Artikel Terbaru",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArticleAllPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Semua Artikel",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            dataArticle != null
                ? articleSection(context, dataArticle!)
                : Container(),
          ],
        ),
      ),
    );
  }
}

Widget quotesSection(AsmaulHusna asmaulHusna) {
  return SizedBox(
    width: double.infinity,
    height: 200,
    child: Card(
      color: Colors.green,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              asmaulHusna.result.arab,
              style: const TextStyle(color: Colors.white, fontSize: 50),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              asmaulHusna.result.translateId,
              style: TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}

// Widget bookSection() {
//   return SingleChildScrollView(
//     scrollDirection: Axis.horizontal,
//     child: Row(
//       children: [
//         Card(
//           child: Column(
//             children: [
//               Image.asset('assets/book/shahih_bukhari.jpg', width: 90),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: const Text("Shahih Bukhari"),
//               )
//             ],
//           ),
//         ),
//         Card(
//           child: Column(
//             children: [
//               Image.asset('assets/book/shahih_bukhari.jpg', width: 90),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: const Text("Shahih Bukhari"),
//               )
//             ],
//           ),
//         ),
//         Card(
//           child: Column(
//             children: [
//               Image.asset('assets/book/shahih_bukhari.jpg', width: 90),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: const Text("Shahih Bukhari"),
//               )
//             ],
//           ),
//         ),
//         Card(
//           child: Column(
//             children: [
//               Image.asset('assets/book/shahih_bukhari.jpg', width: 90),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: const Text("Shahih Bukhari"),
//               )
//             ],
//           ),
//         ),
//         Card(
//           child: Column(
//             children: [
//               Image.asset('assets/book/shahih_bukhari.jpg', width: 90),
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: const Text("Shahih Bukhari"),
//               )
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

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

Widget bookSection(BuildContext context) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: books.take(6).map((item) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BookDetailPage(data: item),
              ),
            );
            print("KLIK ID : ${item}");
          },
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            child: Stack(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.only(top: 45),
                  elevation: 0,
                  color: Utils.getRandomColor(),
                  child: Container(
                    width: 180,
                    height: 150,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Kitab",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          child: Text(
                            item['id'].toString().replaceAll('_', ' '),
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 25,
                  child: Image.asset(
                    item['image'],
                    width: 80,
                    height: 120,
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    ),
  );
}
