// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `E-mail is required`
  String get email_required_validation {
    return Intl.message(
      'E-mail is required',
      name: 'email_required_validation',
      desc: '',
      args: [],
    );
  }

  /// `E-mail must contains @`
  String get email_contain_validation {
    return Intl.message(
      'E-mail must contains @',
      name: 'email_contain_validation',
      desc: '',
      args: [],
    );
  }

  /// `E-mail must be\n a valid email address`
  String get email_address_validation {
    return Intl.message(
      'E-mail must be\n a valid email address',
      name: 'email_address_validation',
      desc: '',
      args: [],
    );
  }

  /// `phone is required`
  String get phone_required_validation {
    return Intl.message(
      'phone is required',
      name: 'phone_required_validation',
      desc: '',
      args: [],
    );
  }

  /// `The Mobile must be between 8\n and 15 digits`
  String get phone_length_validation {
    return Intl.message(
      'The Mobile must be between 8\n and 15 digits',
      name: 'phone_length_validation',
      desc: '',
      args: [],
    );
  }

  /// `Full name is required`
  String get name_required_validation {
    return Intl.message(
      'Full name is required',
      name: 'name_required_validation',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get password_required_validation {
    return Intl.message(
      'Password is required',
      name: 'password_required_validation',
      desc: '',
      args: [],
    );
  }

  /// `The Password must be\n at least 8 characters.`
  String get password_length_validation {
    return Intl.message(
      'The Password must be\n at least 8 characters.',
      name: 'password_length_validation',
      desc: '',
      args: [],
    );
  }

  /// `this is required`
  String get this_required_validations {
    return Intl.message(
      'this is required',
      name: 'this_required_validations',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password is required`
  String get password_confirm_validation {
    return Intl.message(
      'Confirm password is required',
      name: 'password_confirm_validation',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Added to Wishlist`
  String get added_to_wishlist {
    return Intl.message(
      'Added to Wishlist',
      name: 'added_to_wishlist',
      desc: '',
      args: [],
    );
  }

  /// `No internet`
  String get no_internet {
    return Intl.message('No internet', name: 'no_internet', desc: '', args: []);
  }

  /// `No Added Address`
  String get no_added_address {
    return Intl.message(
      'No Added Address',
      name: 'no_added_address',
      desc: '',
      args: [],
    );
  }

  /// `Add Address for a Faster Checkout`
  String get add_address_for_a_faster_checkout {
    return Intl.message(
      'Add Address for a Faster Checkout',
      name: 'add_address_for_a_faster_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Add Address`
  String get add_address {
    return Intl.message('Add Address', name: 'add_address', desc: '', args: []);
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Old Password*`
  String get old_password_ {
    return Intl.message(
      'Old Password*',
      name: 'old_password_',
      desc: '',
      args: [],
    );
  }

  /// `new Password*`
  String get new_password_ {
    return Intl.message(
      'new Password*',
      name: 'new_password_',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password*`
  String get confirm_password_ {
    return Intl.message(
      'Confirm Password*',
      name: 'confirm_password_',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `You have successfully\nChanged Your Password`
  String get changed_password_dialog {
    return Intl.message(
      'You have successfully\nChanged Your Password',
      name: 'changed_password_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Change Password Error`
  String get change_password_error {
    return Intl.message(
      'Change Password Error',
      name: 'change_password_error',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Change Phone Number`
  String get change_phone_number {
    return Intl.message(
      'Change Phone Number',
      name: 'change_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `New Phone Number*`
  String get new_phone_number_ {
    return Intl.message(
      'New Phone Number*',
      name: 'new_phone_number_',
      desc: '',
      args: [],
    );
  }

  /// `Phone number updated successfully!`
  String get phone_updated_successfully {
    return Intl.message(
      'Phone number updated successfully!',
      name: 'phone_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number Error`
  String get change_phone_error {
    return Intl.message(
      'Change Phone Number Error',
      name: 'change_phone_error',
      desc: '',
      args: [],
    );
  }

  /// `About Ghina Shop`
  String get about_best_price {
    return Intl.message(
      'About Ghina Shop',
      name: 'about_best_price',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contact_us {
    return Intl.message('Contact Us', name: 'contact_us', desc: '', args: []);
  }

  /// `Full Name*`
  String get full_name_ {
    return Intl.message('Full Name*', name: 'full_name_', desc: '', args: []);
  }

  /// `Mobile Number*`
  String get mobile_number_ {
    return Intl.message(
      'Mobile Number*',
      name: 'mobile_number_',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email_ {
    return Intl.message('Email', name: 'email_', desc: '', args: []);
  }

  /// `Message*`
  String get message_ {
    return Intl.message('Message*', name: 'message_', desc: '', args: []);
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Ok`
  String get ok {
    return Intl.message('Ok', name: 'ok', desc: '', args: []);
  }

  /// `error`
  String get error {
    return Intl.message('error', name: 'error', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `Reach Out to Us`
  String get reach_out_to_us {
    return Intl.message(
      'Reach Out to Us',
      name: 'reach_out_to_us',
      desc: '',
      args: [],
    );
  }

  /// `edit Account`
  String get edit_account {
    return Intl.message(
      'edit Account',
      name: 'edit_account',
      desc: '',
      args: [],
    );
  }

  /// `Your Account Has been\nsuccessfully updated`
  String get success_update_message {
    return Intl.message(
      'Your Account Has been\nsuccessfully updated',
      name: 'success_update_message',
      desc: '',
      args: [],
    );
  }

  /// `Update Account`
  String get update_account {
    return Intl.message(
      'Update Account',
      name: 'update_account',
      desc: '',
      args: [],
    );
  }

  /// `Update Account Error`
  String get update_account_error {
    return Intl.message(
      'Update Account Error',
      name: 'update_account_error',
      desc: '',
      args: [],
    );
  }

  /// `Your Account Has not \nsuccessfully updated`
  String get failure_update_message {
    return Intl.message(
      'Your Account Has not \nsuccessfully updated',
      name: 'failure_update_message',
      desc: '',
      args: [],
    );
  }

  /// `update`
  String get update {
    return Intl.message('update', name: 'update', desc: '', args: []);
  }

  /// `My Account`
  String get my_account {
    return Intl.message('My Account', name: 'my_account', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `My Addresses`
  String get my_addresses {
    return Intl.message(
      'My Addresses',
      name: 'my_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Add New Address`
  String get add_new_address {
    return Intl.message(
      'Add New Address',
      name: 'add_new_address',
      desc: '',
      args: [],
    );
  }

  /// `show more`
  String get show_more {
    return Intl.message('show more', name: 'show_more', desc: '', args: []);
  }

  /// `show less`
  String get show_less {
    return Intl.message('show less', name: 'show_less', desc: '', args: []);
  }

  /// `Our Policy`
  String get our_policy {
    return Intl.message('Our Policy', name: 'our_policy', desc: '', args: []);
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Return Policy data .....`
  String get return_policy_data {
    return Intl.message(
      'Return Policy data .....',
      name: 'return_policy_data',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Ghina Shop We respect your privacy and are committed to protecting your personal information. This Privacy Policy is designed to help you understand how we collect, use, disclose, and safeguard your personal information. By using our website or mobile application, you consent to the practices described in this Privacy Policy.Information We CollectPersonal Information: We may collect personal information that you provide to us, such as your name, email address, postal address, phone number, and other similar information.Usage Information: We may collect information about your use of our services, including but not limited to your IP address, device information, browser type, and operating system.`
  String get welcome_policy_message {
    return Intl.message(
      'Welcome to Ghina Shop We respect your privacy and are committed to protecting your personal information. This Privacy Policy is designed to help you understand how we collect, use, disclose, and safeguard your personal information. By using our website or mobile application, you consent to the practices described in this Privacy Policy.Information We CollectPersonal Information: We may collect personal information that you provide to us, such as your name, email address, postal address, phone number, and other similar information.Usage Information: We may collect information about your use of our services, including but not limited to your IP address, device information, browser type, and operating system.',
      name: 'welcome_policy_message',
      desc: '',
      args: [],
    );
  }

  /// `Terminate Account`
  String get terminate_account {
    return Intl.message(
      'Terminate Account',
      name: 'terminate_account',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to terminate your\naccount?`
  String get terminate_message {
    return Intl.message(
      'Do you want to terminate your\naccount?',
      name: 'terminate_message',
      desc: '',
      args: [],
    );
  }

  /// `By terminating account, You will not be able to recover your account.`
  String get terminate_note_message {
    return Intl.message(
      'By terminating account, You will not be able to recover your account.',
      name: 'terminate_note_message',
      desc: '',
      args: [],
    );
  }

  /// `Terminate my Accounts`
  String get terminate_my_accounts {
    return Intl.message(
      'Terminate my Accounts',
      name: 'terminate_my_accounts',
      desc: '',
      args: [],
    );
  }

  /// `Terms & Conditions`
  String get terms_conditions {
    return Intl.message(
      'Terms & Conditions',
      name: 'terms_conditions',
      desc: '',
      args: [],
    );
  }

  /// `Address Title*`
  String get address_title_ {
    return Intl.message(
      'Address Title*',
      name: 'address_title_',
      desc: '',
      args: [],
    );
  }

  /// `Mobile No*`
  String get mobile_no_ {
    return Intl.message('Mobile No*', name: 'mobile_no_', desc: '', args: []);
  }

  /// `Select Area*`
  String get select_area_ {
    return Intl.message(
      'Select Area*',
      name: 'select_area_',
      desc: '',
      args: [],
    );
  }

  /// `Block No*`
  String get block_no_ {
    return Intl.message('Block No*', name: 'block_no_', desc: '', args: []);
  }

  /// `Street*`
  String get street_ {
    return Intl.message('Street*', name: 'street_', desc: '', args: []);
  }

  /// `Avenue`
  String get avenue {
    return Intl.message('Avenue', name: 'avenue', desc: '', args: []);
  }

  /// `Floor No*`
  String get floor_no_ {
    return Intl.message('Floor No*', name: 'floor_no_', desc: '', args: []);
  }

  /// `Flat No*`
  String get flat_no_ {
    return Intl.message('Flat No*', name: 'flat_no_', desc: '', args: []);
  }

  /// `Extra Directions*`
  String get extra_directions_ {
    return Intl.message(
      'Extra Directions*',
      name: 'extra_directions_',
      desc: '',
      args: [],
    );
  }

  /// `Please select an area`
  String get please_select_an_area {
    return Intl.message(
      'Please select an area',
      name: 'please_select_an_area',
      desc: '',
      args: [],
    );
  }

  /// `enter here`
  String get enter_here {
    return Intl.message('enter here', name: 'enter_here', desc: '', args: []);
  }

  /// `Enter your name`
  String get enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your E-mail`
  String get enter_your_email {
    return Intl.message(
      'Enter your E-mail',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone`
  String get enter_your_phone {
    return Intl.message(
      'Enter your phone',
      name: 'enter_your_phone',
      desc: '',
      args: [],
    );
  }

  /// `house no`
  String get house_no {
    return Intl.message('house no', name: 'house_no', desc: '', args: []);
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message('My Orders', name: 'my_orders', desc: '', args: []);
  }

  /// `Wish list`
  String get wish_list {
    return Intl.message('Wish list', name: 'wish_list', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Are you sure you want to logout?`
  String get are_you_sure_you_want_to_logout {
    return Intl.message(
      'Are you sure you want to logout?',
      name: 'are_you_sure_you_want_to_logout',
      desc: '',
      args: [],
    );
  }

  /// `Order ID`
  String get order_ID {
    return Intl.message('Order ID', name: 'order_ID', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Amount`
  String get amount {
    return Intl.message('Amount', name: 'amount', desc: '', args: []);
  }

  /// `Our Policies`
  String get our_policies {
    return Intl.message(
      'Our Policies',
      name: 'our_policies',
      desc: '',
      args: [],
    );
  }

  /// `Happy Shopping!!`
  String get happy_shopping__ {
    return Intl.message(
      'Happy Shopping!!',
      name: 'happy_shopping__',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Sign In`
  String get sign_in {
    return Intl.message('Sign In', name: 'sign_in', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgot_password {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum is simply dummy text of the printing and typesetting industry.`
  String get lorem_small {
    return Intl.message(
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      name: 'lorem_small',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get e_mail {
    return Intl.message('E-mail', name: 'e_mail', desc: '', args: []);
  }

  /// `A password reset link has \nbeen sent to your email`
  String get password_reset_link {
    return Intl.message(
      'A password reset link has \nbeen sent to your email',
      name: 'password_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message('Send', name: 'send', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Sign up error`
  String get sign_up_error {
    return Intl.message(
      'Sign up error',
      name: 'sign_up_error',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Register`
  String get dont_have_an_account_Register {
    return Intl.message(
      'Don\'t have an account? Register',
      name: 'dont_have_an_account_Register',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully\nRegistered with Ghina shop`
  String get success_register_message {
    return Intl.message(
      'You have successfully\nRegistered with Ghina shop',
      name: 'success_register_message',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number*`
  String get phone_number_ {
    return Intl.message(
      'Phone Number*',
      name: 'phone_number_',
      desc: '',
      args: [],
    );
  }

  /// `Password*`
  String get password_ {
    return Intl.message('Password*', name: 'password_', desc: '', args: []);
  }

  /// `No products available`
  String get no_products_available {
    return Intl.message(
      'No products available',
      name: 'no_products_available',
      desc: '',
      args: [],
    );
  }

  /// `Brands`
  String get brands {
    return Intl.message('Brands', name: 'brands', desc: '', args: []);
  }

  /// `My Cart`
  String get my_cart {
    return Intl.message('My Cart', name: 'my_cart', desc: '', args: []);
  }

  /// `Sub Total`
  String get sub_total {
    return Intl.message('Sub Total', name: 'sub_total', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Proceed to Checkout`
  String get proceed_to_checkout {
    return Intl.message(
      'Proceed to Checkout',
      name: 'proceed_to_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Large`
  String get large {
    return Intl.message('Large', name: 'large', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Coupon Code`
  String get coupon_code {
    return Intl.message('Coupon Code', name: 'coupon_code', desc: '', args: []);
  }

  /// `Payment Details`
  String get payment_details {
    return Intl.message(
      'Payment Details',
      name: 'payment_details',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Pay`
  String get proceed_to_pay {
    return Intl.message(
      'Proceed to Pay',
      name: 'proceed_to_pay',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Thank You For Your Purchase`
  String get thank_you_for_your_purchase {
    return Intl.message(
      'Thank You For Your Purchase',
      name: 'thank_you_for_your_purchase',
      desc: '',
      args: [],
    );
  }

  /// `Your Purchase was`
  String get your_purchase_was {
    return Intl.message(
      'Your Purchase was',
      name: 'your_purchase_was',
      desc: '',
      args: [],
    );
  }

  /// `Successful`
  String get successful {
    return Intl.message('Successful', name: 'successful', desc: '', args: []);
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `Order status`
  String get order_status {
    return Intl.message(
      'Order status',
      name: 'order_status',
      desc: '',
      args: [],
    );
  }

  /// `Date & Time`
  String get date_and_time {
    return Intl.message(
      'Date & Time',
      name: 'date_and_time',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Details`
  String get delivery_details {
    return Intl.message(
      'Delivery Details',
      name: 'delivery_details',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `Item Name`
  String get item_name {
    return Intl.message('Item Name', name: 'item_name', desc: '', args: []);
  }

  /// `Office No`
  String get office_no {
    return Intl.message('Office No', name: 'office_no', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Delete Product`
  String get delete_product {
    return Intl.message(
      'Delete Product',
      name: 'delete_product',
      desc: '',
      args: [],
    );
  }

  /// `Are Your Sure You \nWant to delete Item from Cart`
  String get delete_product_contain_message {
    return Intl.message(
      'Are Your Sure You \nWant to delete Item from Cart',
      name: 'delete_product_contain_message',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Discount`
  String get discount {
    return Intl.message('Discount', name: 'discount', desc: '', args: []);
  }

  /// `Delivery`
  String get delivery {
    return Intl.message('Delivery', name: 'delivery', desc: '', args: []);
  }

  /// `Featured Products`
  String get featured_products {
    return Intl.message(
      'Featured Products',
      name: 'featured_products',
      desc: '',
      args: [],
    );
  }

  /// `Error try again`
  String get error_try_again {
    return Intl.message(
      'Error try again',
      name: 'error_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Best Selling`
  String get best_selling {
    return Intl.message(
      'Best Selling',
      name: 'best_selling',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get payment_method {
    return Intl.message(
      'Payment Method',
      name: 'payment_method',
      desc: '',
      args: [],
    );
  }

  /// `Edit Address`
  String get edit_address {
    return Intl.message(
      'Edit Address',
      name: 'edit_address',
      desc: '',
      args: [],
    );
  }

  /// `Select Address`
  String get select_address {
    return Intl.message(
      'Select Address',
      name: 'select_address',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Sort By`
  String get sort_by {
    return Intl.message('Sort By', name: 'sort_by', desc: '', args: []);
  }

  /// `Category`
  String get category {
    return Intl.message('Category', name: 'category', desc: '', args: []);
  }

  /// `cart`
  String get cart {
    return Intl.message('cart', name: 'cart', desc: '', args: []);
  }

  /// `account`
  String get account {
    return Intl.message('account', name: 'account', desc: '', args: []);
  }

  /// `New Arrivals`
  String get new_arrivals {
    return Intl.message(
      'New Arrivals',
      name: 'new_arrivals',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get see_all {
    return Intl.message('See All', name: 'see_all', desc: '', args: []);
  }

  /// `Let's start shopping!`
  String get Lets_start_shopping {
    return Intl.message(
      'Let\'s start shopping!',
      name: 'Lets_start_shopping',
      desc: '',
      args: [],
    );
  }

  /// `Choose Language`
  String get choose_language {
    return Intl.message(
      'Choose Language',
      name: 'choose_language',
      desc: '',
      args: [],
    );
  }

  /// `by`
  String get by {
    return Intl.message('by', name: 'by', desc: '', args: []);
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message('Add to Cart', name: 'add_to_cart', desc: '', args: []);
  }

  /// `NO CONNECTION`
  String get NO_CONNECTION {
    return Intl.message(
      'NO CONNECTION',
      name: 'NO_CONNECTION',
      desc: '',
      args: [],
    );
  }

  /// `Connection not found, make sure you are\nconnected to internet`
  String get connection_not_found {
    return Intl.message(
      'Connection not found, make sure you are\nconnected to internet',
      name: 'connection_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Delete Your Address`
  String get delete_your_address {
    return Intl.message(
      'Delete Your Address',
      name: 'delete_your_address',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your address?`
  String get delete_address_contain_message {
    return Intl.message(
      'Are you sure you want to delete your address?',
      name: 'delete_address_contain_message',
      desc: '',
      args: [],
    );
  }

  /// `No Result Found`
  String get no_result_found {
    return Intl.message(
      'No Result Found',
      name: 'no_result_found',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Ghina shop`
  String get title {
    return Intl.message('Ghina shop', name: 'title', desc: '', args: []);
  }

  /// `Forget Password?`
  String get Forget_Password {
    return Intl.message(
      'Forget Password?',
      name: 'Forget_Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Here`
  String get Enter_Here {
    return Intl.message('Enter Here', name: 'Enter_Here', desc: '', args: []);
  }

  /// `Already have an account? Login`
  String get Already_Have {
    return Intl.message(
      'Already have an account? Login',
      name: 'Already_Have',
      desc: '',
      args: [],
    );
  }

  /// `V.1.0`
  String get version {
    return Intl.message('V.1.0', name: 'version', desc: '', args: []);
  }

  /// `© 2025 Ghina Shop. All rights reserved`
  String get copyrights {
    return Intl.message(
      '© 2025 Ghina Shop. All rights reserved',
      name: 'copyrights',
      desc: '',
      args: [],
    );
  }

  /// `No products in cart`
  String get no_Product_In_Cart {
    return Intl.message(
      'No products in cart',
      name: 'no_Product_In_Cart',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get shipping_address {
    return Intl.message(
      'Shipping Address',
      name: 'shipping_address',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get name {
    return Intl.message('Full Name', name: 'name', desc: '', args: []);
  }

  /// `Mobile Number`
  String get mobile {
    return Intl.message('Mobile Number', name: 'mobile', desc: '', args: []);
  }

  /// `Email Address`
  String get email {
    return Intl.message('Email Address', name: 'email', desc: '', args: []);
  }

  /// `Please provide a valid shipping address`
  String get shipping_address_error {
    return Intl.message(
      'Please provide a valid shipping address',
      name: 'shipping_address_error',
      desc: '',
      args: [],
    );
  }

  /// `Full name is required for shipping`
  String get shipping_name_error {
    return Intl.message(
      'Full name is required for shipping',
      name: 'shipping_name_error',
      desc: '',
      args: [],
    );
  }

  /// `Mobile number is required for shipping`
  String get shipping_mobile_error {
    return Intl.message(
      'Mobile number is required for shipping',
      name: 'shipping_mobile_error',
      desc: '',
      args: [],
    );
  }

  /// `Email address is required for shipping`
  String get shipping_email_error {
    return Intl.message(
      'Email address is required for shipping',
      name: 'shipping_email_error',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Confirmed`
  String get confirmed {
    return Intl.message('Confirmed', name: 'confirmed', desc: '', args: []);
  }

  /// `stores`
  String get stores {
    return Intl.message('stores', name: 'stores', desc: '', args: []);
  }

  /// `store name`
  String get storeName {
    return Intl.message('store name', name: 'storeName', desc: '', args: []);
  }

  /// `Ordered`
  String get ordered {
    return Intl.message('Ordered', name: 'ordered', desc: '', args: []);
  }

  /// `Under Delivery`
  String get underDelivery {
    return Intl.message(
      'Under Delivery',
      name: 'underDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Cancelled`
  String get Cancelled {
    return Intl.message('Cancelled', name: 'Cancelled', desc: '', args: []);
  }

  /// `Delivery Date`
  String get deliveryDate {
    return Intl.message(
      'Delivery Date',
      name: 'deliveryDate',
      desc: '',
      args: [],
    );
  }

  /// `cancel Note`
  String get cancelNote {
    return Intl.message('cancel Note', name: 'cancelNote', desc: '', args: []);
  }

  /// `Wish list`
  String get Wishlist {
    return Intl.message('Wish list', name: 'Wishlist', desc: '', args: []);
  }

  /// `No items in Wishlist`
  String get no_items_in_wishlist {
    return Intl.message(
      'No items in Wishlist',
      name: 'no_items_in_wishlist',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `item`
  String get item {
    return Intl.message('item', name: 'item', desc: '', args: []);
  }

  /// `items`
  String get items {
    return Intl.message('items', name: 'items', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `Delivery Cost`
  String get deliveryCost {
    return Intl.message(
      'Delivery Cost',
      name: 'deliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Optional`
  String get optional {
    return Intl.message('Optional', name: 'optional', desc: '', args: []);
  }

  /// `Verify OTP`
  String get verify_otp {
    return Intl.message('Verify OTP', name: 'verify_otp', desc: '', args: []);
  }

  /// `Please enter the verification code sent to your WhatsApp`
  String get verify_otp_message {
    return Intl.message(
      'Please enter the verification code sent to your WhatsApp',
      name: 'verify_otp_message',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid 5-digit code.`
  String get verify_otp_error {
    return Intl.message(
      'Please enter a valid 5-digit code.',
      name: 'verify_otp_error',
      desc: '',
      args: [],
    );
  }

  /// `notes`
  String get notes {
    return Intl.message('notes', name: 'notes', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
