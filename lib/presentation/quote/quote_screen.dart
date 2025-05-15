import 'dart:math';

import 'package:asyl_project/presentation/quote/bloc/quote_bloc.dart';
import 'package:asyl_project/presentation/quote/bloc/quote_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  int _shuffleTurns = 0;

  @override
  void initState() {
    super.initState();
    context.read<QuoteCubit>().loadQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'quote.title'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Shuffle button with rotation animation
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: _shuffleTurns.toDouble()),
            duration: const Duration(milliseconds: 500),
            builder: (context, turns, child) {
              return Transform.rotate(
                angle: turns * 2 * pi,
                child: child,
              );
            },
            child: IconButton(
              icon: const Icon(Icons.shuffle),
              onPressed: () {
                setState(() => _shuffleTurns++);
                context.read<QuoteCubit>().showRandomQuote();
              },
              tooltip: 'quote.random_quote'.tr(),
            ),
          ),
        ],
      ),
      body: BlocBuilder<QuoteCubit, QuoteState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'quote.error.title'.tr(args: [state.error!]),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<QuoteCubit>().loadQuotes(),
                    child: Text('quote.error.retry'.tr()),
                  ),
                ],
              ),
            );
          }

          if (state.quotes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'quote.empty.message'.tr(),
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<QuoteCubit>().loadQuotes(),
                    child: Text('quote.empty.refresh'.tr()),
                  ),
                ],
              ),
            );
          }

          final quote = state.currentQuote!;
          final theme = Theme.of(context);

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.format_quote,
                    size: 60,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 24),
                  // Animate quote card on change
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      final offsetAnim = Tween<Offset>(
                        begin: const Offset(0, 0.2),
                        end: Offset.zero,
                      ).animate(animation);
                      return SlideTransition(
                        position: offsetAnim,
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Card(
                      key: ValueKey(quote.id),
                      elevation: 0,
                      color: theme.colorScheme.surfaceVariant,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            Text(
                              quote.text,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            Text(
                              '— ${quote.author}',
                              style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildControlButtons(context, quote),
                  const SizedBox(height: 16),
                  Text(
                    '${state.currentIndex + 1} из ${state.quotes.length}',
                    style: TextStyle(color: theme.colorScheme.outline),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('quote.add.coming_soon'.tr())),
          );
        },
        tooltip: 'quote.add.tooltip'.tr(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildControlButtons(BuildContext context, quote) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => context.read<QuoteCubit>().previousQuote(),
          icon: const Icon(Icons.arrow_back_ios),
          tooltip: 'quote.navigation.previous'.tr(),
        ),
        const SizedBox(width: 16),
        // Favorite button with scale animation
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 1.0, end: quote.isFavorite ? 1.2 : 1.0),
          duration: const Duration(milliseconds: 200),
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: IconButton(
            onPressed: () => context.read<QuoteCubit>().toggleFavorite(),
            icon: Icon(
              quote.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: quote.isFavorite ? Colors.red : null,
            ),
            tooltip: 'quote.navigation.favorite'.tr(),
          ),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () => context.read<QuoteCubit>().nextQuote(),
          icon: const Icon(Icons.arrow_forward_ios),
          tooltip: 'quote.navigation.next'.tr(),
        ),
      ],
    );
  }
}
