import 'package:flutter/material.dart';

import '../../../core/remote/model/nifty/nifty_fifty_response.dart';
import '../../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_app_bar.dart';

class StockDetailPage extends StatelessWidget {
  final Datum stock;

  const StockDetailPage({super.key, required this.stock});

  @override
  Widget build(BuildContext context) {
    final isPositive = (stock.change ?? 0) >= 0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
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
                  _priceHeader(context, isPositive),

                  const SizedBox(height: 12),

                  /// Performance Stats
                  _statsCard(context, isPositive),

                  const SizedBox(height: 12),

                  /// Market Stats
                  _marketStats(context),

                  const SizedBox(height: 12),

                  /// Company Info
                  _companyInfo(context),
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
  Widget _priceHeader(BuildContext context, bool isPositive) {
    final primaryColor = isPositive ? Colors.green : Colors.red;
    final gradientColors = [
      primaryColor.shade400,
      primaryColor.shade700,
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stock.meta?.companyName ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.titleLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "₹${stock.lastPrice?.toStringAsFixed(2) ?? '-'}",
                style: AppTypography.headlineMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "${stock.change?.toStringAsFixed(2)} (${stock.pChange?.toStringAsFixed(2)}%)",
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Performance Stats
  Widget _statsCard(BuildContext context, bool isPositive) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                _infoTile(
                  Icons.arrow_back,
                  "Prev Close",
                  stock.previousClose,
                  context: context,
                  color: colorScheme.onSurfaceVariant,
                ),
                const Spacer(),
                _infoTile(
                  Icons.arrow_upward,
                  "Open",
                  stock.open,
                  context: context,
                  color: colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Divider(height: 1, color: colorScheme.outlineVariant),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoTile(
                  Icons.trending_up,
                  "Day High",
                  stock.dayHigh,
                  context: context,
                  color: Colors.green.shade600,
                ),
                const Spacer(),
                _infoTile(
                  Icons.trending_down,
                  "Day Low",
                  stock.dayLow,
                  context: context,
                  color: Colors.red.shade600,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoTile(
                  Icons.show_chart,
                  "52W High",
                  stock.yearHigh,
                  context: context,
                  color: Colors.green.shade600,
                ),
                const Spacer(),
                _infoTile(
                  Icons.bar_chart,
                  "52W Low",
                  stock.yearLow,
                  context: context,
                  color: Colors.red.shade600,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Market Stats
  Widget _marketStats(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _infoTile(
              Icons.swap_vert,
              "Volume",
              stock.totalTradedVolume,
              context: context,
              color: Colors.orange.shade600,
            ),
            const SizedBox(height: 12),
            _infoTile(
              Icons.currency_rupee,
              "Traded Value",
              stock.totalTradedValue?.toStringAsFixed(2),
              context: context,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 12),
            _infoTile(
              Icons.account_balance_wallet,
              "FFMC",
              stock.ffmc?.toStringAsFixed(2),
              context: context,
              color: Colors.purple.shade600,
            ),
            const SizedBox(height: 12),
            _infoTile(
              Icons.trending_up,
              "Near 52W High",
              "${stock.nearWkh?.toStringAsFixed(2) ?? '0'}%",
              context: context,
              color: Colors.green.shade600,
            ),
            const SizedBox(height: 12),
            _infoTile(
              Icons.trending_down,
              "Near 52W Low",
              "${stock.nearWkl?.toStringAsFixed(2) ?? '0'}%",
              context: context,
              color: Colors.red.shade600,
            ),
          ],
        ),
      ),
    );
  }

  /// Info Tile
  Widget _infoTile(IconData icon, String title, dynamic value,
      {required BuildContext context, Color? color}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: (color ?? colorScheme.primary).withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 18,
            color: color ?? colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: AppTypography.labelSmall.copyWith(
                color: colorScheme.onSurfaceVariant.withOpacity(0.8),
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value != null ? value.toString() : '-',
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.w600,
                color: color ?? colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Format date from YYYY-MM-DD to DD MMM YYYY
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    try {
      final day = date.day.toString().padLeft(2, '0');
      final month = _getMonthName(date.month);
      final year = date.year;
      return '$day $month $year';
    } catch (e) {
      return ''; // Return original string if parsing fails
    }
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }

  /// Company Info
  Widget _companyInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final meta = stock.meta;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.business,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Company Information',
                  style: AppTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (meta?.companyName != null) _infoRow('Company', meta?.companyName, context),
            if (meta?.industry != null) _infoRow('Industry', meta?.industry, context),
            if (meta?.isin != null) _infoRow('ISIN', meta?.isin, context),
            if (meta?.listingDate != null)
              _infoRow('Listing Date', _formatDate(meta?.listingDate), context),
          ],
        ),
      ),
    );
  }

  /// Info Row
  Widget _infoRow(String label, String? value, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTypography.bodyMedium.copyWith(
                color: colorScheme.onSurfaceVariant.withOpacity(0.8),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value ?? '',
              style: AppTypography.bodyLarge.copyWith(
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
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
