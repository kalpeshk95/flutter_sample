import 'package:flutter/material.dart';
import 'package:flutter_sample/core/remote/model/nifty/nifty_fifty.dart';
import 'package:flutter_sample/ui/screens/wathlist/watchlist_vm.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../routing/routes.dart';
import '../../shared/widgets/custom_app_bar.dart';
import '../../shared/widgets/ui_state_builder.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: CustomAppBar(title: 'Watchlist'),
        ),
        body: Consumer<WatchlistVm>(builder: (_, vm, __) {
          return UiStateBuilder<List<Datum>>(
            uiState: vm.niftyFiftyList,
            onSuccess: (_) => RefreshIndicator(
              onRefresh: () => vm.fetchNiftyList(),
              child: ListView.builder(
                itemCount: vm.niftyStocks.length,
                itemBuilder: (_, i) => NiftyFiftyTile(datum: vm.niftyStocks[i]),
              ),
            ),
            onRetry: vm.fetchNiftyList,
            showRetryOnEmpty: true,
          );
        }));
  }
}

class NiftyFiftyTile extends StatelessWidget {
  final Datum datum;

  const NiftyFiftyTile({super.key, required this.datum});

  @override
  Widget build(BuildContext context) {
    final NiftyStock stock = toStock(datum);
    final isPositive = stock.change >= 0;

    return InkWell(
      onTap: () => context.push(Routes.stockDetailPage, extra: datum),
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Symbol + CMP
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stock.symbol,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text("₹${stock.lastPrice}",
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),

              // Change + %
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(
                        isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                        color: isPositive ? Colors.green : Colors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        stock.change.toStringAsFixed(2),
                        style: TextStyle(
                            color: isPositive ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(
                    "${stock.pChange.toStringAsFixed(2)}%",
                    style: TextStyle(
                      color: isPositive ? Colors.green : Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
