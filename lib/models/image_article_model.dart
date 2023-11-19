// To parse this JSON data, do
//
//     final imageArticle = imageArticleFromJson(jsonString);

import 'dart:convert';

ImageArticle imageArticleFromJson(String str) =>
    ImageArticle.fromJson(json.decode(str));

String imageArticleToJson(ImageArticle data) => json.encode(data.toJson());

class ImageArticle {
  int id;
  DateTime date;
  DateTime dateGmt;
  Caption guid;
  DateTime modified;
  DateTime modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Caption title;
  int author;
  String commentStatus;
  String pingStatus;
  String template;
  Meta meta;
  Caption description;
  Caption caption;
  String altText;
  String mediaType;
  String mimeType;
  MediaDetails mediaDetails;
  int post;
  String sourceUrl;
  Links links;

  ImageArticle({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.author,
    required this.commentStatus,
    required this.pingStatus,
    required this.template,
    required this.meta,
    required this.description,
    required this.caption,
    required this.altText,
    required this.mediaType,
    required this.mimeType,
    required this.mediaDetails,
    required this.post,
    required this.sourceUrl,
    required this.links,
  });

  factory ImageArticle.fromJson(Map<String, dynamic> json) => ImageArticle(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        dateGmt: DateTime.parse(json["date_gmt"]),
        guid: Caption.fromJson(json["guid"]),
        modified: DateTime.parse(json["modified"]),
        modifiedGmt: DateTime.parse(json["modified_gmt"]),
        slug: json["slug"],
        status: json["status"],
        type: json["type"],
        link: json["link"],
        title: Caption.fromJson(json["title"]),
        author: json["author"],
        commentStatus: json["comment_status"],
        pingStatus: json["ping_status"],
        template: json["template"],
        meta: Meta.fromJson(json["meta"]),
        description: Caption.fromJson(json["description"]),
        caption: Caption.fromJson(json["caption"]),
        altText: json["alt_text"],
        mediaType: json["media_type"],
        mimeType: json["mime_type"],
        mediaDetails: MediaDetails.fromJson(json["media_details"]),
        post: json["post"],
        sourceUrl: json["source_url"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date": date.toIso8601String(),
        "date_gmt": dateGmt.toIso8601String(),
        "guid": guid.toJson(),
        "modified": modified.toIso8601String(),
        "modified_gmt": modifiedGmt.toIso8601String(),
        "slug": slug,
        "status": status,
        "type": type,
        "link": link,
        "title": title.toJson(),
        "author": author,
        "comment_status": commentStatus,
        "ping_status": pingStatus,
        "template": template,
        "meta": meta.toJson(),
        "description": description.toJson(),
        "caption": caption.toJson(),
        "alt_text": altText,
        "media_type": mediaType,
        "mime_type": mimeType,
        "media_details": mediaDetails.toJson(),
        "post": post,
        "source_url": sourceUrl,
        "_links": links.toJson(),
      };
}

class Caption {
  String rendered;

  Caption({
    required this.rendered,
  });

  factory Caption.fromJson(Map<String, dynamic> json) => Caption(
        rendered: json["rendered"],
      );

