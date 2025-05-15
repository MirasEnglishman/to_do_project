
import 'package:equatable/equatable.dart';
import 'package:to_do_project/data/models/quote.dart';

// Состояние для хранения данных о цитатах
class QuoteState extends Equatable {
  final List<Quote> quotes;
  final int currentIndex;
  final bool isLoading;
  final String? error;

  const QuoteState({
    required this.quotes,
    required this.currentIndex,
    this.isLoading = false,
    this.error,
  });

  // Начальное состояние
  factory QuoteState.initial() => const QuoteState(
        quotes: [],
        currentIndex: 0,
        isLoading: false,
      );

  // Метод для создания копии с обновленными значениями
  QuoteState copyWith({
    List<Quote>? quotes,
    int? currentIndex,
    bool? isLoading,
    String? error,
  }) {
    return QuoteState(
      quotes: quotes ?? this.quotes,
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  // Текущая цитата
  Quote? get currentQuote {
    if (quotes.isEmpty) return null;
    return quotes[currentIndex];
  }

  @override
  List<Object?> get props => [quotes, currentIndex, isLoading, error];
}