class FaqsModel {
  String? question;
  String? answer;

  FaqsModel({this.question, this.answer,});

  factory FaqsModel.fromJson(Map<String, dynamic> json) {
    return FaqsModel(
      question: json['question'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question'] = question;
    data['answer'] = answer;
    return data;
  }

  @override
  String toString() {
    // Return a string representation of the raw data
    return 'FaqsModel{question: $question, answer: $answer,}';
  }
}
