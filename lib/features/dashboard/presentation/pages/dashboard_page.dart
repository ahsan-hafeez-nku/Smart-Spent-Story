import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
                    _Header(),
                    20.0.height,
                    _BalanceCard(),
                    24.0.height,
                    _AiInsightsSection(),
                    24.0.height,
                    _SpendingThisMonthSection(),
                    24.0.height,
                    _UpcomingBillsSection(),
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

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning 👋',
              style: AppFonts.grey12,
            ),
            4.0.height,
            Text(
              'Alex Johnson',
              style: AppFonts.boldBlack24,
            ),
          ],
        ),
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Text(
            'AJ',
            style: AppFonts.mediumPrimary14,
          ),
        ),
      ],
    );
  }
}

class _BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF27C3A5), Color(0xFF1E9F88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Balance',
            style: AppFonts.mediumWhite12,
          ),
          8.0.height,
          Text(
            '\$12,580.00',
            style: AppFonts.boldWhite32,
          ),
          16.0.height,
          Row(
            children: [
              Expanded(
                child: _BalancePill(
                  label: 'Income',
                  amount: '\$5,350',
                ),
              ),
              12.0.width,
              Expanded(
                child: _BalancePill(
                  label: 'Expenses',
                  amount: '\$2,430',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalancePill extends StatelessWidget {
  final String label;
  final String amount;

  const _BalancePill({
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppFonts.mediumWhite12,
          ),
          Text(
            amount,
            style: AppFonts.boldWhite16,
          ),
        ],
      ),
    );
  }
}

class _AiInsightsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI Insights',
          style: AppFonts.boldBlack18,
        ),
        12.0.height,
        _InsightCard(
          icon: Icons.warning_amber_rounded,
          backgroundColor: const Color(0xFFFFF5E5),
          iconColor: const Color(0xFFFFA726),
          text: 'You spent 35% more on dining this month',
        ),
        10.0.height,
        _InsightCard(
          icon: Icons.auto_awesome_rounded,
          backgroundColor: const Color(0xFFE8FFF5),
          iconColor: AppColors.primary,
          text: 'Great job! Savings up 12% from last month',
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final String text;

  const _InsightCard({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: iconColor,
            ),
          ),
          12.0.width,
          Expanded(
            child: Text(
              text,
              style: AppFonts.mediumBlack14,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpendingThisMonthSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Spending This Month',
          style: AppFonts.boldBlack18,
        ),
        12.0.height,
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 90.w,
                height: 90.w,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF5F5F5),
                      ),
                    ),
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: SweepGradient(
                          colors: [
                            AppColors.housing,
                            AppColors.food,
                            AppColors.transport,
                            AppColors.entertainment,
                            AppColors.health,
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 50.w,
                      height: 50.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              16.0.width,
              Expanded(
                child: Column(
                  children: const [
                    _SpendingRow(label: 'Housing', color: AppColors.housing, amount: '\$1200'),
                    _SpendingRow(label: 'Food', color: AppColors.food, amount: '\$450'),
                    _SpendingRow(label: 'Transport', color: AppColors.transport, amount: '\$280'),
                    _SpendingRow(label: 'Entertainment', color: AppColors.entertainment, amount: '\$180'),
                    _SpendingRow(label: 'Other', color: AppColors.other, amount: '\$320'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SpendingRow extends StatelessWidget {
  final String label;
  final Color color;
  final String amount;

  const _SpendingRow({
    required this.label,
    required this.color,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
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
        ],
      ),
    );
  }
}

class _UpcomingBillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upcoming Bills',
          style: AppFonts.boldBlack18,
        ),
        12.0.height,
        Row(
          children: const [
            Expanded(
              child: _UpcomingBillCard(
                icon: Icons.home_rounded,
                label: 'Rent',
                amount: '\$1200',
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _UpcomingBillCard(
                icon: Icons.bolt_rounded,
                label: 'Electricity',
                amount: '\$80',
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _UpcomingBillCard(
                icon: Icons.wifi_rounded,
                label: 'Internet',
                amount: '\$60',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _UpcomingBillCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String amount;

  const _UpcomingBillCard({
    required this.icon,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
          12.0.height,
          Text(
            label,
            style: AppFonts.mediumBlack14,
          ),
          4.0.height,
          Text(
            amount,
            style: AppFonts.boldBlack16,
          ),
        ],
      ),
    );
  }
}

