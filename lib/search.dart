import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hadisverse/book_detail.dart';
import 'package:hadisverse/detail_search.dart';
import 'package:hadisverse/models/hadith_search_model.dart';
import 'package:hadisverse/utils/constants.dart';
import 'package:hadisverse/utils/utils.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: EdgeInsets.only(left: 16, right: 0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 235, 235), // Background putih
              borderRadius: BorderRadius.circular(8.0), // Sudut 8
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    cursorColor: Colors.grey,
                    controller: _searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Cari hadis disini...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailSearchPage(q: _searchController.value.text),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Jumlah kolom
                // childAspectRatio: 1.0, // Rasio lebar-tinggi item
                mainAxisSpacing: 15,
                crossAxisSpacing: 5,
              ),
              itemCount: books.length, // Jumlah item dalam grid
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            BookDetailPage(data: books[index]),
                      ),
                    );
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
                                  height: 50,
                                  child: Text(
                                    books[index]['id']
                                        .toString()
                                        .replaceAll('_', ' '),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
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
                            books[index]['image'],
                            width: 80,
                            height: 120,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
