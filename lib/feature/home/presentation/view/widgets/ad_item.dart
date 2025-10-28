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
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.7,
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

    Widget container = Container(
      // height: 180.h,
      margin: EdgeInsetsDirectional.only(
        end: 10.w,
      ),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 176.w,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(top: 22.h, start: 24.w),
                  child: Text(
                    widget.banner?.title ?? "",
                    style: AppStyles.textStyle20w700.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.white),
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
                        fontWeight: FontWeight.w400, color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          // SizedBox(width: 20.w),
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
    );

    // Wrap with animation if the ad is special
    if (widget.banner?.isSpecial == true) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _opacityAnimation.value,
              child: container,
            ),
          );
        },
      );
    }

    return container;
  }
}
