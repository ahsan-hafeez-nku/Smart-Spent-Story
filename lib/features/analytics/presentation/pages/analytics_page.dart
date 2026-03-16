import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _AnalyticsAppBar(),
                    20.0.height,
                    const _SummaryRow(),
                    24.0.height,
                    const _AnalyticsSectionCard(
                      title: 'Income vs Expenses',
                      child: _IncomeExpenseChart(),
                    ),
                    20.0.height,
                    const _AnalyticsSectionCard(
                      title: 'Spending by Category',
                      child: _SpendingByCategory(),
                    ),
                    20.0.height,
                    const _AnalyticsSectionCard(
                      title: 'Savings Trend',
                      child: _SavingsTrendChart(),
                    ),
                    20.0.height,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsAppBar extends StatelessWidget {
  const _AnalyticsAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.r,
          height: 36.r,
          decoration: BoxDecoration(
            color: AppColors.surface,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: AppColors.textPrimary,
          ),
        ),
        12.0.width,
        Text(
          'Analytics',
          style: AppFonts.boldBlack20,
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _SummaryCard(
            title: 'Avg. Monthly Income',
            amount: '\$5,142',
            changeLabel: '+8%',
            changeColor: AppColors.success,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SummaryCard(
            title: 'Avg. Monthly Expense',
            amount: '\$2,405',
            changeLabel: '-3%',
            changeColor: AppColors.error,
          ),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String amount;
  final String changeLabel;
  final Color changeColor;

  const _SummaryCard({
    required this.title,
    required this.amount,
    required this.changeLabel,
    required this.changeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.grey12,
          ),
          8.0.height,
          Text(
            amount,
            style: AppFonts.boldBlack22,
          ),
          6.0.height,
          Text(
            changeLabel,
            style: AppFonts.mediumPrimary12.copyWith(color: changeColor),
          ),
        ],
      ),
    );
  }
}

class _AnalyticsSectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _AnalyticsSectionCard({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.boldBlack18,
          ),
          16.0.height,
          child,
        ],
      ),
    );
  }
}

class _IncomeExpenseChart extends StatelessWidget {
  const _IncomeExpenseChart();

  @override
  Widget build(BuildContext context) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 180.h,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(months.length, (index) {
                final income = [5200.0, 5400.0, 5100.0, 5300.0, 5500.0, 5142.0];
                final expense = [2300.0, 2400.0, 2450.0, 2500.0, 2550.0, 2405.0];

                return BarChartGroupData(
                  x: index,
                  barsSpace: 6,
                  barRods: [
                    BarChartRodData(
                      toY: income[index] / 1000,
                      width: 10.w,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.income,
                    ),
                    BarChartRodData(
                      toY: expense[index] / 1000,
                      width: 10.w,
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.expense,
                    ),
                  ],
                );
              }),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= months.length) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          months[index],
                          style: AppFonts.grey12,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        16.0.height,
        Row(
          children: const [
            _LegendDot(
              color: AppColors.income,
              label: 'Income',
            ),
            SizedBox(width: AppSpacing.lg),
            _LegendDot(
              color: AppColors.expense,
              label: 'Expenses',
            ),
          ],
        ),
      ],
    );
  }
}

class _SpendingByCategory extends StatelessWidget {
  const _SpendingByCategory();

  @override
  Widget build(BuildContext context) {
    final categories = [
      _CategorySpending('Housing', 1200, AppColors.housing),
      _CategorySpending('Food', 450, AppColors.food),
      _CategorySpending('Transport', 280, AppColors.transport),
      _CategorySpending('Entertainment', 180, AppColors.entertainment),
      _CategorySpending('Health', 100, AppColors.health),
      _CategorySpending('Other', 200, AppColors.other),
    ];

    final total = categories.fold<double>(
      0,
      (prev, c) => prev + c.amount,
    );

    return Row(
      children: [
        SizedBox(
          width: 120.w,
          height: 120.w,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 34.r,
              sections: categories
                  .map(
                    (c) => PieChartSectionData(
                      color: c.color,
                      value: c.amount,
                      showTitle: false,
                      radius: 26.r,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        20.0.width,
        Expanded(
          child: Column(
            children: categories
                .map(
                  (c) => _CategoryRow(
                    label: c.label,
                    color: c.color,
                    amount: '\$${c.amount.toStringAsFixed(0)}',
                    percentage: '${((c.amount / total) * 100).round()}%',
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _SavingsTrendChart extends StatelessWidget {
  const _SavingsTrendChart();

  @override
  Widget build(BuildContext context) {
    final spots = [
      const FlSpot(0, 3.2),
      const FlSpot(1, 3.4),
      const FlSpot(2, 3.3),
      const FlSpot(3, 3.5),
      const FlSpot(4, 3.45),
      const FlSpot(5, 3.8),
    ];

    return SizedBox(
      height: 140.h,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            drawVerticalLine: false,
            horizontalInterval: 0.2,
            getDrawingHorizontalLine: (value) => FlLine(
              color: AppColors.divider,
              strokeWidth: 1,
            ),
          ),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.primary,
              barWidth: 3,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                color: AppColors.primary.withValues(alpha: 0.12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendDot({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        6.0.width,
        Text(
          label,
          style: AppFonts.grey12,
        ),
      ],
    );
  }
}

class _CategorySpending {
  final String label;
  final double amount;
  final Color color;

  _CategorySpending(this.label, this.amount, this.color);
}

class _CategoryRow extends StatelessWidget {
  final String label;
  final Color color;
  final String amount;
  final String percentage;

  const _CategoryRow({
    required this.label,
    required this.color,
    required this.amount,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          8.0.width,
          Expanded(
            child: Text(
              label,
              style: AppFonts.grey14,
            ),
          ),
          Text(
            amount,
            style: AppFonts.mediumBlack14,
          ),
          8.0.width,
          Text(
            percentage,
            style: AppFonts.grey12,
          ),
        ],
      ),
    );
  }
}

