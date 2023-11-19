import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hadisverse/models/book_detail_model.dart';
import 'package:http/http.dart' as http;

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key, required this.data, this.bookNumber = 0});

  final Map<String, dynamic> data;
  final int bookNumber;

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int bookNumber = 1;
  BookDetail? data = null;
  bool isLoading = true;

  bool isAyatVisible = true;
  bool isTranslateVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      bookNumber = widget.bookNumber == 0 ? 1 : widget.bookNumber;
    });
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(
      Uri.parse(
        'http://api.carihadis.com/?kitab=${widget.data['id']}&id=$bookNumber',
      ),
    );

    if (response.statusCode == 200) {
      if (json.decode(response.body)['data'].length > 0) {
        setState(() {
          data = bookDetailFromJson(response.bodyBytes);
          isLoading = false;
        });
      } else {
        setState(() {
          bookNumber -= 1;
          data = null;
          isLoading = false;
        });
      }
      print("DATA : ${json.decode(response.body)['data'].length}");
    } else {
      print("GAGAL : ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.data['id'].toString().replaceAll('_', ' ')} - $bookNumber',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
      ),
      body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: !isLoading
                    ? data != null
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isAyatVisible = !isAyatVisible;
                                      });
                                    },
                                    child: Text(
                                      isAyatVisible
                                          ? 'Sembunyikan teks arab'
                                          : 'Tampilkan teks arab',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                                isAyatVisible
                                    ? Html(
                                        data: data!.data.item.nass,
                                        style: {
                                          "body": Style(
                                            fontSize: const FontSize(
                                                26.0), // Ganti dengan ukuran font yang Anda inginkan
                                            direction: TextDirection.rtl,
                                            fontFamily: 'Poppins',
                                          )
                                        },
                                      )
                                    : Container(),
                                SizedBox(height: 20),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isTranslateVisible =
                                            !isTranslateVisible;
                                      });
                                    },
                                    child: Text(
                                      isTranslateVisible
                                          ? 'Sembunyikan terjemah'
                                          : 'Tampilkan terjemah',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                ),
                                data!.data.item.terjemah != ''
                                    ? isTranslateVisible
                                        ? Html(
                                            data: data!.data.item.terjemah,
                                            style: {
                                              "p": Style(
                                                fontSize: const FontSize(
                                                    20.0), // Ganti dengan ukuran font yang Anda inginkan
                                                textAlign: TextAlign.justify,
                                              ),
                                              "span": Style(
                                                fontSize: const FontSize(
                                                    20.0), // Ganti dengan ukuran font yang Anda inginkan
                                              )
                                            },
                                          )
                                        : Container()
                                    : const SizedBox(),
                              ],
                            ),
                          )
                        : Container()
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              widget.bookNumber == 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        bookNumber > 1
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () {
                                  if (bookNumber > 1) {
                                    setState(() {
                                      bookNumber -= 1;
                                    });
                                    getData();
                                  }
                                },
                                child: const Text("Previous"),
                              )
                            : Container(),
                        bookNumber > 1 ? SizedBox(width: 20) : Container(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              bookNumber += 1;
                            });
                            getData();
                          },
                          child: const Text("Next"),
                        ),
                      ],
                    )
                  : Container()
            ],
          )),
    );
  }
}
