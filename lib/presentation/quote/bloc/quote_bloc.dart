import 'package:to_do_project/data/repositories/quotes_repository.dart';
import 'package:to_do_project/presentation/quote/bloc/quote_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_project/data/models/quote.dart';
import 'package:injectable/injectable.dart';


@LazySingleton()
class QuoteCubit extends Cubit<QuoteState> {
  final QuotesRepository _quotesRepository;

  QuoteCubit(this._quotesRepository) : super(QuoteState.initial());

  Future<void> loadQuotes() async {
    try {
      emit(state.copyWith(isLoading: true, error: null));
      final quotes = await _quotesRepository.getQuotes();
      emit(state.copyWith(quotes: quotes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  // Переход к следующей цитате
  void nextQuote() {
    if (state.quotes.isEmpty) return;
    final nextIndex = (state.currentIndex + 1) % state.quotes.length;
    emit(state.copyWith(currentIndex: nextIndex));
  }

  // Переход к предыдущей цитате
  void previousQuote() {
    if (state.quotes.isEmpty) return;
    final prevIndex = (state.currentIndex - 1 + state.quotes.length) % state.quotes.length;
    emit(state.copyWith(currentIndex: prevIndex));
  }

  // Переключение статуса "избранное"
  void toggleFavorite() {
    if (state.quotes.isEmpty) return;
    
    final quotes = List<Quote>.from(state.quotes);
    final currentQuote = quotes[state.currentIndex];
    quotes[state.currentIndex] = currentQuote.copyWith(isFavorite: !currentQuote.isFavorite);
    
    emit(state.copyWith(quotes: quotes));
  }

  // Показать случайную цитату
  void showRandomQuote() {
    if (state.quotes.isEmpty) return;
    
    final random = DateTime.now().millisecondsSinceEpoch % state.quotes.length;
    if (random != state.currentIndex) {
      emit(state.copyWith(currentIndex: random));
    } else {
      // Если случайно выбран текущий индекс, берем следующий
      nextQuote();
    }
  }
}