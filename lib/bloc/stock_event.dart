abstract class StockEvent {}

class LoadStocksEvent extends StockEvent {}

class ReorderStockEvent extends StockEvent {
  final int oldIndex;
  final int newIndex;

  ReorderStockEvent(this.oldIndex, this.newIndex);
}

class DeleteStockEvent extends StockEvent {
  final int index;

  DeleteStockEvent(this.index);
}
