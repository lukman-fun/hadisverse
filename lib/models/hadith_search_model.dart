import 'dart:convert';

HadithSearch hadithSearchFromJson(String str) => HadithSearch.fromJson(json.decode(str));

String hadithSearchToJson(HadithSearch data) => json.encode(data.toJson());

class HadithSearch {
    List<Datum> data;

    HadithSearch({
        required this.data,
    });

    factory HadithSearch.fromJson(Map<String, dynamic> json) => HadithSearch(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String kitab;
    List<String> id;

    Datum({
        required this.kitab,
        required this.id,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        kitab: json["kitab"],
        id: List<String>.from(json["id"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "kitab": kitab,
        "id": List<dynamic>.from(id.map((x) => x)),
    };
}
