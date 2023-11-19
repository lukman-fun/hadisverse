import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hadisverse/book_detail.dart';
import 'package:hadisverse/models/hadith_search_model.dart';
import 'package:hadisverse/utils/constants.dart';
import 'package:hadisverse/utils/utils.dart';
import 'package:http/http.dart' as http;

class DetailSearchPage extends StatefulWidget {
  DetailSearchPage({super.key, required this.q});

  String q;

  @override
  State<DetailSearchPage> createState() => _DetailSearchPageState();
}

class _DetailSearchPageState extends State<DetailSearchPage> {
  HadithSearch? data = null;
  bool isLoading = true;

  Future<void> getBookByQuery() async {
    final response = await http.get(
      Uri.parse(
        'http://api.carihadis.com/?q=${widget.q}',
      ),
    );

    if (json.decode(response.body)['data'] != null) {
      setState(() {
        data = hadithSearchFromJson(response.body);
        isLoading = false;
      });
    } else {
      setState(() {
        data = null;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBookByQuery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.q,
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(15),
        child: !isLoading
            ? data != null
                ? SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: getBook(context, data!),
                    ),
                  )
                : Container()
            : Center(child: const CircularProgressIndicator()),
      ),
    );
  }
}

List<Widget> getBook(BuildContext context, HadithSearch data) {
  return data.data.map((item) {
    Color randomColor = Utils.getRandomColor();
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(top: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: randomColor,
                child: Container(
                  padding: const EdgeInsets.only(
                    left: 90,
                    top: 15,
                    right: 15,
                    bottom: 15,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Kitab ${item.kitab.replaceAll('_', ' ')}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 95,
                  top: 5,
                  right: 15,
                  bottom: 15,
                ),
                child: Wrap(
                  spacing: 15,
                  children: item.id.map((id) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: randomColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              data: {'id': item.kitab},
                              bookNumber: int.parse(id),
                            ),
                          ),
                        );
                      },
                      child: Text(id.toString()),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/book/shahih_bukhari.jpg',
              width: 80,
              height: 100,
            ),
          )
        ],
      ),
    );
  }).toList();
}
