import 'package:best_price/core/theme/app_color.dart';
import 'package:best_price/core/theme/app_style.dart';
import 'package:best_price/core/utils/constants.dart';
import 'package:best_price/core/utils/dimensions.dart';
import 'package:best_price/core/utils/helper_functions.dart';
import 'package:best_price/feature/auth/login/presentation/view/pages/login_page_view.dart';
import 'package:best_price/feature/best_selling/presntations/manager/best_selling_cubit/best_selling_cubit.dart';
import 'package:best_price/feature/best_selling/presntations/view/pages/best_selling_view.dart';
import 'package:best_price/feature/featured_products/presentation/manager/featured_products_cubit/featured_products_cubit.dart';
import 'package:best_price/feature/featured_products/presentation/view/pages/featured_products_view.dart';
import 'package:best_price/feature/home/presentation/manager/cubit/get_news_cubit.dart';
import 'package:best_price/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:best_price/feature/home/presentation/view/widgets/shimmer_ad_list.dart';
import 'package:best_price/feature/home/presentation/view/widgets/shimmer_category_home_list.dart';
import 'package:best_price/feature/home/presentation/view/widgets/shimmer_home_title.dart';
import 'package:best_price/feature/home/presentation/view/widgets/shimmer_let_start_text.dart';
import 'package:best_price/feature/home/presentation/view/widgets/shimmer_products_list.dart';
import 'package:best_price/feature/new_arrivals/presentations/manager/cubit/new_arrivals_cubit.dart';
import 'package:best_price/feature/new_arrivals/presentations/view/pages/new_arrivers_view.dart';
import 'package:best_price/feature/serach/presntation/view/pages/search_view.dart';
import 'package:best_price/feature/wish/presentation/manager/add_and_remove_from_favorite_cubit/add_and_remove_from_favorite_cubit.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marquee/marquee.dart';
import '../../../../../core/widgets/error_widget.dart';
import 'ad_list.dart';
import 'category_home_list.dart';
import 'home_title.dart';
import 'products_list.dart';

class HomePgeBody extends StatefulWidget {
  const HomePgeBody({super.key});

  @override
  State<HomePgeBody> createState() => _HomePgeBodyState();
}

class _HomePgeBodyState extends State<HomePgeBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context).getHomePage();
    BlocProvider.of<GetNewsCubit>(context).getAllNews();
  }

