import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';
import 'package:smart_spent_story/core/routes/route_names.dart';
import 'package:smart_spent_story/shared/widgets/custom_button.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  int _currentStep = 0;
  bool _isExpense = true;
  String _amountText = '0';
  int? _selectedCategoryIndex;
  final TextEditingController _noteController = TextEditingController();

  static const _totalSteps = 3;

  final List<_CategoryItem> _categories = const [
    _CategoryItem(Icons.fastfood_rounded, 'Food'),
    _CategoryItem(Icons.directions_car_rounded, 'Transport'),
    _CategoryItem(Icons.home_rounded, 'Housing'),
    _CategoryItem(Icons.movie_filter_rounded, 'Entertainment'),
    _CategoryItem(Icons.shopping_bag_rounded, 'Shopping'),
    _CategoryItem(Icons.health_and_safety_rounded, 'Health'),
    _CategoryItem(Icons.school_rounded, 'Education'),
    _CategoryItem(Icons.bolt_rounded, 'Utilities'),
    _CategoryItem(Icons.inbox_rounded, 'Other'),
  ];

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _toggleType(bool isExpense) {
    setState(() {
      _isExpense = isExpense;
    });
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'del') {
        if (_amountText.length > 1) {
          _amountText = _amountText.substring(0, _amountText.length - 1);
        } else {
          _amountText = '0';
        }
      } else if (value == '.') {
        if (!_amountText.contains('.')) {
          _amountText += '.';
        }
      } else {
        if (_amountText == '0') {
          _amountText = value;
        } else if (_amountText.length < 10) {
          _amountText += value;
        }
      }
    });
  }

  bool get _hasAmount => _amountText != '0' && _amountText != '0.';

  void _goNext() {
    if (_currentStep == 0 && !_hasAmount) return;
    if (_currentStep == 1 && _selectedCategoryIndex == null) return;

    if (_currentStep == _totalSteps - 1) {
      // TODO: wire to real add-transaction usecase.
      context.go(RouteNames.dashboard);
      return;
    }

    setState(() {
      _currentStep++;
    });
  }

  void _goBack() {
    if (_currentStep == 0) {
      context.pop();
      return;
    }
    setState(() {
      _currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: _goBack,
        ),
        title: Text(
          'Add Transaction',
          style: AppFonts.boldBlack18,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProgressBar(currentStep: _currentStep, totalSteps: _totalSteps),
              24.0.height,
              Expanded(child: _buildStepContent()),
              24.0.height,
              CustomButton(
                label: _currentStep == _totalSteps - 1
                    ? 'Save Transaction'
                    : 'Continue',
                onPressed: (_currentStep == 0 && !_hasAmount) ||
                        (_currentStep == 1 && _selectedCategoryIndex == null)
                    ? null
                    : _goNext,
                width: double.infinity,
                borderRadius: 26.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _AmountStep(
          isExpense: _isExpense,
          amountText: _amountText,
          onToggleType: _toggleType,
          onKeyTap: _onKeyTap,
        );
      case 1:
        return _CategoryStep(
          categories: _categories,
          selectedIndex: _selectedCategoryIndex,
          onSelect: (index) {
            setState(() => _selectedCategoryIndex = index);
          },
        );
      case 2:
        final categoryLabel =
            _selectedCategoryIndex != null ? _categories[_selectedCategoryIndex!].label : 'Other';
        return _ReviewStep(
          isExpense: _isExpense,
          amountText: _amountText,
          categoryLabel: categoryLabel,
          noteController: _noteController,
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class _ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const _ProgressBar({
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

class _AmountStep extends StatelessWidget {
  final bool isExpense;
  final String amountText;
  final ValueChanged<bool> onToggleType;
  final ValueChanged<String> onKeyTap;

  const _AmountStep({
    required this.isExpense,
    required this.amountText,
    required this.onToggleType,
    required this.onKeyTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TypeToggle(
          isExpense: isExpense,
          onToggle: onToggleType,
        ),
        24.0.height,
        Text(
          'Enter amount',
          style: AppFonts.grey14,
        ),
        8.0.height,
        Text(
          '\$${amountText}',
          style: AppFonts.boldBlack32,
        ),
        24.0.height,
        Expanded(
          child: _NumberPad(
            onKeyTap: onKeyTap,
          ),
        ),
      ],
    );
  }
}

class _TypeToggle extends StatelessWidget {
  final bool isExpense;
  final ValueChanged<bool> onToggle;

  const _TypeToggle({
    required this.isExpense,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F4F0),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          _SegmentButton(
            label: 'Expense',
            isActive: isExpense,
            activeColor: AppColors.expense,
            onTap: () => onToggle(true),
          ),
          _SegmentButton(
            label: 'Income',
            isActive: !isExpense,
            activeColor: AppColors.primary,
            onTap: () => onToggle(false),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: isActive
                ? AppFonts.boldWhite16
                : AppFonts.mediumBlack14,
          ),
        ),
      ),
    );
  }
}

class _NumberPad extends StatelessWidget {
  final ValueChanged<String> onKeyTap;

  const _NumberPad({required this.onKeyTap});

  @override
  Widget build(BuildContext context) {
    final keys = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '.',
      '0',
      'del',
    ];

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 1.6,
      ),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        final key = keys[index];
        return _NumberKey(
          label: key == 'del' ? '' : key,
          icon: key == 'del' ? Icons.backspace_outlined : null,
          onTap: () => onKeyTap(key),
        );
      },
    );
  }
}

