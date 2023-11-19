// To parse this JSON data, do
//
//     final asmaulHusna = asmaulHusnaFromJson(jsonString);

import 'dart:convert';

AsmaulHusna asmaulHusnaFromJson(List<int> str) => AsmaulHusna.fromJson(json.decode(utf8.decode(str)));

String asmaulHusnaToJson(AsmaulHusna data) => json.encode(data.toJson());

class AsmaulHusna {
    String creator;
    Result result;

    AsmaulHusna({
        required this.creator,
        required this.result,
    });

    factory AsmaulHusna.fromJson(Map<String, dynamic> json) => AsmaulHusna(
        creator: json["creator"],
        result: Result.fromJson(json["result"]),
    );

    Map<String, dynamic> toJson() => {
        "creator": creator,
        "result": result.toJson(),
    };
}

class Result {
    String number;
    String latin;
    String arab;
    String translateId;
    String translateEn;

    Result({
        required this.number,
        required this.latin,
        required this.arab,
        required this.translateId,
        required this.translateEn,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        number: json["number"],
        latin: json["latin"],
        arab: json["arab"],
        translateId: json["translate_id"],
        translateEn: json["translate_en"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "latin": latin,
        "arab": arab,
        "translate_id": translateId,
        "translate_en": translateEn,
    };
}
