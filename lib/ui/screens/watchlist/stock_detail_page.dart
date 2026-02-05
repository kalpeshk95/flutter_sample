import 'package:flutter/material.dart';
import 'package:flutter_sample/core/remote/model/nifty/nifty_fifty_response.dart';
import 'package:flutter_sample/core/theme/text_style_extensions.dart';
import 'package:flutter_sample/ui/shared/utility/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_typography.dart';
import '../../shared/widgets/custom_app_bar.dart';

class StockDetailPage extends StatefulWidget {
  final Datum stock;

  const StockDetailPage({super.key, required this.stock});

  @override
  State<StockDetailPage> createState() => _StockDetailPageState();
}

class _StockDetailPageState extends State<StockDetailPage> {
  // Chart state variables
  final Map<String, String?> _chartData = {
    '1D': null,
    '1M': null,
    '1Y': null,
  };
  String _selectedChartPeriod = '1D';
  bool _isLoadingChart = false;

  @override
  void initState() {
    super.initState();
    _loadChartData();
  }

  Future<void> _loadChartData() async {
    setState(() => _isLoadingChart = true);

    // Simulate loading chart data
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, you would fetch the chart data from your API
    // For now, we'll just use the chart paths from the stock object
    setState(() {
      _chartData['1D'] = widget.stock.chartTodayPath;
      _chartData['1M'] = widget.stock.chart30DPath;
      _chartData['1Y'] = widget.stock.chart365DPath;
      _isLoadingChart = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colorScheme;
    final stock = widget.stock;
    final isPositive = (stock.change ?? 0) >= 0;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CustomAppBar(
        title: stock.symbol ?? '',
        backgroundColor: colorScheme.surface,
        titleSpacing: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              colorScheme.primary.withOpacity(0.05),
              colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(context, isPositive, stock),
                    // const SizedBox(height: 16),
                    _buildKeyMetricsSection(context, stock),
                    const SizedBox(height: 16),
                    _buildChartSection(context, stock),
                    const SizedBox(height: 16),
                    if (stock.meta != null) ...[
                      _buildCompanyInfoSection(context, stock.meta!),
                      const SizedBox(height: 16),
                    ],
                  ],
                ),
              ),
            ),
            _buildBottomBar(context, stock),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context, bool isPositive, Datum stock) {
    final meta = stock.meta;
    final colorScheme = context.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            meta?.companyName ?? stock.symbol ?? '',
            style: AppTypography.twentyTwo.semiBold.withColor(colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '₹${stock.lastPrice?.toStringAsFixed(2) ?? '--'}',
                style: AppTypography.twenty.bold.withColor(colorScheme.onSurface),
              ),
              if (stock.change != null && stock.pChange != null) ...[
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? context.isDarkMode
                            ? Colors.green.shade900
                            : Colors.green.shade100
                        : context.isDarkMode
                            ? Colors.red.shade200
                            : Colors.red.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${stock.change?.toStringAsFixed(2)} (${stock.pChange?.abs().toStringAsFixed(2)}%)',
                    style: AppTypography.twelve.semiBold.withColor((stock.change ?? 0).getPLColor),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyMetricsSection(BuildContext context, Datum stock) {
    final colorScheme = context.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildMetricRow(
              context,
              icon: Icons.bar_chart_rounded,
              label: 'Day Range',
              value:
                  '₹${stock.dayLow?.toStringAsFixed(2) ?? '--'} - ₹${stock.dayHigh?.toStringAsFixed(2) ?? '--'}',
            ),
            const Divider(height: 24),
            _buildMetricRow(
              context,
              icon: Icons.show_chart_rounded,
              label: '52 Week Range',
              value:
                  '₹${stock.yearLow?.toStringAsFixed(2) ?? '--'} - ₹${stock.yearHigh?.toStringAsFixed(2) ?? '--'}',
            ),
            if (stock.open != null) ...[
              const Divider(height: 24),
              _buildMetricRow(
                context,
                icon: Icons.trending_up_rounded,
                label: 'Open',
                value: '₹${stock.open?.toStringAsFixed(2) ?? '--'}',
              ),
            ],
            if (stock.previousClose != null) ...[
              const Divider(height: 24),
              _buildMetricRow(
                context,
                icon: Icons.timeline_rounded,
                label: 'Prev Close',
                value: '₹${stock.previousClose?.toStringAsFixed(2) ?? '--'}',
              ),
            ],
            if (stock.totalTradedVolume != null) ...[
              const Divider(height: 24),
              _buildMetricRow(
                context,
                icon: Icons.auto_graph_rounded,
                label: 'Volume',
                value: _formatNumber(stock.totalTradedVolume?.toDouble() ?? 0),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMetricRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final colorScheme = context.colorScheme;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.fourteen.withColor(colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.sixteen.medium.withColor(colorScheme.onSurface),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartSection(BuildContext context, Datum stock) {
    final colorScheme = context.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.bar_chart_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Charts',
                  style: AppTypography.sixteen.semiBold.withColor(colorScheme.onSurface),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Chart container
            LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = width * 9 / 20;
              return Container(
                height: height,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: _buildChartContent(colorScheme, stock),
              );
            }),

            const SizedBox(height: 16),

            // Chart period selector
            _buildChartPeriodSelector(colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildChartPeriodSelector(ColorScheme colorScheme) {
    final periods = ['1D', '1M', '1Y'];

    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: periods.map((period) {
          final isSelected = _selectedChartPeriod == period;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedChartPeriod = period),
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  period,
                  style: AppTypography.fourteen.copyWith(
                    color:
                        isSelected ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChartContent(ColorScheme colorScheme, Datum stock) {
    if (_isLoadingChart) {
      return const Center(child: CircularProgressIndicator());
    }

    final chartUrl = _chartData[_selectedChartPeriod];

    if (chartUrl == null || chartUrl.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_rounded,
              size: 48,
              color: colorScheme.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 8),
            Text(
              'Chart data not available',
              style: AppTypography.fourteen.withColor(colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SvgPicture.network(
        chartUrl,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
          ),
        ),
      ),
    );
  }

  Widget _buildCompanyInfoSection(BuildContext context, Meta? meta) {
    if (meta == null) return const SizedBox.shrink();
    final colorScheme = context.colorScheme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.business_rounded,
                  color: colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Company Info',
                  style: AppTypography.sixteen.semiBold.withColor(colorScheme.onSurface),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (meta.industry != null)
              _buildInfoItem(
                context,
                icon: Icons.add_home_work_rounded,
                label: 'Industry',
                value: meta.industry!,
              ),
            if (meta.isin != null)
              _buildInfoItem(
                context,
                icon: Icons.numbers_rounded,
                label: 'ISIN',
                value: meta.isin!,
                showDivider: meta.industry != null,
              ),
            if (meta.listingDate != null)
              _buildInfoItem(
                context,
                icon: Icons.calendar_month_rounded,
                label: 'Listed On',
                value: DateFormat('MMM dd, yyyy').format(meta.listingDate!),
                showDivider: meta.isin != null || meta.industry != null,
              ),
            _buildInfoItem(
              context,
              icon: Icons.insights_rounded,
              label: 'Derivatives',
              value: meta.isFnoSec == true ? 'Eligible' : 'Not Eligible',
              isLast: true,
              showDivider: meta.listingDate != null || meta.isin != null || meta.industry != null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
    bool showDivider = true,
  }) {
    final colorScheme = context.colorScheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.twelve.withColor(colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTypography.fourteen.medium.withColor(colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider && !isLast) ...[
          const SizedBox(height: 12),
          Divider(
            height: 1,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: 12),
        ] else if (!isLast)
          const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, Datum stock) {
    final colorScheme = context.colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  // TODO: Implement sell action
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'BUY',
                  style: AppTypography.sixteen.semiBold.withColor(Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: () {
                  // TODO: Implement sell action
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red.shade700,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'SELL',
                  style: AppTypography.sixteen.semiBold.withColor(Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(double num) {
    if (num >= 10000000) {
      return '${(num / 10000000).toStringAsFixed(2)}Cr';
    } else if (num >= 100000) {
      return '${(num / 100000).toStringAsFixed(2)}L';
    } else if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(2)}K';
    }
    return num.toStringAsFixed(2);
  }
}
