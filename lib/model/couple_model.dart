class Couple {
  String id;
  String question;
  String answer;

  Couple({required this.id, required this.question, required this.answer});

  factory Couple.fromJson(Map<dynamic, dynamic> json) {
    return Couple(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
    );
  }

  Map<dynamic, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "answer": answer,
    };
  }
}
