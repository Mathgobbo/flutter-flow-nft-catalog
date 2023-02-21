import 'package:flutter/material.dart';

class NFTCatalogMetadata {
  String? contractName;
  String? contractAddress;
  NFTType? nftType;
  CollectionDisplay? collectionDisplay;
  CollectionData? collectionData;

  NFTCatalogMetadata(
      {this.contractAddress,
      this.contractName,
      this.nftType,
      this.collectionDisplay,
      this.collectionData});

  NFTCatalogMetadata.fromJson(Map json) {
    contractAddress = json["contractAddress"];
    contractName = json["contractName"];
    collectionDisplay = json['collectionDisplay'] != null
        ? CollectionDisplay.fromJson(json['collectionDisplay'])
        : null;
    collectionData = json['collectionData'] != null
        ? CollectionData.fromJson(json['collectionData'])
        : null;
    nftType =
        json['nftType'] != null ? NFTType.fromJson(json['nftType']) : null;
  }
}

class CollectionDisplay {
  String? name;
  BannerImage? bannerImage;
  String? description;
  File? externalURL;
  BannerImage? squareImage;
  Socials? socials;

  CollectionDisplay(
      {this.name,
      this.bannerImage,
      this.description,
      this.externalURL,
      this.squareImage,
      this.socials});

  CollectionDisplay.fromJson(Map json) {
    name = json['name'];
    bannerImage = json['bannerImage'] != null
        ? new BannerImage.fromJson(json['bannerImage'])
        : null;
    description = json['description'];
    externalURL = json['externalURL'] != null
        ? new File.fromJson(json['externalURL'])
        : null;
    squareImage = json['squareImage'] != null
        ? new BannerImage.fromJson(json['squareImage'])
        : null;
    socials =
        json['socials'] != null ? new Socials.fromJson(json['socials']) : null;
  }

  Map toJson() {
    final Map data = new Map();
    data['name'] = this.name;
    if (this.bannerImage != null) {
      data['bannerImage'] = this.bannerImage!.toJson();
    }
    data['description'] = this.description;
    if (this.externalURL != null) {
      data['externalURL'] = this.externalURL!.toJson();
    }
    if (this.squareImage != null) {
      data['squareImage'] = this.squareImage!.toJson();
    }
    if (this.socials != null) {
      data['socials'] = this.socials!.toJson();
    }
    return data;
  }
}

class BannerImage {
  File? file;
  String? mediaType;

  BannerImage({this.file, this.mediaType});

  BannerImage.fromJson(Map json) {
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    mediaType = json['mediaType'];
  }

  Map toJson() {
    final Map data = new Map();
    if (this.file != null) {
      data['file'] = this.file!.toJson();
    }
    data['mediaType'] = this.mediaType;
    return data;
  }
}

class File {
  String? url;

  File({this.url});

  File.fromJson(Map json) {
    url = json['url'];
  }

  Map toJson() {
    final Map data = new Map();
    data['url'] = this.url;
    return data;
  }
}

class Socials {
  File? twitter;
  File? website;
  File? discord;

  Socials({this.twitter, this.website, this.discord});

  Socials.fromJson(Map json) {
    twitter =
        json['twitter'] != null ? new File.fromJson(json['twitter']) : null;
    website =
        json['website'] != null ? new File.fromJson(json['website']) : null;
    discord =
        json['discord'] != null ? new File.fromJson(json['discord']) : null;
  }

  Map toJson() {
    final Map data = new Map();
    if (this.twitter != null) {
      data['twitter'] = this.twitter!.toJson();
    }
    if (this.website != null) {
      data['website'] = this.website!.toJson();
    }
    if (this.discord != null) {
      data['discord'] = this.discord!.toJson();
    }
    return data;
  }
}

class CollectionData {
  StoragePath? storagePath;
  StoragePath? publicPath;
  PublicLinkedType? publicLinkedType;
  PublicLinkedType? privateLinkedType;
  StoragePath? privatePath;

  CollectionData(
      {this.storagePath,
      this.publicPath,
      this.publicLinkedType,
      this.privateLinkedType,
      this.privatePath});

  CollectionData.fromJson(Map json) {
    storagePath = json['storagePath'] != null
        ? new StoragePath.fromJson(json['storagePath'])
        : null;
    publicPath = json['publicPath'] != null
        ? new StoragePath.fromJson(json['publicPath'])
        : null;
    publicLinkedType = json['publicLinkedType'] != null
        ? new PublicLinkedType.fromJson(json['publicLinkedType'])
        : null;
    privateLinkedType = json['privateLinkedType'] != null
        ? new PublicLinkedType.fromJson(json['privateLinkedType'])
        : null;
    privatePath = json['privatePath'] != null
        ? new StoragePath.fromJson(json['privatePath'])
        : null;
  }

  Map toJson() {
    final Map data = new Map();
    if (this.storagePath != null) {
      data['storagePath'] = this.storagePath!.toJson();
    }
    if (this.publicPath != null) {
      data['publicPath'] = this.publicPath!.toJson();
    }
    if (this.publicLinkedType != null) {
      data['publicLinkedType'] = this.publicLinkedType!.toJson();
    }
    if (this.privateLinkedType != null) {
      data['privateLinkedType'] = this.privateLinkedType!.toJson();
    }
    if (this.privatePath != null) {
      data['privatePath'] = this.privatePath!.toJson();
    }
    return data;
  }
}

class StoragePath {
  String? identifier;
  String? domain;

  StoragePath({this.identifier, this.domain});

  StoragePath.fromJson(Map json) {
    identifier = json['identifier'];
    domain = json['domain'];
  }

  Map toJson() {
    final Map data = new Map();
    data['identifier'] = this.identifier;
    data['domain'] = this.domain;
    return data;
  }
}

class PublicLinkedType {
  StaticType? staticType;

  PublicLinkedType({this.staticType});

  PublicLinkedType.fromJson(Map json) {
    staticType = json['staticType'] != null
        ? new StaticType.fromJson(json['staticType'])
        : null;
  }

  Map toJson() {
    final Map data = new Map();
    if (this.staticType != null) {
      data['staticType'] = this.staticType!.toJson();
    }
    return data;
  }
}

class StaticType {
  String? kind;
  String? typeID;

  StaticType({this.kind, this.typeID});

  StaticType.fromJson(Map json) {
    kind = json['kind'];
    typeID = json['typeID'];
  }

  Map toJson() {
    final Map data = new Map();
    data['kind'] = this.kind;
    data['typeID'] = this.typeID;
    return data;
  }
}

class NFTType {
  StaticType? staticType;

  NFTType({this.staticType});

  NFTType.fromJson(Map json) {
    staticType = json['staticType'] != null
        ? new StaticType.fromJson(json['staticType'])
        : null;
  }

  Map toJson() {
    final Map data = new Map();
    if (this.staticType != null) {
      data['staticType'] = this.staticType!.toJson();
    }
    return data;
  }
}

class Type {
  String? kind;

  Type({this.kind});

  Type.fromJson(Map json) {
    kind = json['kind'];
  }

  Map toJson() {
    final Map data = new Map();
    data['kind'] = this.kind;
    return data;
  }
}
