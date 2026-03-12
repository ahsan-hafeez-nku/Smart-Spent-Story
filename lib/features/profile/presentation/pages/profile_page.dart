import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        centerTitle: false,
        title: Text(
          'Profile',
          style: AppFonts.boldBlack18,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            children: [
              _ProfileHeaderCard(),
              16.0.height,
              _ProfileStatsRow(),
              24.0.height,
              _ProfileMenu(),
              16.0.height,
              _SignOutButton(),
              16.0.height,
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26.r,
            backgroundColor: AppColors.primary.withOpacity(0.12),
            child: Text(
              'AJ',
              style: AppFonts.mediumPrimary18,
            ),
          ),
          16.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Alex Johnson',
                  style: AppFonts.boldBlack16,
                ),
                4.0.height,
                Text(
                  'alex.johnson@email.com',
                  style: AppFonts.grey14,
                ),
                4.0.height,
                Text(
                  'Premium Member',
                  style: AppFonts.mediumPrimary12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StatCard(
            value: '6 mo',
            label: 'Tracked',
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            value: '284',
            label: 'Transactions',
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _StatCard(
            value: '\$8.2k',
            label: 'Saved',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({
    required this.value,
    required this.label,
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
          Text(
            value,
            style: AppFonts.boldBlack16,
          ),
          4.0.height,
          Text(
            label,
            style: AppFonts.grey12,
          ),
        ],
      ),
    );
  }
}

class _ProfileMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        _ProfileMenuItem(
          icon: Icons.person_outline,
          title: 'Personal Information',
          subtitle: 'Name, email, phone',
        ),
        _ProfileMenuItem(
          icon: Icons.notifications_none_rounded,
          title: 'Notifications',
          subtitle: 'Alerts and reminders',
        ),
        _ProfileMenuItem(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Bank Accounts',
          subtitle: 'Linked accounts',
        ),
        _ProfileMenuItem(
          icon: Icons.lock_outline_rounded,
          title: 'Security',
          subtitle: 'PIN, biometrics',
        ),
        _ProfileMenuItem(
          icon: Icons.help_outline_rounded,
          title: 'Help & Support',
          subtitle: 'FAQs, contact us',
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
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
            ),
          ),
          12.0.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFonts.mediumBlack14,
                ),
                2.0.height,
                Text(
                  subtitle,
                  style: AppFonts.grey12,
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.logout_rounded,
        color: Colors.redAccent,
      ),
      label: Text(
        'Sign Out',
        style: AppFonts.mediumPrimary16.copyWith(color: Colors.redAccent),
      ),
    );
  }
}
