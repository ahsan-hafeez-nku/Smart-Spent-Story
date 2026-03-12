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
import 'package:smart_spent_story/shared/widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSubmitting = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isSubmitting = false);
      context.go(RouteNames.onboarding);
    });
  }

  // String? _validateName(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter your full name';
  //   }
  //   if (value.trim().length < 2) {
  //     return 'Name looks too short';
  //   }
  //   return null;
  // }

  // String? _validateEmail(String? value) {
  //   if (value == null || value.trim().isEmpty) {
  //     return 'Please enter your email';
  //   }
  //   final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  //   if (!emailRegex.hasMatch(value.trim())) {
  //     return 'Please enter a valid email address';
  //   }
  //   return null;
  // }

  // String? _validatePassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please create a password';
  //   }
  //   if (value.length < 6) {
  //     return 'Password must be at least 6 characters';
  //   }
  //   return null;
  // }

  // String? _validateConfirmPassword(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Please confirm your password';
  //   }
  //   if (value != _passwordController.text) {
  //     return 'Passwords do not match';
  //   }
  //   return null;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: GoRouter.of(context).pop,
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.primary)),
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                ),
                20.0.height,
                Text(
                  'Create your Smart Spent account',
                  style: AppFonts.boldBlack24,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up to build better money habits, visualize your progress, and unlock AI-powered financial insights.',
                  style: AppFonts.grey14,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _nameController,
                  label: 'Full name',
                  hint: 'John Dow',
                  // validator: _validateName,
                ),
                const SizedBox(height: AppSpacing.xl),
                CustomTextField(
                  controller: _emailController,
                  label: AppStrings.email,
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  // validator: _validateEmail,
                ),
                const SizedBox(height: AppSpacing.xl),
                CustomTextField(
                  controller: _passwordController,
                  label: AppStrings.password,
                  hint: 'Create a strong password',
                  obscureText: true,
                  // validator: _validatePassword,
                ),
                const SizedBox(height: AppSpacing.xl),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm password',
                  hint: 'Re-enter your password',
                  obscureText: true,
                  // validator: _validateConfirmPassword,
                ),
                const SizedBox(height: AppSpacing.xxl),
                CustomButton(
                  label: AppStrings.signUp,
                  onPressed: _isSubmitting ? null : _onSubmit,
                  isLoading: _isSubmitting,
                  width: double.infinity,
                ),
                const SizedBox(height: AppSpacing.xxl),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.divider,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Text(
                      'Or continue with',
                      style: AppFonts.grey12,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: AppColors.divider,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xxl),
                _SocialButtonsRow(),
                const SizedBox(height: AppSpacing.xxxl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: AppFonts.grey14,
                    ),
                    TextButton(
                      onPressed: () => context.go(RouteNames.login),
                      child: Text(
                        AppStrings.signIn,
                        style: AppFonts.mediumPrimary14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _SocialButton(
            label: 'Google',
            icon: Icons.g_mobiledata_rounded,
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _SocialButton(
            label: 'Facebook',
            icon: Icons.facebook_rounded,
          ),
        ),
        // SizedBox(width: AppSpacing.md),
        // Expanded(
        //   child: _SocialButton(
        //     label: 'Apple',
        //     icon: Icons.apple_rounded,
        //   ),
        // ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _SocialButton({
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.border),
          color: AppColors.surface,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppFonts.mediumBlack14,
            ),
          ],
        ),
      ),
    );
  }
}
