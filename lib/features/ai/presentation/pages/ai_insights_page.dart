import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';

class AiInsightsPage extends StatelessWidget {
  const AiInsightsPage({super.key});

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
                  children: const [
                    _AiInsightsHeader(),
                    SizedBox(height: AppSpacing.lg),
                    _HealthScoreCard(),
                    SizedBox(height: AppSpacing.xl),
                    _RecentInsightsSection(),
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

class _AiInsightsHeader extends StatelessWidget {
  const _AiInsightsHeader();

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
        const Icon(
          Icons.auto_awesome_rounded,
          color: AppColors.primary,
          size: 20,
        ),
        8.0.width,
        Text(
          'AI Insights',
          style: AppFonts.boldBlack20,
        ),
      ],
    );
  }
}

class _HealthScoreCard extends StatelessWidget {
  const _HealthScoreCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFA726),
            Color(0xFFFF7043),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                  6.0.width,
                  Text(
                    'Financial Health Score',
                    style: AppFonts.mediumWhite14,
                  ),
                ],
              ),
              Icon(
                Icons.more_horiz_rounded,
                color: Colors.white.withOpacity(0.9),
                size: 22,
              ),
            ],
          ),
          18.0.height,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '78',
                style: AppFonts.boldWhite32,
              ),
              4.0.width,
              Text(
                '/100',
                style: AppFonts.mediumWhite14,
              ),
            ],
          ),
          12.0.height,
          Text(
            'Your financial health is good. Focus on reducing dining expenses to improve your score.',
            style: AppFonts.mediumWhite12.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentInsightsSection extends StatelessWidget {
  const _RecentInsightsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Insights',
          style: AppFonts.boldBlack18,
        ),
        const SizedBox(height: AppSpacing.lg),
        const _InsightCard(
          title: 'Overspending Alert',
          subtitle:
              'You’ve spent 35% more on dining out this month compared to your average. Consider cooking at home to save ~\$120/month.',
          timeAgo: '2h ago',
          icon: Icons.warning_amber_rounded,
          backgroundColor: Color(0xFFFFF8E5),
          iconBackgroundColor: Color(0xFFFFF0CC),
          iconColor: Color(0xFFFFA726),
        ),
        const SizedBox(height: AppSpacing.md),
        const _InsightCard(
          title: 'Savings Milestone',
          subtitle:
              'Great job! Your savings rate increased to 45% of income — your best in 6 months!',
          timeAgo: '1d ago',
          icon: Icons.emoji_events_rounded,
          backgroundColor: Color(0xFFE6FFF5),
          iconBackgroundColor: Color(0xFFD2FBE8),
          iconColor: AppColors.primary,
        ),
        const SizedBox(height: AppSpacing.md),
        const _InsightCard(
          title: 'Cash Flow Risk',
          subtitle:
              'Based on upcoming bills (\$1,345) and your current balance, you may be short by ~\$200 next week. Consider deferring non-essential spending.',
          timeAgo: '1d ago',
          icon: Icons.trending_down_rounded,
          backgroundColor: Color(0xFFFFE6E9),
          iconBackgroundColor: Color(0xFFFFD4DA),
          iconColor: AppColors.error,
        ),
        const SizedBox(height: AppSpacing.md),
        const _InsightCard(
          title: 'Smart Suggestion',
          subtitle:
              'You have 3 active subscriptions totaling \$45/month. Cancelling unused ones could save you \$540/year.',
          timeAgo: '3d ago',
          icon: Icons.lightbulb_outline_rounded,
          backgroundColor: Color(0xFFEDE9FF),
          iconBackgroundColor: Color(0xFFDCD4FF),
          iconColor: AppColors.primary,
        ),
        const SizedBox(height: AppSpacing.md),
        const _InsightCard(
          title: 'Budget on Track',
          subtitle:
              'Your grocery spending is 8% under budget this month. Keep it up!',
          timeAgo: '4d ago',
          icon: Icons.check_circle_rounded,
          backgroundColor: Color(0xFFE8FFF0),
          iconBackgroundColor: Color(0xFFD6FBE1),
          iconColor: AppColors.success,
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String timeAgo;
  final IconData icon;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;

  const _InsightCard({
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppFonts.boldBlack16,
                      ),
                    ),
                    8.0.width,
                    Text(
                      timeAgo,
                      style: AppFonts.grey12,
                    ),
                  ],
                ),
                6.0.height,
                Text(
                  subtitle,
                  style: AppFonts.grey14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

