import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/stock_bloc.dart';
import '../bloc/stock_state.dart';
import 'edit_watchlist_screen.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6,
        shadowColor: Colors.grey[100],
        title: const Text(
          "Watchlist",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditWatchlistScreen()),
          );
        },
      ),
      body: BlocBuilder<StockBloc, StockState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.stocks.length,
            itemBuilder: (_, index) {
              final stock = state.stocks[index];

              return Column(
                children: [
                  ListTile(
                    title: Text(stock.name, style: TextStyle(fontSize: 15)),
                    subtitle: Text(
                      stock.exchange,
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    trailing: Text(
                      "₹${stock.price}",
                      style: TextStyle(
                        color: stock.change >= 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                  Divider(height: 0.5, color: Colors.grey[300]),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
