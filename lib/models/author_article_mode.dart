// To parse this JSON data, do
//
//     final authorArticle = authorArticleFromJson(jsonString);

import 'dart:convert';

AuthorArticle authorArticleFromJson(String str) => AuthorArticle.fromJson(json.decode(str));

String authorArticleToJson(AuthorArticle data) => json.encode(data.toJson());

class AuthorArticle {
    int id;
    String name;
    String url;
    String description;
    String link;
    String slug;
    Map<String, String> avatarUrls;

    AuthorArticle({
        required this.id,
        required this.name,
        required this.url,
        required this.description,
        required this.link,
        required this.slug,
        required this.avatarUrls,
    });

    factory AuthorArticle.fromJson(Map<String, dynamic> json) => AuthorArticle(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        description: json["description"],
        link: json["link"],
        slug: json["slug"],
        avatarUrls: Map.from(json["avatar_urls"]).map((k, v) => MapEntry<String, String>(k, v)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "description": description,
        "link": link,
        "slug": slug,
        "avatar_urls": Map.from(avatarUrls).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