// todo : finish translate
  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    // homeCubit.getHomePage();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            HelperFunctions.navigateToScreen(context, const SearchView());
          },
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: 16.w, bottom: 9.h),
            child: SvgPicture.asset(
              colorFilter:
                  const ColorFilter.mode(AppColor.buddhaGold, BlendMode.srcIn),
              IconsPath.searchIcon,
              width: 24.w,
              fit: BoxFit.cover,
              height: 24.h,
            ),
          ),
        ),
        // centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.w, bottom: 9.h),
            child: Image.asset(IconsPath.splashLogo),
          )
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColor.corn,
          onRefresh: () async {
            homeCubit.getHomePage();
            BlocProvider.of<GetNewsCubit>(context).getAllNews();
          },
          child: SafeArea(
            child: BlocConsumer<HomeCubit, HomeCubitState>(
              listener: (context, state) {
                if (state is HomeCubitFailure) {
                  if (state.code == 401) {
                    HelperFunctions.navigateToScreenAndRemove(
                        context, const LoginView());
                  }
                }
              },
              builder: (context, state) {
                if (state is HomeCubitFailure) {
                  return CustomErrorWidget(
                    onTap: () async {
                      await homeCubit.getHomePage();
                      if (context.mounted) {
                        await BlocProvider.of<GetNewsCubit>(context)
                            .getAllNews();
                      }
                    },
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(height: 26.h),
                      BlocBuilder<HomeCubit, HomeCubitState>(
                        builder: (context, state) {
                          if (state is HomeCubitLoading) {
                            return const ShimmerCategoryHomeList();
                          } else {
                            return Padding(
                              padding: EdgeInsetsDirectional.symmetric(
                                horizontal: Dimensions.dStartPadding.w,
                              ),
                              child: const CategoryHomeList(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 26.h),
                      BlocBuilder<GetNewsCubit, GetNewsState>(
                        builder: (context, state) {
                          if (state is GetNewsLoading) {
                            return const ShimmerLetStartText();
                          } else if (state is GetNewsSuccess) {
                            final newsData = state.allNews.data ?? [];
                            final allNewsText = newsData
                                .map((e) => e.content)
                                .where((content) =>
                                    content != null && content.isEmpty == false)
                                .join(' 🟠 ');
                            if (newsData.isEmpty) {
                              return const SizedBox();
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: SizedBox(
                                  height: 30.h,
                                  child: Marquee(
                                    text: allNewsText,
                                    style: AppStyles.textStyle17w700
                                        .copyWith(color: AppColor.black),
                                    scrollAxis: Axis.horizontal,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    blankSpace: 40.0,
                                    velocity: 50.0,
                                    pauseAfterRound: const Duration(seconds: 1),
                                    startPadding: 10.0,
                                    accelerationDuration:
                                        const Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration:
                                        const Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                ),
                              );
                            }
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          color: AppColor.corn,
                          onRefresh: () async {
                            homeCubit.getHomePage();
                            BlocProvider.of<GetNewsCubit>(context).getAllNews();
                          },
                          child: ListView(
                            padding: EdgeInsetsDirectional.symmetric(
                                horizontal: Dimensions.dStartPadding.w),
                            children: [
                              SizedBox(height: 15.h),
                              //!................ here Ad list .......
                              BlocConsumer<HomeCubit, HomeCubitState>(
                                listener: (context, state) {},
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerAdList();
                                  } else {
                                    return const AdList();
                                  }
                                },
                              ),

                              //! in this there ara margin ..
                              //? this category in home page ..

                              SizedBox(height: 30.h),
                              //! Featured products
                              BlocBuilder<HomeCubit, HomeCubitState>(
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerHomeTitle(title: "");
                                  } else {
                                    return HomeTitle(
                                      title: S
                                          .of(context)
                                          .featured_products, //'Featured products',
                                      onTap: () {
                                        BlocProvider.of<FeaturedProductsCubit>(
                                                context)
                                            .getFeaturedProducts();

                                        HelperFunctions.navigateToScreen(
                                            context,
                                            const FeaturedProductView());
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 16.h),
                              //! Featured products List
                              BlocBuilder<HomeCubit, HomeCubitState>(
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerProductsList();
                                  } else {
                                    // HelperFunctions.navigateToScreen(
                                    //                   context,
                                    //                   ProductDetailsPage(
                                    //                     id: productItem.id ?? 0,
                                    //                   ));
                                    return BlocBuilder<
                                        AddAndRemoveFromFavoriteCubit,
                                        AddAndRemoveFromFavoriteState>(
                                      builder: (context, state) {
                                        return ProductsList(
                                          productList:
                                              homeCubit.featuredProductsList,
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 30.h),

                              BlocBuilder<HomeCubit, HomeCubitState>(
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerHomeTitle(title: "");
                                  } else {
                                    return HomeTitle(
                                      title: S
                                          .of(context)
                                          .best_selling, //'Best Selling',
                                      onTap: () {
                                        BlocProvider.of<BestSellingCubit>(
                                                context)
                                            .getBestSellingProducts();

                                        HelperFunctions.navigateToScreen(
                                          context,
                                          const BestSellingView(),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 16.h),
                              // ! Best Selling List
                              BlocBuilder<HomeCubit, HomeCubitState>(
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerProductsList();
                                  } else {
                                    return BlocBuilder<
                                        AddAndRemoveFromFavoriteCubit,
                                        AddAndRemoveFromFavoriteState>(
                                      builder: (context, state) {
                                        return ProductsList(
                                          productList:
                                              homeCubit.bestSellerProductsList,
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 30.h),

                              // ! New Arrivals List
                              BlocBuilder<HomeCubit, HomeCubitState>(
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerHomeTitle(title: "");
                                  } else {
                                    return HomeTitle(
                                      title: S.of(context).new_arrivals,
                                      //'New Arrivals',
                                      onTap: () {
                                        BlocProvider.of<NewArrivalsCubit>(
                                                context)
                                            .getAllNewArrivalsProducts();

                                        HelperFunctions.navigateToScreen(
                                            context, const NewArriversView());
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 16.h),

                              BlocBuilder<HomeCubit, HomeCubitState>(
                                builder: (context, state) {
                                  if (state is HomeCubitLoading) {
                                    return const ShimmerProductsList();
                                  } else {
                                    return BlocBuilder<
                                        AddAndRemoveFromFavoriteCubit,
                                        AddAndRemoveFromFavoriteState>(
                                      builder: (context, state) {
                                        return ProductsList(
                                          productList:
                                              homeCubit.newstProductsList,
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 40.h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
// Padding(
                  //   padding: const EdgeInsetsDirectional.only(
                  //     start: 16,
                  //     end: 16,
                  //     top: 16,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       SvgPicture.asset(IconsPath.homeLogoIcon),
                  //       GestureDetector(
                  //         onTap: () {
                  //           HelperFunctions.navigateToScreen(
                  //               context, const SearchView());
                  //         },
                  //         child: SvgPicture.asset(IconsPath.searchIcon),
                  //       ),
                  //     ],
                  //   ),
                  // ),   
                  // Padding(
                        //   padding: EdgeInsets.only(top: 14.h),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       SvgPicture.asset(IconsPath.homeLogoIcon),
                        //       GestureDetector(
                        //           onTap: () {
                        //             HelperFunctions.navigateToScreen(
                        //                 context, const SearchView());
                        //           },
                        //           child: SvgPicture.asset(IconsPath.searchIcon)),
                        //     ],
                        //   ),
                        // ),
                        
                        
                          // SizedBox(height: 10.h),
                        // //!Brands
                        // BlocBuilder<HomeCubit, HomeCubitState>(
                        //   builder: (context, state) {
                        //     if (state is HomeCubitLoading) {
                        //       return const ShimmerHomeTitle(title: "");
                        //     } else {
                        //       return HomeTitle(
                        //         title: S.of(context).brands, //'Brands',
                        //         onTap: () {
                        //           HelperFunctions.navigateToScreen(
                        //               context, const BrandsView());
                        //         },
                        //       );
                        //     }
                        //   },
                        // ),
                        // SizedBox(height: 12.h),
                        // //! brands List
                        // BlocBuilder<HomeCubit, HomeCubitState>(
                        //   builder: (context, state) {
                        //     if (state is HomeCubitLoading) {
                        //       return const ShimmerBrandsHomeList();
                        //     } else {
                        //       return const BrandsHomeList();
                        //     }
                        //   },
                        // ),
                        // SizedBox(height: 20.h),
                         // SizedBox(height: 26.h),
                        // BlocBuilder<HomeCubit, HomeCubitState>(
                        //   builder: (context, state) {
                        //     if (state is HomeCubitLoading) {
                        //       return const ShimmerHomeTitle(
                        //         title: "",
                        //       );
                        //     } else {
                        //       return HomeTitle(
                        //         title: S.of(context).categories, //'Categories',
                        //         onTap: () {
                        //           navBarCubit.changeTab(1, context);
                        //         },
                        //       );
                        //     }
                        //   },
                        // ),