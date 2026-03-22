import 'package:bloc_assignment/models/stock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stock_bloc.dart';
import '../bloc/stock_state.dart';
import '../utils/formatter.dart';
import 'edit_watchlist_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StockBloc, StockState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 6,
            shadowColor: Colors.grey[100],
            title: const Text(
              "Watchlist",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
          floatingActionButton: state.stocks.isEmpty
              ? null
              : FloatingActionButton(
                  child: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditWatchlistScreen(),
                      ),
                    );
                  },
                ),
          body: BlocListener<StockBloc, StockState>(
            listener: (context, state) {
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            },
            child: state.stocks.isEmpty
                ? const Center(child: Text("No stocks in watchlist"))
                : ListView.builder(
                    itemCount: state.stocks.length,
                    itemBuilder: (_, index) {
                      final stock = state.stocks[index];

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              buildTextCol(
                                stock,
                                title: stock.name,
                                subtitle: stock.exchange,
                              ),
                              buildTextCol(
                                stock,
                                title: Formatter.formatPrice(stock.price),
                                subtitle: Formatter.formatChange(stock.change),
                                isColored: true,
                                alignEnd: true,
                              ),
                            ],
                          ),
                          Divider(height: 0.5, color: Colors.grey[300]),
                        ],
                      );
                    },
                  ),
          ),
        );
      },
    );
  }

  Padding buildTextCol(
    Stock stock, {
    required String title,
    required String subtitle,
    bool isColored = false,
    bool alignEnd = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: alignEnd
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: alignEnd
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: isColored
                  ? stock.change >= 0
                        ? Colors.green
                        : Colors.red
                  : Colors.black,
            ),
          ),
          SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
