import 'dart:math' as math;
import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/feature/home/data/models/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdItem extends StatefulWidget {
  const AdItem({
    super.key,
    required this.banner,
  });
  final HomeBanner? banner;

  @override
  State<AdItem> createState() => _AdItemState();
}

class _AdItemState extends State<AdItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _positionXAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Scale animation - pulsing effect
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Circular movement in X direction
    _positionXAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Rotation animation
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi, // Full rotation
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    // Opacity animation - blinking effect
    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Start animation if the ad is special
    if (widget.banner?.isSpecial == true) {
      _animationController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Parse color from API or use default
    Color backgroundColor = AppColor.corn;
    if (widget.banner?.color != null && widget.banner!.color!.isNotEmpty) {
      try {
        backgroundColor =
            Color(int.parse(widget.banner!.color!.replaceFirst('#', '0xff')));
      } catch (e) {
        // If parsing fails, use default color
        backgroundColor = AppColor.corn;
      }
    }

    final isSpecial = widget.banner?.isSpecial == true;

    Widget container = Container(
      margin: EdgeInsetsDirectional.only(
        end: 10.w,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        // Enhanced border for special ads
        border: isSpecial
            ? Border.all(
                color: Colors.yellow.withOpacity(0.6),
                width: 2,
              )
            : null,
        boxShadow: isSpecial
            ? [
                BoxShadow(
                  color: Colors.yellow.withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.orange.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 4,
                ),
              ]
            : null,
      ),
      child: Stack(
        children: [
          // Shimmer overlay for special ads
          if (isSpecial)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.0),
                          Colors.white
                              .withOpacity(_opacityAnimation.value * 0.15),
                          Colors.white.withOpacity(0.0),
                        ],
                        stops: const [
                          0.0,
                          0.5,
                          1.0,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 176.w,
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 22.h, start: 24.w),
                      child: Text(
                        widget.banner?.title ?? "",
                        style: AppStyles.textStyle20w700.copyWith(
                          fontWeight:
                              isSpecial ? FontWeight.w700 : FontWeight.w400,
                          color: Colors.white,
                          shadows: isSpecial
                              ? [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 143.w,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(start: 24.w),
                      child: Text(
                        widget.banner?.details ?? "",
                        style: AppStyles.textStyle12w700.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                  padding:
                      EdgeInsetsDirectional.only(top: 9.h, end: 2, bottom: 9.h),
                  child: CachedNetworkImage(
                    width: 130.w,
                    height: 150.h,
                    fit: BoxFit.scaleDown,
                    imageUrl: widget.banner?.image ?? "",
                  ))
            ],
          ),
          // "Special" badge for special ads

          // Animated colored ball if banner is special
          if (isSpecial)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                // Calculate circular movement using sin/cos for smooth path
                final angle = _positionXAnimation.value * 2 * math.pi;
                final radius = 20.0; // Slightly larger radius
                final xOffset = radius * math.sin(angle);
                final yOffset = radius * math.cos(angle);

                return Positioned(
                  top: 15.h + yOffset,
                  right: 15.w + xOffset,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Outer pulsing glow ring
                      Transform.scale(
                        scale: _scaleAnimation.value * 1.5,
                        child: Opacity(
                          opacity: _opacityAnimation.value * 0.3,
                          child: Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.yellow.withOpacity(0.0),
                                  Colors.orange.withOpacity(0.5),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Main animated ball
                      Transform.rotate(
                        angle: _rotationAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _opacityAnimation.value,
                            child: Container(
                              width: 16.w,
                              height: 16.w,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.yellow.shade200,
                                    Colors.yellow.shade400,
                                    Colors.orange.shade400,
                                  ],
                                  stops: const [0.0, 0.3, 0.7, 1.0],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.yellow.withOpacity(0.95),
                                    blurRadius: 18,
                                    spreadRadius: 5,
                                  ),
                                  BoxShadow(
                                    color: Colors.orange.withOpacity(0.7),
                                    blurRadius: 28,
                                    spreadRadius: 7,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );

    return container;
  }
}
