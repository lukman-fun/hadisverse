// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    bool success;
    Data data;

    User({
        required this.success,
        required this.data,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    UserClass user;
    List<String> roles;
    List<Jwt> jwt;

    Data({
        required this.user,
        required this.roles,
        required this.jwt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: UserClass.fromJson(json["user"]),
        roles: List<String>.from(json["roles"].map((x) => x)),
        jwt: List<Jwt>.from(json["jwt"].map((x) => Jwt.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "jwt": List<dynamic>.from(jwt.map((x) => x.toJson())),
    };
}

class Jwt {
    String token;
    Header header;
    Payload payload;
    int expireIn;

    Jwt({
        required this.token,
        required this.header,
        required this.payload,
        required this.expireIn,
    });

    factory Jwt.fromJson(Map<String, dynamic> json) => Jwt(
        token: json["token"],
        header: Header.fromJson(json["header"]),
        payload: Payload.fromJson(json["payload"]),
        expireIn: json["expire_in"],
    );

    Map<String, dynamic> toJson() => {
        "token": token,
        "header": header.toJson(),
        "payload": payload.toJson(),
        "expire_in": expireIn,
    };
}

class Header {
    String typ;
    String alg;

    Header({
        required this.typ,
        required this.alg,
    });

    factory Header.fromJson(Map<String, dynamic> json) => Header(
        typ: json["typ"],
        alg: json["alg"],
    );

    Map<String, dynamic> toJson() => {
        "typ": typ,
        "alg": alg,
    };
}

class Payload {
    int iat;
    int exp;
    String email;
    String id;
    String site;
    String username;

    Payload({
        required this.iat,
        required this.exp,
        required this.email,
        required this.id,
        required this.site,
        required this.username,
    });

    factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        iat: json["iat"],
        exp: json["exp"],
        email: json["email"],
        id: json["id"],
        site: json["site"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "iat": iat,
        "exp": exp,
        "email": email,
        "id": id,
        "site": site,
        "username": username,
    };
}

class UserClass {
    String id;
    String userLogin;
    String userNicename;
    String userEmail;
    String userUrl;
    DateTime userRegistered;
    String userActivationKey;
    String userStatus;
    String displayName;

    UserClass({
        required this.id,
        required this.userLogin,
        required this.userNicename,
        required this.userEmail,
        required this.userUrl,
        required this.userRegistered,
        required this.userActivationKey,
        required this.userStatus,
        required this.displayName,
    });

    factory UserClass.fromJson(Map<String, dynamic> json) => UserClass(
        id: json["ID"],
        userLogin: json["user_login"],
        userNicename: json["user_nicename"],
        userEmail: json["user_email"],
        userUrl: json["user_url"],
        userRegistered: DateTime.parse(json["user_registered"]),
        userActivationKey: json["user_activation_key"],
        userStatus: json["user_status"],
        displayName: json["display_name"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "user_login": userLogin,
        "user_nicename": userNicename,
        "user_email": userEmail,
        "user_url": userUrl,
        "user_registered": userRegistered.toIso8601String(),
        "user_activation_key": userActivationKey,
        "user_status": userStatus,
        "display_name": displayName,
    };
}
