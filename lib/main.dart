import 'package:best_price/core/cache/cache_helper.dart';
import 'package:best_price/core/utils/bloc_observer.dart';
import 'package:best_price/core/utils/fcm_helper.dart';
import 'package:best_price/core/utils/service_locator.dart';
import 'package:best_price/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:best_price/feature/account/presentation/manager/add_address/add_address_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/address_cubit/address_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/area_cubit/area_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/change_address_page/change_address_page_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/change_phone_cubit/change_phone_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/contact_us_cubit/contact_us_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/delete_address_cubit/delete_address_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/edit_account_cubit/edit_account_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/forget_password/forget_password_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/get_user_info_cubit/get_user_info_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/logout_cubit/logout_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/order_cubit/order_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/order_details_cubit/order_details_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/our_policy_tab_change/our_policy_tab_change_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/setting_cubit_cubit/setting_cubit_cubit.dart';
import 'package:best_price/feature/account/presentation/manager/static_page_cubit/static_page_cubit.dart';
import 'package:best_price/feature/auth/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:best_price/feature/auth/login/presentation/manager/cubit/login_cubit.dart';
import 'package:best_price/feature/auth/sign_up/presentation/manager/sign_up/sign_up_cubit.dart';
import 'package:best_price/feature/best_selling/presntations/manager/best_selling_cubit/best_selling_cubit.dart';
import 'package:best_price/feature/brands/presntations/manager/brands_cubit/brands_cubit.dart';
import 'package:best_price/feature/brands/presntations/manager/product_brands_cubit/product_brands_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/add_to_cart_cubit/add_to_cart_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/change_quantity_cubit/change_quantity_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/delete_from_my_cart_cubit/delete_from_my_cart_cubit.dart';
import 'package:best_price/feature/cart/presentation/manager/my_cart_cubit/my_cart_cubit.dart';
import 'package:best_price/feature/category/presentaion/manager/category_cubit/category_cubit.dart';
import 'package:best_price/feature/category/presentaion/manager/category_product_cubit/category_product_cubit.dart';
import 'package:best_price/feature/cheack_out/presntation/manager/selected_address_cubit/selected_address_cubit.dart';
import 'package:best_price/feature/featured_products/presentation/manager/featured_products_cubit/featured_products_cubit.dart';
import 'package:best_price/feature/home/presentation/manager/cubit/get_news_cubit.dart';
import 'package:best_price/feature/home/presentation/manager/cubit/home_cubit.dart';
import 'package:best_price/feature/home/presentation/manager/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:best_price/feature/new_arrivals/presentations/manager/cubit/new_arrivals_cubit.dart';
import 'package:best_price/feature/on_boarding/presentation/manager/cubit/on_boarding_cubit.dart';
import 'package:best_price/feature/product_details/presentation/manager/random_products_cubit/random_products_cubit.dart';
import 'package:best_price/feature/product_details/presentation/manager/rate_product_cubit/rate_product_cubit.dart';
import 'package:best_price/feature/serach/presntation/manager/cubit/search_cubit.dart';
import 'package:best_price/feature/splash/presentation/manager/connectivity_cubit/connectivity_cubit.dart';
import 'package:best_price/feature/splash/presentation/manager/lang_cubit/lang_cubit.dart';
import 'package:best_price/feature/splash/presentation/view/pages/splash.dart';
import 'package:best_price/feature/stores/presntation/managers/get_all_products_for_store_cubit/get_all_products_for_store_cubit.dart';
import 'package:best_price/feature/stores/presntation/managers/get_all_products_for_store_cubit/get_all_stores_cubit.dart';
import 'package:best_price/feature/wish/presentation/manager/add_and_remove_from_favorite_cubit/add_and_remove_from_favorite_cubit.dart';
import 'package:best_price/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'feature/product_details/presentation/manager/product_details_cubit/product_details_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up Firebase Cloud Messaging background handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Initialize FCM Helper
  await FcmHelper.instance.initialize();

  await CacheHelper.cacheInit();
  setupServiceLocator();
  // CacheHelper.clearCashe();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LangCubit(),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(),
        ),
        BlocProvider(
          create: (context) => OnBoardingCubit(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(),
        ),
        BlocProvider(
          create: (context) => ChangeAddressPageCubit(),
        ),
        BlocProvider(
          create: (context) => AddAddressCubit(),
        ),
        BlocProvider(
          create: (context) => SendForgetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => OurPolicyTabChangeCubit(),
        ),
        BlocProvider(
          create: (context) => ContactUsCubit(),
        ),
        BlocProvider(
          create: (context) => NavBarCubit(),
        ),
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => GetNewsCubit(),
        ),
        // BlocProvider(
        //   create: (context) => FlitterCubit(),
        // ),
        BlocProvider(
          create: (context) => SendForgetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => CategoryCubit()..fetchAllCategory(),
        ),
        BlocProvider(
          create: (context) => CategoryProductCubit(),
        ),
        BlocProvider(
          create: (context) => EditAccountCubit(),
        ),
        BlocProvider(
          create: (context) => BrandsCubit()..fetchAllBrands(),
        ),
        BlocProvider(
          create: (context) => FeaturedProductsCubit(),
        ),
        BlocProvider(
          create: (context) => BestSellingCubit(),
        ),
        BlocProvider(
          create: (context) => NewArrivalsCubit(),
        ),
        BlocProvider(
          create: (context) => ProductBrandsCubit(),
        ),
        BlocProvider(
          create: (context) => StaticPageCubit(),
        ),

        BlocProvider(
          create: (context) => ChangeQuantityCubit(),
        ),
        BlocProvider(
          create: (context) => SettingCubitCubit()..getLinks(),
        ),
        BlocProvider(
          create: (context) => ForgetPasswordCubit(),
        ),
        BlocProvider(
          create: (context) => LogoutCubit(),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => SelectedAddressCubit(),
        ),
        BlocProvider(
          create: (context) => OrderDetailsCubit(),
        ),
        BlocProvider(
          create: (context) => AddAndRemoveFromFavoriteCubit(),
        ),
        BlocProvider(
          create: (context) => OrderCubit()..getAllMyOrder(),
        ),
        BlocProvider(
          create: (context) => AreaCubit()..getAllArea(),
        ),
        BlocProvider(
          create: (context) => DeleteAddressCubit(),
        ),
        BlocProvider(create: (context) => AddressCubit()),
        BlocProvider(
          create: (context) => MyCartCubit()..getMyCart(context),
        ),
        BlocProvider(
          create: (context) => ProductDetailsCubit(0),
        ),
        BlocProvider(
          create: (context) => AddToCartCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteFromMyCartCubit(),
        ),
        BlocProvider(
          create: (context) => RateProductCubit(),
        ),
        BlocProvider(
          create: (context) => GetAllStoresCubit(),
        ),
        BlocProvider(
          create: (context) => GetAllProductsForStoreCubit(),
        ),
        BlocProvider(
          create: (context) => GetUserInfoCubit(),
        ),
        BlocProvider(
          create: (context) => RandomProductsCubit(),
        ),
        BlocProvider(
          create: (context) => ChangePhoneCubit(),
        ),
      ],
      child: BlocBuilder<LangCubit, LangState>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
                // locale: Locale(BlocProvider.of<LangCubit>(context).lang),
                locale: Locale(BlocProvider.of<LangCubit>(context).lang),
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                debugShowCheckedModeBanner: false,
                title: 'Ghina Shop',
                theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  useMaterial3: false,
                ),
                // home: const SplashView(),
                home: const SplashView()
                // home: const ProductDetailsPage(),
                ),
          );
        },
      ),
    );
  }
}
