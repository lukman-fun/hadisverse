// To parse this JSON data, do
//
//     final jwt = jwtFromJson(jsonString);

import 'dart:convert';

Jwt jwtFromJson(String str) => Jwt.fromJson(json.decode(str));

String jwtToJson(Jwt data) => json.encode(data.toJson());

class Jwt {
    bool success;
    Data data;

    Jwt({
        required this.success,
        required this.data,
    });

    factory Jwt.fromJson(Map<String, dynamic> json) => Jwt(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    String jwt;

    Data({
        required this.jwt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        jwt: json["jwt"],
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
    };
}
