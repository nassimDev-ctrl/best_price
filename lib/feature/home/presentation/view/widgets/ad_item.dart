import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/feature/home/data/models/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdItem extends StatelessWidget {
  const AdItem({
    super.key,
    required this.banner,
  });
  final HomeBanner? banner;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 180.h,
      margin: EdgeInsetsDirectional.only(
        end: 10.w,
      ),
      decoration: BoxDecoration(
          color: AppColor.corn, borderRadius: BorderRadius.circular(16.r)),
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
                    banner?.title ?? "",
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
                    banner?.details ?? "",
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
                imageUrl: banner?.image ?? "",
              ))
        ],
      ),
    );
  }
}
