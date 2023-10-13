import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  LatLng? cords;
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
    this.cords,
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
     cords: LatLng(
        (json['cords'].latitude as double?) ?? 0.0,
        (json['cords'].longitude as double?) ?? 0.0,)
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
    data['cords'] = {
      'latitude': cords?.latitude,
      'longitude': cords?.longitude,
    };
    // data['mantra'] = mantra;
    // data['mantra'] = mantra;
    return data;
  }
}
