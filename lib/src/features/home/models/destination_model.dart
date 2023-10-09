class DestinationModel {
  String? destinationId;
  String? imageUrl;
  String? starCount;
  String? location;
  String? name;

  // Constructor
  DestinationModel({
    this.destinationId,
    this.imageUrl,
    this.starCount,
    this.location,
    this.name,
  });

  // Factory method to create an instance from a JSON map
  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      destinationId: json['destinationId'] as String?,
      imageUrl: json['imageUrl'] as String?,
      starCount: json['starCount'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
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
    return data;
  }
}