  Map<String, dynamic> toJson() => {
        "rendered": rendered,
      };
}

class Links {
  List<About> self;
  List<About> collection;
  List<About> about;
  List<Author> author;
  List<Author> replies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<About>.from(json["self"].map((x) => About.fromJson(x))),
        collection:
            List<About>.from(json["collection"].map((x) => About.fromJson(x))),
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        author:
            List<Author>.from(json["author"].map((x) => Author.fromJson(x))),
        replies:
            List<Author>.from(json["replies"].map((x) => Author.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "author": List<dynamic>.from(author.map((x) => x.toJson())),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class About {
  String href;

  About({
    required this.href,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Author {
  bool embeddable;
  String href;

  Author({
    required this.embeddable,
    required this.href,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        embeddable: json["embeddable"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "embeddable": embeddable,
        "href": href,
      };
}

class MediaDetails {
  int width;
  int height;
  String file;
  int filesize;
  ImageMeta imageMeta;

  MediaDetails({
    required this.width,
    required this.height,
    required this.file,
    required this.filesize,
    required this.imageMeta,
  });

  factory MediaDetails.fromJson(Map<String, dynamic> json) => MediaDetails(
        width: json["width"],
        height: json["height"],
        file: json["file"],
        filesize: json["filesize"],
        imageMeta: ImageMeta.fromJson(json["image_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "width": width,
        "height": height,
        "file": file,
        "filesize": filesize,
        "image_meta": imageMeta.toJson(),
      };
}

class ImageMeta {
  String aperture;
  String credit;
  String camera;
  String caption;
  String createdTimestamp;
  String copyright;
  String focalLength;
  String iso;
  String shutterSpeed;
  String title;
  String orientation;
  List<dynamic> keywords;

  ImageMeta({
    required this.aperture,
    required this.credit,
    required this.camera,
    required this.caption,
    required this.createdTimestamp,
    required this.copyright,
    required this.focalLength,
    required this.iso,
    required this.shutterSpeed,
    required this.title,
    required this.orientation,
    required this.keywords,
  });

  factory ImageMeta.fromJson(Map<String, dynamic> json) => ImageMeta(
        aperture: json["aperture"],
        credit: json["credit"],
        camera: json["camera"],
        caption: json["caption"],
        createdTimestamp: json["created_timestamp"],
        copyright: json["copyright"],
        focalLength: json["focal_length"],
        iso: json["iso"],
        shutterSpeed: json["shutter_speed"],
        title: json["title"],
        orientation: json["orientation"],
        keywords: List<dynamic>.from(json["keywords"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "aperture": aperture,
        "credit": credit,
        "camera": camera,
        "caption": caption,
        "created_timestamp": createdTimestamp,
        "copyright": copyright,
        "focal_length": focalLength,
        "iso": iso,
        "shutter_speed": shutterSpeed,
        "title": title,
        "orientation": orientation,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
      };
}

class Meta {
  String neveMetaSidebar;
  String neveMetaContainer;
  String neveMetaEnableContentWidth;
  int neveMetaContentWidth;
  String neveMetaTitleAlignment;
  String neveMetaAuthorAvatar;
  String nevePostElementsOrder;
  String neveMetaDisableHeader;
  String neveMetaDisableFooter;
  String neveMetaDisableTitle;

  Meta({
    required this.neveMetaSidebar,
    required this.neveMetaContainer,
    required this.neveMetaEnableContentWidth,
    required this.neveMetaContentWidth,
    required this.neveMetaTitleAlignment,
    required this.neveMetaAuthorAvatar,
    required this.nevePostElementsOrder,
    required this.neveMetaDisableHeader,
    required this.neveMetaDisableFooter,
    required this.neveMetaDisableTitle,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        neveMetaSidebar: json["neve_meta_sidebar"],
        neveMetaContainer: json["neve_meta_container"],
        neveMetaEnableContentWidth: json["neve_meta_enable_content_width"],
        neveMetaContentWidth: json["neve_meta_content_width"],
        neveMetaTitleAlignment: json["neve_meta_title_alignment"],
        neveMetaAuthorAvatar: json["neve_meta_author_avatar"],
        nevePostElementsOrder: json["neve_post_elements_order"],
        neveMetaDisableHeader: json["neve_meta_disable_header"],
        neveMetaDisableFooter: json["neve_meta_disable_footer"],
        neveMetaDisableTitle: json["neve_meta_disable_title"],
      );

  Map<String, dynamic> toJson() => {
        "neve_meta_sidebar": neveMetaSidebar,
        "neve_meta_container": neveMetaContainer,
        "neve_meta_enable_content_width": neveMetaEnableContentWidth,
        "neve_meta_content_width": neveMetaContentWidth,
        "neve_meta_title_alignment": neveMetaTitleAlignment,
        "neve_meta_author_avatar": neveMetaAuthorAvatar,
        "neve_post_elements_order": nevePostElementsOrder,
        "neve_meta_disable_header": neveMetaDisableHeader,
        "neve_meta_disable_footer": neveMetaDisableFooter,
        "neve_meta_disable_title": neveMetaDisableTitle,
      };
}
