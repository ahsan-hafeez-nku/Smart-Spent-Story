import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_spent_story/core/constants/app_colors.dart';
import 'package:smart_spent_story/core/constants/app_fonts.dart';
import 'package:smart_spent_story/core/constants/app_spacing.dart';
import 'package:smart_spent_story/core/constants/app_strings.dart';
import 'package:smart_spent_story/core/extensions/sizedbox_extentions.dart';
import 'package:smart_spent_story/core/routes/route_names.dart';
import 'package:smart_spent_story/core/utils/app_utils.dart';
import 'package:smart_spent_story/shared/widgets/custom_button.dart';
import 'package:smart_spent_story/shared/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  DateTime? lastPressedAt;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _isSubmitting = true);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      context.go(RouteNames.dashboard);
    });
  }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.trim().isEmpty) return 'Please enter your email';
  //   if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim())) {
  //     return 'Please enter a valid email';
  //   }
  //   return null;
  // }

  // String? _validatePassword(String? value) {
  //   if (value == null || value.isEmpty) return 'Please enter your password';
  //   if (value.length < 6) return 'Minimum 6 characters';
  //   return null;
  // }

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
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  20.0.height,
                  _AppLogo(),
                  40.0.height,
                  Text('Log In', style: AppFonts.boldBlack24),
                  4.0.height,
                  Text(
                    'Access your account and take control of your finances.',
                    style: AppFonts.grey14,
                  ),
                  32.0.height,
                  CustomTextField(
                    controller: _emailController,
                    label: AppStrings.email,
                    hint: 'you@example.com',
                    keyboardType: TextInputType.emailAddress,
                    // validator: _validateEmail,
                  ),
                  AppSpacing.xl.height,
                  CustomTextField(
                    controller: _passwordController,
                    label: AppStrings.password,
                    hint: 'Enter your password',
                    obscureText: true,
                    // validator: _validatePassword,
                  ),
                  4.0.height,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(AppStrings.forgotPassword,
                          style: AppFonts.mediumPrimary14),
                    ),
                  ),
                  10.0.height,
                  CustomButton(
                    label: AppStrings.signIn,
                    onPressed: _isSubmitting ? null : _onSubmit,
                    isLoading: _isSubmitting,
                    width: double.infinity,
                  ),
                  AppSpacing.xxl.height,
                  _Divider(),
                  AppSpacing.xxl.height,
                  _SocialButtonsRow(),
                  AppSpacing.xxxl.height,
                  _SignUpPrompt(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 100.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withValues(alpha: 0.6)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wallet_rounded, size: 45.sp, color: Colors.white),
            10.0.width,
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'Smart Spent\n',
                style: AppFonts.boldWhite24,
              ),
              TextSpan(
                text: 'Your Digital Expense Tracker',
                style: AppFonts.white12,
              ),
            ])),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(height: 1, color: AppColors.divider)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text('Or continue with', style: AppFonts.grey14),
        ),
        Expanded(child: Container(height: 1, color: AppColors.divider)),
      ],
    );
  }
}

class _SocialButtonsRow extends StatelessWidget {
  static const _socials = [
    (label: 'Google', icon: Icons.g_mobiledata_rounded),
    (label: 'Facebook', icon: Icons.facebook_rounded),
    // (label: 'Apple', icon: Icons.apple_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: _socials
          .expand((s) => [
                Expanded(child: _SocialButton(label: s.label, icon: s.icon)),
                if (s != _socials.last) 8.0.width,
              ])
          .toList(),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SocialButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.h,
          vertical: 12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
          color: AppColors.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16.sp, color: AppColors.textPrimary),
            SizedBox(width: AppSpacing.sm),
            Text(label, style: AppFonts.mediumBlack14),
          ],
        ),
      ),
    );
  }
}

class _SignUpPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?", style: AppFonts.grey14),
        TextButton(
          onPressed: () => context.push(RouteNames.register),
          child: Text(AppStrings.signUp, style: AppFonts.mediumPrimary14),
        ),
      ],
    );
  }
}
