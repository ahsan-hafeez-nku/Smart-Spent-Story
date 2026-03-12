import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/constants/app_strings.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';
import 'package:smart_spent_story/core/routes/route_names.dart';
import 'package:smart_spent_story/shared/widgets/custom_button.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late final PageController _pageController;
  int _currentPage = 0;

  static const _totalPages = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage == _totalPages - 1) {
      context.go(RouteNames.login);
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: const [
                  _IntroSlide(
                    icon: Icons.account_balance_wallet_rounded,
                    iconBackgroundColors: [
                      Color(0xFF2EBD9E),
                      Color(0xFF28A58A),
                    ],
                    title: 'Track Every Penny',
                    subtitle:
                        'Effortlessly log income and expenses.\nNo accounting degree needed.',
                  ),
                  _IntroSlide(
                    icon: Icons.trending_up_rounded,
                    iconBackgroundColors: [
                      Color(0xFF7C4DFF),
                      Color(0xFF536DFE),
                    ],
                    title: 'Grow Your Wealth',
                    subtitle:
                        'Monitor investments, spot trends, and\nmake smarter financial decisions.',
                  ),
                  _IntroSlide(
                    icon: Icons.auto_graph_rounded,
                    iconBackgroundColors: [
                      Color(0xFFFF9800),
                      Color(0xFFFFB74D),
                    ],
                    title: 'AI-Powered Insights',
                    subtitle:
                        'Get personalized alerts, spending analysis,\nand financial forecasts.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _IntroIndicator(currentIndex: _currentPage),
                  CustomButton(
                    label: _currentPage == _totalPages - 1
                        ? AppStrings.getStarted
                        : AppStrings.next,
                    onPressed: _onNextPressed,
                    arrowIcon: _currentPage == _totalPages - 1,
                    borderRadius: 26.r,
                    width: _currentPage == _totalPages - 1 ? 160.w : 120.w,
                    textSize: 16.sp,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _IntroSlide extends StatelessWidget {
  final IconData icon;
  final List<Color> iconBackgroundColors;
  final String title;
  final String subtitle;

  const _IntroSlide({
    required this.icon,
    required this.iconBackgroundColors,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
            gradient: LinearGradient(
              colors: iconBackgroundColors,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: [
              BoxShadow(
                color: iconBackgroundColors.last.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Icon(
            icon,
            size: 64.sp,
            color: Colors.white,
          ),
        ),
        32.0.height,
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppFonts.boldBlack24,
        ),
        4.0.height,
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: AppFonts.grey14,
        ),
      ],
    );
  }
}

class _IntroIndicator extends StatelessWidget {
  final int currentIndex;

  const _IntroIndicator({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.only(right: 8),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}

