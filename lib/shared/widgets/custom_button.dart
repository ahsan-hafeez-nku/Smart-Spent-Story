import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool? arrowIcon;
  final double? textSize;

  const CustomButton(
      {super.key,
      required this.label,
      this.onPressed,
      this.isLoading = false,
      this.isOutlined = false,
      this.width = 150,
      this.height = 52,
      this.borderRadius = 12,
      this.textSize = 16,
      this.arrowIcon = false});

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: textSize?.sp,
                  fontWeight: FontWeight.w600,
                  color: isOutlined ? AppColors.primary : Colors.white,
                ),
              ),
              if (arrowIcon ?? false) ...[8.0.width, Icon(Icons.arrow_forward)]
            ],
          );

    if (isOutlined) {
      return SizedBox(
        width: width,
        height: height,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
          ),
          child: child,
        ),
      );
    }

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(borderRadius ?? AppSpacing.radiusMd),
          ),
          elevation: 0,
        ),
        child: child,
      ),
    );
  }
}
