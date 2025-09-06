import 'package:flutter/material.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../shared/widgets/custom_app_bar.dart';

class StockDetailPage extends StatelessWidget {
  final Datum stock;

  const StockDetailPage({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final isPositive = (stock.change ?? 0) >= 0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: CustomAppBar(title: stock.symbol ?? '', isBack: true),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Price Header
                  _priceHeader(isPositive),

                  const SizedBox(height: 12),

                  /// Performance Stats
                  _statsCard(isPositive),

                  const SizedBox(height: 12),

                  /// Market Stats
                  _marketStats(),

                  const SizedBox(height: 12),

                  /// Company Info
                  _companyInfo(),
                ],
              ),
            ),
          ),
          _actionButtons(),
        ],
      ),
    );
  }

  /// Price Header
  Widget _priceHeader(bool isPositive) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPositive
              ? [Colors.green.shade400, Colors.green.shade700]
              : [Colors.red.shade400, Colors.red.shade700],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stock.meta?.companyName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "₹${stock.lastPrice?.toStringAsFixed(2) ?? '-'}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: Colors.white,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                "${stock.change?.toStringAsFixed(2)} (${stock.pChange?.toStringAsFixed(2)}%)",
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Performance Stats
  Widget _statsCard(bool isPositive) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                _infoTile(Icons.arrow_back, "Prev Close", stock.previousClose, color: Colors.grey),
                const Spacer(),
                _infoTile(Icons.arrow_upward, "Open", stock.open, color: Colors.blue),
              ],
            ),
            Divider(color: Colors.grey.shade300),
            Row(
              children: [
                _infoTile(Icons.trending_up, "Day High", stock.dayHigh, color: Colors.green),
                const Spacer(),
                _infoTile(Icons.trending_down, "Day Low", stock.dayLow, color: Colors.red),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _infoTile(Icons.show_chart, "52W High", stock.yearHigh, color: Colors.green),
                const Spacer(),
                _infoTile(Icons.bar_chart, "52W Low", stock.yearLow, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Market Stats
  Widget _marketStats() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _infoTile(Icons.swap_vert, "Volume", stock.totalTradedVolume, color: Colors.orange),
            _infoTile(Icons.currency_rupee, "Value", stock.totalTradedValue?.toStringAsFixed(2),
                color: Colors.blue),
            _infoTile(Icons.account_balance_wallet, "FFMC", stock.ffmc?.toStringAsFixed(2),
                color: Colors.purple),
            _infoTile(
                Icons.trending_up, "Near 52W High", "${stock.nearWkh?.toStringAsFixed(2) ?? '0'}%",
                color: Colors.green),
            _infoTile(
                Icons.trending_down, "Near 52W Low", "${stock.nearWkl?.toStringAsFixed(2) ?? '0'}%",
                color: Colors.red),
          ],
        ),
      ),
    );
  }

  /// Info Tile
  Widget _infoTile(IconData icon, String title, dynamic value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.grey.shade600),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              Text(
                value != null ? value.toString() : '-',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 15, color: color ?? Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Company Info
  Widget _companyInfo() {
    final meta = stock.meta;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Company Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text("Industry: ${meta?.industry ?? ''}"),
            Text("ISIN: ${meta?.isin ?? ''}"),
            Text("Listing Date: ${meta?.listingDate?.toIso8601String() ?? ''}"),
            Text("F&O Available: ${meta?.isFnoSec == true ? 'Yes' : 'No'}"),
          ],
        ),
      ),
    );
  }

  /// Action Buttons
  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              onPressed: () {},
              child: const Text("BUY", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
              onPressed: () {},
              child: const Text("SELL", style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
