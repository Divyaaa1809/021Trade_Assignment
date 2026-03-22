import 'package:bloc_assignment/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/stock_bloc.dart';
import 'bloc/stock_event.dart';
import 'ui/watchlist_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/stock.dart';
import 'utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  enableLogger();

  await Hive.initFlutter();
  Hive.registerAdapter(StockAdapter());
  await Hive.openBox<Stock>(StockConstants.stockBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StockBloc()..add(LoadStocksEvent()),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WatchlistScreen(),
      ),
    );
  }
}
