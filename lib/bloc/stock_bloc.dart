import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import '../models/stock.dart';
import '../utils/constant.dart';
import 'stock_event.dart';
import 'stock_state.dart';

class StockBloc extends Bloc<StockEvent, StockState> {
  final log = Logger('StockBloc');
  final Box<Stock> box = Hive.box<Stock>(StockConstants.stockBoxName);

  StockBloc() : super(const StockState(stocks: [])) {
    on<LoadStocksEvent>(_onLoad);
    on<ReorderStockEvent>(_onReorder);
    on<DeleteStockEvent>(_onDelete);
  }

  void _onLoad(LoadStocksEvent event, Emitter<StockState> emit) {
    try {
      if (box.isEmpty) {
        final defaultStocks = [
          Stock(name: "RELIANCE", exchange: "NSE", price: 1374, change: -4.5),
          Stock(name: "HDFCBANK", exchange: "NSE", price: 966.85, change: 0.85),
          Stock(
            name: "ASIANPAINT",
            exchange: "NSE",
            price: 2537.40,
            change: 6.6,
          ),
          Stock(
            name: "NIFTY IT",
            exchange: "IDX",
            price: 35187.55,
            change: 877.11,
          ),
        ];

        box.addAll(defaultStocks);
      }

      emit(StockState(stocks: box.values.toList()));
    } catch (e) {
      log.severe("Error loading stocks: $e");
      emit(state.copyWith(errorMessage: "Failed to load stocks"));
    }
  }

  void _onReorder(ReorderStockEvent event, Emitter<StockState> emit) {
    try {
      final list = List<Stock>.from(state.stocks);

      if (list.isEmpty) return;
      if (event.oldIndex < 0 || event.oldIndex >= list.length) return;

      int newIndex = event.newIndex;

      if (newIndex > list.length) newIndex = list.length;
      if (newIndex < 0) newIndex = 0;

      if (newIndex > event.oldIndex) {
        newIndex--;
      }

      if (event.oldIndex == newIndex) return;

      final item = list.removeAt(event.oldIndex);
      list.insert(newIndex, item);

      box.deleteAll(box.keys);
      box.clear();
      box.addAll(list);
      emit(StockState(stocks: box.values.toList(), errorMessage: null));
    } catch (e) {
      log.severe("Error reordering stocks: $e");
      emit(state.copyWith(errorMessage: "Failed to reorder stocks"));
    }
  }

  void _onDelete(DeleteStockEvent event, Emitter<StockState> emit) {
    try {
      final list = List<Stock>.from(state.stocks);

      if (event.index < 0 || event.index >= list.length) {
        throw Exception("Invalid index");
      }

      list.removeAt(event.index);

      box.deleteAll(box.keys);
      box.clear();
      box.addAll(list);

      emit(StockState(stocks: box.values.toList(), errorMessage: null));
    } catch (e) {
      log.severe("Error deleting stock: $e");
      emit(state.copyWith(errorMessage: "Something went wrong while deleting"));
    }
  }
}
