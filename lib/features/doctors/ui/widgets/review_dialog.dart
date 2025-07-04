import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/features/doctors/presentation/cubit/review_cubit.dart';

import '../../../../core/helpers/show_custom_snack_bar.dart';

class ReviewDialog extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String? reviewId;
  final double? initialRating;
  final String? initialComment;

  const ReviewDialog({
    super.key,
    required this.doctorId,
    required this.doctorName,
    this.reviewId,
    this.initialRating,
    this.initialComment,
  });

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog>
    with SingleTickerProviderStateMixin {
  late double _rating;
  final TextEditingController _commentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating ?? 3.0;
    _commentController.text = widget.initialComment ?? '';

    // Initialize animation controller
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocListener<ReviewCubit, ReviewState>(
      listener: (context, state) {
        if (state is ReviewSubmitSuccess || state is ReviewUpdateSuccess) {
          Navigator.pop(context, true);
          showCustomSnackBar(
        state is ReviewSubmitSuccess
            ? 'Review submitted successfully'
            : 'Review updated successfully',
        context,
          );
        } else if (state is ReviewError) {
          showCustomSnackBar(state.message, context, isError: true);
        }
      },
      child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha:0.1),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Stack(
                children: [
                  // Background decorative elements
                  Positioned(
                    top: -20,
                    right: -20,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor:
                          AppColors.secondaryColor.withValues(alpha:0.1),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -30,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.primaryColor.withValues(alpha:0.1),
                    ),
                  ),

                  // Main content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header with close button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 24),
                              Expanded(
                                child: FadeInDown(
                                  duration: const Duration(milliseconds: 400),
                                  child: Center(
                                    child: Text(
                                      widget.reviewId == null
                                          ? 'Rate Your Experience'
                                          : 'Update Your Review',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Gap(8),
                          FadeInDown(
                            delay: const Duration(milliseconds: 150),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    AppColors.secondaryColor.withValues(alpha:0.1),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                'Dr. ${widget.doctorName}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),

                          const Gap(24),
                          // Star rating with animation
                          FadeInDown(
                            delay: const Duration(milliseconds: 200),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha:0.1),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  final starValue = index + 1;
                                  final isSelected = starValue <= _rating;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _rating = starValue.toDouble();
                                      });
                                    },
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween(
                                        begin: 0.0,
                                        end: isSelected ? 1.0 : 0.0,
                                      ),
                                      duration:
                                          const Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      builder: (context, value, child) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Icon(
                                            isSelected
                                                ? Icons.star_rounded
                                                : Icons.star_border_rounded,
                                            size: 30 + (value * 4),
                                            color: Color.lerp(
                                              Colors.grey,
                                              AppColors.secondaryColor,
                                              value,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),

                          const Gap(24),
                          // Comment field with enhanced styling
                          FadeInDown(
                            delay: const Duration(milliseconds: 250),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withValues(alpha:0.1),
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: _commentController,
                                decoration: InputDecoration(
                                  hintText:
                                      'Share your experience with the doctor...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 13,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.all(20),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.only(
                                        left: 15,
                                        right: 10,
                                        top: 12,
                                        bottom: 10),
                                    child: Icon(
                                      Icons.rate_review_outlined,
                                      color: AppColors.secondaryColor,
                                    ),
                                  ),
                                ),
                                maxLines: 4,
                                maxLength: 200,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please share your feedback';
                                  }
                                  if (value.length < 3) {
                                    return 'Comment is too short';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),

                          const Gap(30),
                          // Enhanced buttons
                          FadeInUp(
                            delay: const Duration(milliseconds: 300),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.grey.shade700,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        side: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 2,
                                  child: BlocBuilder<ReviewCubit, ReviewState>(
                                    builder: (context, state) {
                                      return ElevatedButton(
                                        onPressed: state is ReviewSubmitting
                                            ? null
                                            : () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  if (widget.reviewId != null) {
                                                    context
                                                        .read<ReviewCubit>()
                                                        .updateReview(
                                                          reviewId:
                                                              widget.reviewId!,
                                                          rating: _rating,
                                                          comment:
                                                              _commentController
                                                                  .text
                                                                  .trim(),
                                                        );
                                                  } else {
                                                    context
                                                        .read<ReviewCubit>()
                                                        .createReview(
                                                          doctorId:
                                                              widget.doctorId,
                                                          rating: _rating,
                                                          comment:
                                                              _commentController
                                                                  .text
                                                                  .trim(),
                                                        );
                                                  }
                                                }
                                              },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          foregroundColor: Colors.white,
                                          elevation:
                                              state is ReviewSubmitting ? 0 : 2,
                                          shadowColor: AppColors.primaryColor
                                              .withValues(alpha:0.5),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                        ),
                                        child: state is ReviewSubmitting
                                            ? const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Gap(8),
                                                  Text(
                                                    'Submitting...',
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Row(
                                              mainAxisAlignment:
                                                MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                widget.reviewId == null
                                                  ? 'Submit Review'
                                                  : 'Update Review',
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                    FontWeight.bold,
                                                ),
                                                ),
                                                const Gap(8),
                                                Icon(
                                                widget.reviewId == null
                                                  ? Icons.send_rounded
                                                  : Icons.update_rounded,
                                                size: 20,
                                                ),
                                              ],
                                              ),
                                          );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