class _NumberKey extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const _NumberKey({
    required this.label,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F4F0),
          borderRadius: BorderRadius.circular(20.r),
        ),
        alignment: Alignment.center,
        child: icon != null
            ? Icon(icon, color: AppColors.textPrimary)
            : Text(
                label,
                style: AppFonts.boldBlack20,
              ),
      ),
    );
  }
}

class _CategoryStep extends StatelessWidget {
  final List<_CategoryItem> categories;
  final int? selectedIndex;
  final ValueChanged<int> onSelect;

  const _CategoryStep({
    required this.categories,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Where did this come from?',
          style: AppFonts.boldBlack20,
        ),
        24.0.height,
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];
              final isSelected = selectedIndex == index;
              return _CategoryCard(
                item: item,
                isSelected: isSelected,
                onTap: () => onSelect(index),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryItem {
  final IconData icon;
  final String label;

  const _CategoryItem(this.icon, this.label);
}

class _CategoryCard extends StatelessWidget {
  final _CategoryItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isSelected ? const Color(0xFFE6F7F2) : AppColors.surface;
    final borderColor = isSelected ? AppColors.primary : AppColors.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18.r),
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: borderColor),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: AppColors.background,
              child: Icon(
                item.icon,
                color: AppColors.primary,
                size: 20.sp,
              ),
            ),
            8.0.height,
            Text(
              item.label,
              style: AppFonts.mediumBlack12,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewStep extends StatelessWidget {
  final bool isExpense;
  final String amountText;
  final String categoryLabel;
  final TextEditingController noteController;

  const _ReviewStep({
    required this.isExpense,
    required this.amountText,
    required this.categoryLabel,
    required this.noteController,
  });

  @override
  Widget build(BuildContext context) {
    final typeText = isExpense ? 'Spending' : 'Earning';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                typeText,
                style: AppFonts.grey14,
              ),
              8.0.height,
              Text(
                '\$$amountText',
                style: AppFonts.boldBlack32.copyWith(
                  color: isExpense ? AppColors.expense : AppColors.primary,
                ),
              ),
              8.0.height,
              Text(
                'in $categoryLabel',
                style: AppFonts.grey14,
              ),
            ],
          ),
        ),
        24.0.height,
        Text(
          'Add a note (optional)',
          style: AppFonts.mediumBlack14,
        ),
        8.0.height,
        TextField(
          controller: noteController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'e.g., Lunch with team',
            hintStyle: AppFonts.grey14,
            filled: true,
            fillColor: const Color(0xFFF7F4F0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(14.w),
          ),
        ),
      ],
    );
  }
}

