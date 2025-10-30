import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/widgets/app_bar_row.dart';
import 'package:best_price/core/widgets/app_bottom.dart';
import 'package:best_price/core/widgets/whats_app_fab.dart';
import 'package:best_price/feature/cart/presentation/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:best_price/feature/home/presentation/view/widgets/products_list.dart';
import 'package:best_price/feature/product_details/presentation/manager/random_products_cubit/random_products_cubit.dart';
import 'package:best_price/feature/product_details/presentation/manager/rate_product_cubit/rate_product_cubit.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/widgets/custom_loading.dart';
import '../../../../core/widgets/custom_network_image_widget.dart';
import '../manager/product_details_cubit/product_details_cubit.dart';
import 'widget/small_photo_option_widget_new.dart';
import 'widget/video_player_widget.dart';
import 'widget/full_screen_image_viewer.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.id,
    this.phone,
  });
  final int id;
  final String? phone;
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<RandomProductsCubit>().getRandomProducts();
  }
// todo : finish translate

  final PageController pageController = PageController();
  int roundedRating = 0;

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) {
      return AppColor.containerBackColor;
    }
    String value = hex.replaceFirst('#', '').toUpperCase();
    if (value.length == 6) {
      value = 'FF$value';
    }
    final int? intVal = int.tryParse(value, radix: 16);
    if (intVal == null) {
      return AppColor.containerBackColor;
    }
    return Color(intVal);
  }

  // Helper method to get all image URLs
  List<String> _getImageUrls(ProductDetailsCubit cubit) {
    final images = cubit.productDetailsModel.data?.images;
    final fallbackImage = cubit.productDetailsModel.data?.image;

    List<String> imageUrls = [];

    if (images != null && images.isNotEmpty) {
      for (var image in images) {
        if (image.image != null && image.image!.isNotEmpty) {
          imageUrls.add(image.image!);
        }
      }
    } else if (fallbackImage != null && fallbackImage.isNotEmpty) {
      imageUrls.add(fallbackImage);
    }

    return imageUrls;
  }

  // Method to open full screen image viewer
  void _openFullScreenViewer(ProductDetailsCubit cubit, int initialIndex) {
    final imageUrls = _getImageUrls(cubit);
    if (imageUrls.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FullScreenImageViewer(
            imageUrls: imageUrls,
            initialIndex: initialIndex,
            productName: cubit.productDetailsModel.data?.name,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductDetailsCubit(widget.id),
      child: BlocConsumer<ProductDetailsCubit, ProductDetailsState>(
          listener: (BuildContext context, ProductDetailsState state) {},
          builder: (BuildContext context, ProductDetailsState state) {
            ProductDetailsCubit cubit = ProductDetailsCubit.get(context);

            // Calculate price based on selected variant or base product
            double price;
            double discountPrice;

            // Use variant price only if it exists and is greater than 0
            // Otherwise fall back to base product price
            if (cubit.selectedVariant?.id != null &&
                cubit.selectedVariant!.price != null &&
                cubit.selectedVariant!.price! > 0) {
              price = cubit.selectedVariant!.price!.toDouble();
              discountPrice =
                  (cubit.selectedVariant!.discountPrice ?? 0).toDouble();
            } else {
              price = (cubit.productDetailsModel.data?.price ?? 0).toDouble();
              discountPrice =
                  (cubit.productDetailsModel.data?.discountPrice ?? 0)
                      .toDouble();
            }

            double offerPrice = price - (price * discountPrice / 100);
            final hasVideo = cubit.productDetailsModel.data?.video != null;
            final images = cubit.productDetailsModel.data?.images;
            final hasImages = images != null && images.isNotEmpty;
            final fallbackImage = cubit.productDetailsModel.data?.image;
            final pageCount = (hasVideo ? 1 : 0) +
                (hasImages ? images!.length : (fallbackImage != null ? 1 : 0));
            return Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: Visibility(
                  visible: widget.phone != null,
                  child:
                      WhatsAppFloatingButton(phoneNumber: widget.phone ?? "")),
              body: state is ProductDetailsCubitLoading
                  ? Container(
                      // padding: EdgeInsets.only(top: 100),
                      alignment: Alignment.center,
                      child: const CustomLoading(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 14,
                              start: 16.w,
                              end: 16.w,
                            ),
                            child: AppBarRow(
                              title: "${cubit.productDetailsModel.data?.name}",
                              secondIconPath: IconsPath.buyIcon,
                              // thirdIconPath: IconsPath.favoriteIcon,
                              onSecondIconTap: () {
                                final variants =
                                    cubit.productDetailsModel.data?.variants ??
                                        [];
                                final hasVariants = variants.isNotEmpty;

                                // Check if variants exist and require selection
                                if (hasVariants &&
                                    cubit.selectedVariant?.id == null) {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message:
                                          "يرجى اختيار المقاس واللون أولاً",
                                      backgroundColor: Colors.red,
                                      textStyle: AppStyles.textStyle14.copyWith(
                                        color: AppColor.whiteColorOpacity,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                context.read<AddToCartCubit>().addToCart(
                                    cubit.productDetailsModel.data?.id
                                            .toString() ??
                                        "",
                                    cubit.quantity,
                                    variantId: cubit.selectedVariant?.id);
                              },
                              onThirdIconTap: () {},
                            ),
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: 16.w),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                color: AppColor.containerBackColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: PageView.builder(
                                    controller: pageController,
                                    itemCount: pageCount,
                                    onPageChanged: (index) {
                                      cubit.onChangeIndexImages(index);
                                    },
                                    itemBuilder: (context, index) {
                                      // https://demo1.weisro.com/assets/uploads/images/
                                      if (hasVideo && index == 0) {
                                        return VideoPlayerWidget(
                                          videoUrl: cubit.productDetailsModel
                                                  .data?.video ??
                                              "",
                                        );
                                      } else {
                                        final adjustedIndex =
                                            hasVideo ? index - 1 : index;

                                        if (hasImages && images != null) {
                                          final image = images[adjustedIndex];
                                          return GestureDetector(
                                            onTap: () {
                                              _openFullScreenViewer(
                                                  cubit, adjustedIndex);
                                            },
                                            child: Hero(
                                              tag:
                                                  'product_image_$adjustedIndex',
                                              child: CustomNetworkImageWidget(
                                                height: double.infinity,
                                                width: double.infinity,
                                                urlImage: image.image ?? "",
                                              ),
                                            ),
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              _openFullScreenViewer(cubit, 0);
                                            },
                                            child: Hero(
                                              tag: 'product_image_0',
                                              child: CustomNetworkImageWidget(
                                                height: double.infinity,
                                                width: double.infinity,
                                                urlImage: fallbackImage ?? "",
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 6,
                          ),
                          // ignore: prefer_is_empty
                          if ((cubit.productDetailsModel.data?.video != null) ||
                              (cubit.productDetailsModel.data?.images
                                      ?.isNotEmpty ??
                                  false))
                            Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Show video thumbnail if exists
                                    if (cubit.productDetailsModel.data?.video !=
                                        null)
                                      GestureDetector(
                                        onTap: () {
                                          cubit.onChangeIndexImages(0);
                                          pageController.animateToPage(
                                            0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeInOut,
                                          );
                                        },
                                        child: SmallPhotoOptionWidget(
                                          borderColor:
                                              cubit.indexImagesDetails == 0
                                                  ? AppColor.pirateGold
                                                  : AppColor.borderColor,
                                          imageUrl: '',
                                          isVideo: true,
                                        ),
                                      ),

                                    if (cubit.productDetailsModel.data?.video !=
                                            null &&
                                        (cubit.productDetailsModel.data?.images
                                                ?.isNotEmpty ??
                                            false))
                                      const SizedBox(width: 14),

                                    // Show image thumbnails
                                    for (int i = 0;
                                        i <
                                            (cubit.productDetailsModel.data
                                                    ?.images?.length ??
                                                0);
                                        i++)
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              // If video exists, images start from index 1
                                              final pageIndex = (cubit
                                                          .productDetailsModel
                                                          .data
                                                          ?.video !=
                                                      null)
                                                  ? i + 1
                                                  : i;

                                              cubit.onChangeIndexImages(
                                                  pageIndex);
                                              pageController.animateToPage(
                                                pageIndex,
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                curve: Curves.easeInOut,
                                              );
                                            },
                                            child: SmallPhotoOptionWidget(
                                              borderColor: cubit
                                                          .indexImagesDetails ==
                                                      ((cubit.productDetailsModel
                                                                  .data?.video !=
                                                              null)
                                                          ? i + 1
                                                          : i)
                                                  ? AppColor.pirateGold
                                                  : AppColor.borderColor,
                                              imageUrl: cubit
                                                      .productDetailsModel
                                                      .data
                                                      ?.images?[i]
                                                      .image ??
                                                  '',
                                              isVideo: false,
                                            ),
                                          ),
                                          const SizedBox(width: 14),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),

                          const SizedBox(
                            height: 14,
                          ),
                          //? product and company name section
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${cubit.productDetailsModel.data?.name}",
                                  style: AppStyles.textStyle24w700,
                                ),
                                // Text(
                                //   "${S.of(context).by} ${cubit.productDetailsModel.data?.companyName}",
                                //   style: AppStyles.textStyle16w700.copyWith(
                                //     color: AppColor.black2,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          //? variant selectors (size/color)
                          if ((cubit.productDetailsModel.data?.isHasVariant ??
                                  false) &&
                              (cubit.productDetailsModel.data?.variants
                                      ?.isNotEmpty ??
                                  false))
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Sizes
                                  Builder(builder: (context) {
                                    final variants = cubit.productDetailsModel
                                            .data?.variants ??
                                        [];
                                    final sizeMap = <int, dynamic>{};
                                    for (final v in variants) {
                                      final sz = v.size;
                                      if (sz?.id != null) {
                                        sizeMap[sz!.id!] = sz;
                                      }
                                    }
                                    final sizes = sizeMap.values.toList();
                                    if (sizes.isEmpty) {
                                      return const SizedBox.shrink();
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('المقاس',
                                            style: AppStyles.textStyle18w700),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            for (final sz in sizes)
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.setSize(sz.id as int);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    color: (cubit.sizeId ==
                                                            (sz.id as int))
                                                        ? AppColor.pirateGold
                                                        : AppColor
                                                            .containerBackColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    border: Border.all(
                                                      color: (cubit.sizeId ==
                                                              (sz.id as int))
                                                          ? AppColor.pirateGold
                                                          : AppColor
                                                              .borderColor,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    '${sz.name ?? ''}',
                                                    style: AppStyles
                                                        .textStyle16w700
                                                        .copyWith(
                                                      color: (cubit.sizeId ==
                                                              (sz.id as int))
                                                          ? Colors.white
                                                          : AppColor.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                  const SizedBox(height: 12),
                                  // Colors
                                  Builder(builder: (context) {
                                    final variants = cubit.productDetailsModel
                                            .data?.variants ??
                                        [];

                                    // Filter variants based on selected size
                                    final filteredVariants =
                                        variants.where((v) {
                                      if (cubit.sizeId == 0) return false;
                                      return v.size?.id == cubit.sizeId;
                                    }).toList();

                                    final colorMap = <int, dynamic>{};
                                    for (final v in filteredVariants) {
                                      final c = v.color;
                                      if (c?.id != null) {
                                        colorMap[c!.id!] = c;
                                      }
                                    }
                                    final colors = colorMap.values.toList();
                                    if (cubit.sizeId == 0) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('اللون',
                                              style: AppStyles.textStyle18w700),
                                          const SizedBox(height: 8),
                                          Text(
                                            'اختر المقاس أولاً',
                                            style: AppStyles.textStyle14
                                                .copyWith(
                                                    color: AppColor.greyText),
                                          ),
                                        ],
                                      );
                                    }
                                    if (colors.isEmpty) {
                                      return const SizedBox.shrink();
                                    }
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('اللون',
                                            style: AppStyles.textStyle18w700),
                                        const SizedBox(height: 8),
                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,
                                          children: [
                                            for (final c in colors)
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.setColor(c.id as int);
                                                },
                                                child: Container(
                                                  width: 36,
                                                  height: 36,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: _parseColor(
                                                        c.hash as String?),
                                                    border: Border.all(
                                                      color: (cubit.colorId ==
                                                              (c.id as int))
                                                          ? AppColor.pirateGold
                                                          : AppColor
                                                              .borderColor,
                                                      width: 2,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "قيّم المنتج", // Rate the product
                                  style: AppStyles.textStyle18w700,
                                ),
                                SizedBox(height: 8.h),
                                RatingBar.builder(
                                  initialRating: double.tryParse(cubit
                                              .productDetailsModel.data?.rate ??
                                          '0') ??
                                      0,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  unratedColor: Colors.grey.shade300,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {
                                    roundedRating = rating.ceil();
                                  },
                                ),
                                SizedBox(height: 12.h),
                                BlocConsumer<RateProductCubit,
                                    RateProductState>(
                                  listener: (context, state) {
                                    if (state is RateProductSuccess) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.success(
                                          message: "تم إرسال تقييمك بنجاح!",
                                          backgroundColor: AppColor.green,
                                        ),
                                      );
                                    } else if (state is RateProductFailures) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message: "خطا في ارسال التقيم",
                                          backgroundColor: AppColor.red,
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is RateProductLoading) {
                                      return const Center(
                                          child: CustomLoading());
                                    } else {
                                      return ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColor.buddhaGold),
                                        onPressed: () async {
                                          if (roundedRating == 0) {
                                            null;
                                          } else {
                                            await context
                                                .read<RateProductCubit>()
                                                .addRate(
                                                  context,
                                                  cubit.productDetailsModel.data
                                                          ?.id ??
                                                      0,
                                                  roundedRating,
                                                );
                                          }
                                        },
                                        child: Text("إرسال التقييم",
                                            style: TextStyle(fontSize: 14.sp)),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 16.h,
                          ),

                          SizedBox(
                            height: 16.h,
                          ),
                          //? description section
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).description,
                                  style: AppStyles.textStyle18w700,
                                ),
                                Html(
                                  data: cubit.productDetailsModel.data
                                          ?.description ??
                                      '',
                                  style: {
                                    "body": Style(
                                      fontSize: FontSize(16.sp),
                                      color: AppColor.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  },
                                ),
                              ],
                            ),
                          ),
                          //? ------------------------
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsetsDirectional.only(
                              top: 20,
                              start: 16,
                              end: 16,
                              bottom: 36.h,
                            ),
                            decoration: const BoxDecoration(
                                color: AppColor.secondGreyColor),
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.symmetric(
                                          horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Visibility(
                                            visible: offerPrice != price,
                                            child: Text(
                                              '${offerPrice.toStringAsFixed(2)} ل.س',
                                              style: AppStyles.textStyle20w700
                                                  .copyWith(
                                                color: AppColor.redOpacity,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${price.toStringAsFixed(2)} ل.س',
                                            style: AppStyles.textStyle14w700
                                                .copyWith(
                                              decoration: discountPrice > 0
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                              decorationColor:
                                                  AppColor.greyText,
                                              color: AppColor.greyText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              cubit.plusQuantity();
                                            },
                                            child: Container(
                                              height: 34,
                                              width: 34,
                                              color: Colors.amber,
                                              child: const Center(
                                                  child: Icon(
                                                size: 17,
                                                Icons.add,
                                                color: Colors.black,
                                              )),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          SizedBox(
                                            width: 60,
                                            child: TextFormField(
                                              controller:
                                                  cubit.quantityController,
                                              textAlign: TextAlign.center,
                                              keyboardType:
                                                  TextInputType.number,
                                              style: AppStyles.textStyle18w700,
                                              decoration: const InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8),
                                                border: OutlineInputBorder(),
                                              ),
                                              onChanged: (value) {
                                                final intVal =
                                                    int.tryParse(value);
                                                if (intVal != null &&
                                                    intVal >= 0) {
                                                  cubit.setQuantity(intVal);
                                                }
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // print("object");
                                              cubit.minQuantity();
                                            },
                                            child: Container(
                                              height: 34,
                                              width: 34,
                                              color: AppColor.greyText,
                                              child: Center(
                                                  child: Text('-',
                                                      style: AppStyles
                                                          .textStyle24)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                BlocConsumer<AddToCartCubit, AddToCartState>(
                                  listener: (context, state) {
                                    if (state is AddToCartSuccess) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.success(
                                          message:
                                              "تمت إضافة العنصر إلى سلة التسوق بنجاح!",
                                          backgroundColor: AppColor.green,
                                          textStyle:
                                              AppStyles.textStyle14.copyWith(
                                            color: AppColor.whiteColorOpacity,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      );
                                    } else if (state is AddToCartFailures) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                          message: state.error,
                                          backgroundColor: Colors.red,
                                          textStyle:
                                              AppStyles.textStyle14.copyWith(
                                            color: AppColor.whiteColorOpacity,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AddToCartLoading) {
                                      return const Center(
                                          child: CustomLoading());
                                    } else {
                                      final variants = cubit.productDetailsModel
                                              .data?.variants ??
                                          [];
                                      final hasVariants = variants.isNotEmpty;
                                      final isVariantSelected =
                                          cubit.selectedVariant?.id != null;

                                      // If product has variants, require both size and color to be selected

                                      return AppBottom(
                                        onTap: () {
                                          final product =
                                              cubit.productDetailsModel.data;

                                          // Validate variant selection if variants exist
                                          if (hasVariants &&
                                              !isVariantSelected) {
                                            showTopSnackBar(
                                              Overlay.of(context),
                                              CustomSnackBar.error(
                                                message:
                                                    "يرجى اختيار المقاس واللون أولاً",
                                                backgroundColor: Colors.red,
                                                textStyle: AppStyles.textStyle14
                                                    .copyWith(
                                                  color: AppColor
                                                      .whiteColorOpacity,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            );
                                            return;
                                          }

                                          context
                                              .read<AddToCartCubit>()
                                              .addToCart(
                                                  product?.id?.toString() ?? "",
                                                  cubit.quantity,
                                                  variantId: cubit
                                                      .selectedVariant?.id);
                                        },
                                        title: S.of(context).add_to_cart,
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Align(
                                  alignment: AlignmentDirectional.topStart,
                                  child: Text(
                                    "المنتجات المقترحة لك",
                                    style: AppStyles.textStyle18w700,
                                  ),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                BlocBuilder<RandomProductsCubit,
                                    RandomProductsState>(
                                  builder: (context, state) {
                                    if (state is RandomProductsSuccess) {
                                      return ProductsList(
                                          productList: state.products);
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            );
          }),
    );
  }
}
