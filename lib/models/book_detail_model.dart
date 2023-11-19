import 'dart:convert';

BookDetail bookDetailFromJson(List<int> str) =>
    BookDetail.fromJson(json.decode(utf8.decode(str)));

String bookDetailToJson(BookDetail data) => json.encode(data.toJson());

class BookDetail {
  Data data;

  BookDetail({
    required this.data,
  });

  factory BookDetail.fromJson(Map<String, dynamic> json) => BookDetail(
        data: json['data'] != [] ? Data.fromJson(json["data"]) : Data(item: Item(id: '0', nass: '0', terjemah: '0')),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Item item;

  Data({
    required this.item,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        item: Item.fromJson(json["1"]),
      );

  Map<String, dynamic> toJson() => {
        "1": item.toJson(),
      };
}

class Item {
  String id;
  String nass;
  String terjemah;

  Item({
    required this.id,
    required this.nass,
    required this.terjemah,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        nass: json["nass"],
        terjemah: json["terjemah"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nass": nass,
        "terjemah": terjemah,
      };
}
