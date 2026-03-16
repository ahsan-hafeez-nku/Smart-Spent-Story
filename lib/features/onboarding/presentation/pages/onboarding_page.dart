import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';
import 'package:smart_spent_story/core/routes/route_names.dart';
import 'package:smart_spent_story/core/utils/app_utils.dart';
import 'package:smart_spent_story/shared/widgets/custom_button.dart';
import 'package:smart_spent_story/shared/widgets/custom_snackbar.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _currentStep = 0;
  int? _selectedIncomeRange;
  int? _selectedEarningType;
  final Set<int> _selectedTrackingOptions = {};
  DateTime? lastPressedAt;

  static const _totalSteps = 3;

  void _goNext() {
    if (!_canContinueForStep(_currentStep)) {
      _showMissingSelectionMessage();
      return;
    }

    if (_currentStep == _totalSteps - 1) {
      context.go(RouteNames.login);
      return;
    }

    setState(() {
      _currentStep++;
    });
  }

  void _goBack() {
    if (_currentStep == 0) return;
    setState(() {
      _currentStep--;
    });
  }

  bool _canContinueForStep(int step) {
    switch (step) {
      case 0:
        return _selectedIncomeRange != null;
      case 1:
        return _selectedEarningType != null;
      case 2:
        return _selectedTrackingOptions.isNotEmpty;
      default:
        return false;
    }
  }

  void _showMissingSelectionMessage() {
    CustomSnackBar.show(context,
        message: 'Please select at least one option to continue.',
        type: SnackBarType.info);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          AppUtils.handleBackPress(
            lastPressedAt: lastPressedAt,
            updateLastPressedAt: (time) => lastPressedAt = time,
            context: context,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _OnboardingProgress(
                    currentStep: _currentStep, totalSteps: _totalSteps),
                14.0.height,
                Text(
                  'Step ${_currentStep + 1} of $_totalSteps',
                  style: AppFonts.mediumGrey14,
                ),
                8.0.height,
                Text(
                  _titleForStep(_currentStep),
                  style: AppFonts.boldBlack24,
                ),
                24.0.height,
                Expanded(child: _buildStepContent()),
                24.0.height,
                _buildBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _titleForStep(int step) {
    switch (step) {
      case 0:
        return "What's your monthly income range?";
      case 1:
        return 'How do you earn?';
      case 2:
        return 'What do you want to track?';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _OptionsList(
          options: const [
            'Under \$2,000',
            '\$2,000 – \$5,000',
            '\$5,000 – \$10,000',
            'Over \$10,000',
          ],
          selectedIndex: _selectedIncomeRange,
          onOptionTap: (index) {
            setState(() {
              _selectedIncomeRange = index;
            });
          },
        );
      case 1:
        return _OptionsList(
          options: const [
            'Salary',
            'Freelance',
            'Business',
            'Mixed',
          ],
          selectedIndex: _selectedEarningType,
          onOptionTap: (index) {
            setState(() {
              _selectedEarningType = index;
            });
          },
        );
      case 2:
        return _MultiSelectOptionsList(
          options: const [
            'Expenses',
            'Investments',
            'Bills & Debts',
            'Everything',
          ],
          selectedIndexes: _selectedTrackingOptions,
          onToggle: (index) {
            setState(() {
              if (_selectedTrackingOptions.contains(index)) {
                _selectedTrackingOptions.remove(index);
              } else {
                _selectedTrackingOptions.add(index);
              }
            });
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomButtons() {
    final isLastStep = _currentStep == _totalSteps - 1;
    final canContinue = _canContinueForStep(_currentStep);

    if (_currentStep == 0) {
      return CustomButton(
        label: 'Continue',
        onPressed: canContinue ? _goNext : null,
        width: double.infinity,
      );
    }

    return Row(
      children: [
        Expanded(
          child: CustomButton(
            label: 'Back',
            onPressed: _goBack,
            isOutlined: true,
          ),
        ),
        16.0.width,
        Expanded(
          child: CustomButton(
            label: isLastStep ? 'Finish Setup' : 'Continue',
            onPressed: canContinue ? _goNext : null,
          ),
        ),
      ],
    );
  }
}

class _OnboardingProgress extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _OnboardingProgress({
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final isCompleted = index < currentStep;
        final isActive = index == currentStep;

        Color color;
        if (isCompleted || isActive) {
          color = AppColors.primary;
        } else {
          color = AppColors.divider;
        }

        return Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: index == totalSteps - 1 ? 0 : 8.w,
            ),
            height: 4.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}

class _OptionsList extends StatelessWidget {
  final List<String> options;
  final int? selectedIndex;
  final ValueChanged<int> onOptionTap;

  const _OptionsList({
    required this.options,
    required this.selectedIndex,
    required this.onOptionTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = index == selectedIndex;
        return _OptionCard(
          label: options[index],
          isSelected: isSelected,
          onTap: () => onOptionTap(index),
        );
      },
      separatorBuilder: (_, __) => 12.0.height,
    );
  }
}

class _MultiSelectOptionsList extends StatelessWidget {
  final List<String> options;
  final Set<int> selectedIndexes;
  final ValueChanged<int> onToggle;

  const _MultiSelectOptionsList({
    required this.options,
    required this.selectedIndexes,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: options.length,
      itemBuilder: (context, index) {
        final isSelected = selectedIndexes.contains(index);
        return _OptionCard(
          label: options[index],
          isSelected: isSelected,
          onTap: () => onToggle(index),
        );
      },
      separatorBuilder: (_, __) => 12.0.height,
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? const Color(0xFFE6F7F2) : AppColors.surface;
    final borderColor = isSelected ? AppColors.primary : AppColors.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 0.5),
        ),
        child: Text(
          label,
          style: AppFonts.mediumBlack16,
        ),
      ),
    );
  }
}
