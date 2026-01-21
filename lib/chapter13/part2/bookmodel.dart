class BookModel {
  VolumeInfo? volumeInfo;
  AccessInfo? accessInfo;
  SaleInfo? saleInfo;

  BookModel({
    this.volumeInfo,
    this.accessInfo,
    this.saleInfo,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      volumeInfo: json['volumeInfo'] != null
          ? VolumeInfo.fromJson(json['volumeInfo'])
          : null,
      accessInfo: json['accessInfo'] != null
          ? AccessInfo.fromJson(json['accessInfo'])
          : null,
      saleInfo:
          json['saleInfo'] != null ? SaleInfo.fromJson(json['saleInfo']) : null,
    );
  }
}

class VolumeInfo {
  String? title;
  String? subtitle;
  String? description;
  List<String>? authors;
  String? publisher;
  String? publishedDate;
  ImageLinks? imageLinks;

  VolumeInfo({
    this.title,
    this.subtitle,
    this.description,
    this.authors,
    this.publisher,
    this.publishedDate,
    this.imageLinks,
  });

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    return VolumeInfo(
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
      authors: (json['authors'] as List?)?.map((e) => e.toString()).toList(),
      publisher: json['publisher'],
      publishedDate: json['publishedDate'],
      imageLinks: json['imageLinks'] != null
          ? ImageLinks.fromJson(json['imageLinks'])
          : null,
    );
  }
}

class ImageLinks {
  String? smallThumbnail;
  String? thumbnail;

  ImageLinks({
    this.smallThumbnail,
    this.thumbnail,
  });

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      smallThumbnail: json['smallThumbnail'],
      thumbnail: json['thumbnail'],
    );
  }
}

class AccessInfo {
  String? webReaderLink;

  AccessInfo({this.webReaderLink});

  factory AccessInfo.fromJson(Map<String, dynamic> json) {
    return AccessInfo(
      webReaderLink: json['webReaderLink'],
    );
  }
}

class SaleInfo {
  String? saleability;
  String? buyLink;

  SaleInfo({
    this.saleability,
    this.buyLink,
  });

  factory SaleInfo.fromJson(Map<String, dynamic> json) {
    return SaleInfo(
      saleability: json['saleability'],
      buyLink: json['buyLink'],
    );
  }
}
