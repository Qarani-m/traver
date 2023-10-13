class ReviewModel {
  String? name;
  String? date;
  String? imageUrl;
  String? starCount;
  String? review;
  // String? destinationId;

  ReviewModel({
    this.name,
    this.date,
    this.imageUrl,
    this.starCount,
    this.review,
    // this.destinationId
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      name: json['price'] as String?,
      date: json['price'] as String?,
      imageUrl: json['price'] as String?,
      starCount: json['price'] as String?,
      review: json['price'] as String?,
      // destinationId: json['destinationId'] as String?,
    );
  }

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['date'] = date;
    data['imageUrl'] = imageUrl;
    data['starCount'] = starCount;
    data['review'] = review;
    // data['destinationId'] = destinationId;
    return data;
  }
}
