import 'package:bloc_assignment/bloc/stock_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/stock_bloc.dart';
import '../bloc/stock_state.dart';

class EditWatchlistScreen extends StatelessWidget {
  const EditWatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.grey[100],
        title: const Text(
          "Edit Watchlist",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
      body: BlocListener<StockBloc, StockState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        child: BlocBuilder<StockBloc, StockState>(
          builder: (context, state) {
            return state.stocks.isEmpty
                ? const Center(child: Text("No stocks in watchlist"))
                : ReorderableListView.builder(
                    itemCount: state.stocks.length,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex == newIndex || oldIndex + 1 == newIndex) {
                        return;
                      }

                      context.read<StockBloc>().add(
                        ReorderStockEvent(oldIndex, newIndex),
                      );
                    },
                    itemBuilder: (_, index) {
                      final stock = state.stocks[index];

                      return Column(
                        key: ValueKey(index),
                        children: [
                          ListTile(
                            leading: const Icon(Icons.drag_handle, size: 21),
                            title: Text(
                              stock.name,
                              style: TextStyle(
                                fontSize: 14.5,
                                color: Colors.grey[700],
                              ),
                            ),
                            trailing: IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(Icons.delete, size: 21),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Delete Stock"),
                                    content: const Text(
                                      "Are you sure you want to delete this stock?",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Cancel"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<StockBloc>().add(
                                            DeleteStockEvent(index),
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Delete"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          Divider(height: 0.5, color: Colors.grey[300]),
                        ],
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
