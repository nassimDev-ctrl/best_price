import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/dimensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/small_container.dart';

class ProductsItem extends StatelessWidget {
  const ProductsItem({
    super.key,
    required this.imageUrl,
    required this.brandName,
    required this.companyName,
    required this.price,
    required this.offerPrice,
    required this.title,
    required this.offerPercentage,
  });
  final String imageUrl, brandName, companyName, title;
  final num price, offerPercentage;
  final num? offerPrice;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            CachedNetworkImage(width: 160.w, height: 200.h, imageUrl: imageUrl),
            Positioned(
              bottom: 15.h,
              right: 6.w,
              child: const SmallContainer(
                imagePath: IconsPath.heartIcon,
                color: AppColor.yalow,
              ),
            )
          ],
        ),
        Padding(
          padding:
              EdgeInsetsDirectional.only(start: Dimensions.dStartPadding.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                offerPrice != null
                    ? offerPrice!.toStringAsFixed(3)
                    : price.toStringAsFixed(3),
                maxLines: 1,
                style: AppStyles.textStyle16w400.copyWith(
                    color: AppColor.redOpacity, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 5.h),
              Visibility(
                visible: offerPrice != null,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: price.toStringAsFixed(3),
                    style: const TextStyle(
                      color: AppColor.greyOpacity,
                      fontSize: 10,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.lineThrough,
                      height: 0.24,
                    ),
                  ),
                  TextSpan(
                    text: '(${offerPercentage.toStringAsFixed(1)}%)',
                    style: const TextStyle(
                      color: AppColor.greyOpacity,
                      fontSize: 10,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      height: 0.24,
                    ),
                  )
                ])),
              ),
              SizedBox(height: 5.h),
              Text(
                title,
                maxLines: 1,
                style:
                    AppStyles.textStyle14.copyWith(color: AppColor.greyOpacity),
              ),
              Text(
                brandName,
                maxLines: 1,
                style: AppStyles.textStyle14,
              ),
              Text(
                companyName,
                maxLines: 1,
                style: AppStyles.textStyle14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
