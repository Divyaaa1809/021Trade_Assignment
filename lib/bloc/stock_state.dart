import '../models/stock.dart';

class StockState {
  final List<Stock> stocks;
  final String? errorMessage;
  final bool isLoading;

  const StockState({
    required this.stocks,
    this.errorMessage,
    this.isLoading = false,
  });

  StockState copyWith({
    List<Stock>? stocks,
    String? errorMessage,
    bool? isLoading,
  }) {
    return StockState(
      stocks: stocks ?? this.stocks,
      errorMessage: errorMessage,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}