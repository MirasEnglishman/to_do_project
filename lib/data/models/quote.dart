import 'package:json_annotation/json_annotation.dart';

part 'quote.g.dart';

@JsonSerializable()
class Quote {
  final String id;
  final String text;
  final String author;
  bool isFavorite;

  Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.isFavorite,
  });

  factory Quote.fromJson(Map<String, dynamic> json) => _$QuoteFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteToJson(this);

  Quote copyWith({
    String? id,
    String? text,
    String? author,
    bool? isFavorite,
  }) {
    return Quote(
      id: id ?? this.id,
      text: text ?? this.text,
      author: author ?? this.author,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}