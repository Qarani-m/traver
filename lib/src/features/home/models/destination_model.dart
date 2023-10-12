import 'package:flutter/material.dart';

class DestinationModel {
  String? destinationId;
  String? imageUrl;
  String? starCount;
  String? location;
  String? name;
  String? price;
  String? mantra;
  List<Map<String, bool>>? whatsIncluded;
  String? about;
  List<String>? gallery;
  List<double>? cordinates;
  // String? price;
  // String? price;
  // String? price;

  // Constructor
  DestinationModel({
    this.destinationId,
    this.imageUrl,
    this.starCount,
    this.location,
    this.name,
    this.price,
    this.mantra,
    this.whatsIncluded,
    this.about,
    this.gallery,
    this.cordinates,
    // this.price,
    // this.price,
    // this.price,
  });

  // Factory method to create an instance from a JSON map
  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      destinationId: json['destinationId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      starCount: json['starCount'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
      price: json['price'] as String?,
      mantra: json['price'] as String?,
      whatsIncluded: json['whatsIncluded'] as List<Map<String,bool>>?,
      about: json['about'] as String?,
      gallery: json['gallery'] as List<String>?,
      cordinates: json['cordinates'] as List<double>?,
      // price: json['price'] as String?,
      // price: json['price'] as String?,
      // price: json['price'] as String?,
    );
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['destinationId'] = destinationId;
    data['imageUrl'] = imageUrl;
    data['starCount'] = starCount;
    data['location'] = location;
    data['name'] = name;
    data['price'] = price;
    data['mantra'] = mantra;
    data['whatsIncluded'] = whatsIncluded;
    data['about'] = about;
    data['gallery'] = gallery;
    data['cordinates'] = cordinates;
    // data['mantra'] = mantra;
    // data['mantra'] = mantra;
    return data;
  }
}
