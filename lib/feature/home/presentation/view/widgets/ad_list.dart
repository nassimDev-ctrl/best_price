import 'dart:async';
import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/feature/category/presentaion/view/pages/product_category_view.dart';
import 'package:best_price/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:best_price/feature/home/presentation/view/widgets/ad_item.dart';
import 'package:best_price/feature/product_details/presentation/view/product_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdList extends StatefulWidget {
  const  AdList({super.key});

  @override
  State<AdList> createState() => _AdListState();
}

class _AdListState extends State<AdList> {
  late final PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.93);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      final homeCubit = HomeCubit.get(context);
      if (homeCubit.bannersList.isEmpty) return;

      setState(() {
        _currentPage++;
        if (_currentPage >= homeCubit.bannersList.length) {
          _currentPage = 0;
        }
      });

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = HomeCubit.get(context);
    if (homeCubit.bannersList.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 180.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: homeCubit.bannersList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  final banner = homeCubit.bannersList[index];
                  if (banner.type != null) {
                    if (banner.type == 1) {
                      if (banner.itemId != null) {
                        HelperFunctions.navigateToScreen(
                          context,
                          ProductDetailsPage(id: banner.itemId!),
                        );
                      }
                    } else if (banner.type == 2) {
                      HelperFunctions.navigateToScreen(
                          context,
                          ProductCategoryView(
                              title: "", categoryId: banner.itemId!));
                    }
                  }
                },
                child: AdItem(
                  banner: homeCubit.bannersList[index],
                ),
              );
            },
          ),
          // Animated dot indicators
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                homeCubit.bannersList.length,
                (index) => _AnimatedDot(
                  isActive: index == _currentPage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedDot extends StatefulWidget {
  final bool isActive;

  const _AnimatedDot({
    required this.isActive,
  });

  @override
  State<_AnimatedDot> createState() => _AnimatedDotState();
}

class _AnimatedDotState extends State<_AnimatedDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: AppColor.greyText.withOpacity(0.5),
      end: AppColor.pirateGold,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(_AnimatedDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: widget.isActive ? 10.w : 8.w,
            height: widget.isActive ? 10.w : 8.w,
            decoration: BoxDecoration(
              color:
                  _colorAnimation.value ?? AppColor.greyText.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
