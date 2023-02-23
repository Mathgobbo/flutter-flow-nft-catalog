import 'package:flutter_flow_nft_catalog/types/NFTCatalogMetadata.dart';

class NFT {
  String? externalURL;
  Path? privatePath;
  String? name;
  String? collectionDescription;
  String? collectionExternalURL;
  List<Object>? royalties;
  String? collectionName;
  PublicLinkedType? publicLinkedType;
  String? collectionBannerImage;
  String? description;
  String? thumbnail;
  int? id;
  String? collectionSquareImage;
  PublicLinkedType? privateLinkedType;
  Path? storagePath;
  Path? publicPath;

  NFT(
      {this.externalURL,
      this.privatePath,
      this.name,
      this.collectionDescription,
      this.collectionExternalURL,
      this.royalties,
      this.collectionName,
      this.publicLinkedType,
      this.collectionBannerImage,
      this.description,
      this.thumbnail,
      this.id,
      this.collectionSquareImage,
      this.privateLinkedType,
      this.storagePath,
      this.publicPath});

  NFT.fromJson(Map json) {
    externalURL = json['externalURL'];
    privatePath = json['privatePath'] != null
        ? new Path.fromJson(json['privatePath'])
        : null;
    name = json['name'];
    collectionDescription = json['collectionDescription'];
    collectionExternalURL = json['collectionExternalURL'];
    if (json['royalties'] != null) {
      royalties = <Object>[];
      json['royalties'].forEach((v) {
        //royalties!.add(new Object?.fromJson(v));
      });
    }
    collectionName = json['collectionName'];
    publicLinkedType = json['publicLinkedType'] != null
        ? new PublicLinkedType.fromJson(json['publicLinkedType'])
        : null;
    collectionBannerImage = json['collectionBannerImage'];
    description = json['description'];
    thumbnail = json['thumbnail'];
    id = json['id'];
    collectionSquareImage = json['collectionSquareImage'];
    privateLinkedType = json['privateLinkedType'] != null
        ? new PublicLinkedType.fromJson(json['privateLinkedType'])
        : null;
    storagePath = json['storagePath'] != null
        ? new Path.fromJson(json['storagePath'])
        : null;
    publicPath = json['publicPath'] != null
        ? new Path.fromJson(json['publicPath'])
        : null;
  }

  Map toJson() {
    final Map data = new Map();
    data['externalURL'] = this.externalURL;
    if (this.privatePath != null) {
      data['privatePath'] = this.privatePath!.toJson();
    }
    data['name'] = this.name;
    data['collectionDescription'] = this.collectionDescription;
    data['collectionExternalURL'] = this.collectionExternalURL;
    if (this.royalties != null) {
      //data['royalties'] = this.royalties!.map((v) => v.toJson()).toList();
    }
    data['collectionName'] = this.collectionName;
    if (this.publicLinkedType != null) {
      data['publicLinkedType'] = this.publicLinkedType!.toJson();
    }
    data['collectionBannerImage'] = this.collectionBannerImage;
    data['description'] = this.description;
    data['thumbnail'] = this.thumbnail;
    data['id'] = this.id;
    data['collectionSquareImage'] = this.collectionSquareImage;
    if (this.privateLinkedType != null) {
      data['privateLinkedType'] = this.privateLinkedType!.toJson();
    }
    if (this.storagePath != null) {
      data['storagePath'] = this.storagePath!.toJson();
    }
    if (this.publicPath != null) {
      data['publicPath'] = this.publicPath!.toJson();
    }
    return data;
  }
}

class Path {
  String? domain;
  String? identifier;

  Path({this.domain, this.identifier});

  Path.fromJson(Map json) {
    domain = json['domain'];
    identifier = json['identifier'];
  }

  Map toJson() {
    final Map data = new Map();
    data['domain'] = this.domain;
    data['identifier'] = this.identifier;
    return data;
  }
}
