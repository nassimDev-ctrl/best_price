class Keys {
  static const String kLang = "lang";

  static const String kUserName = 'user_name';
  static const String kUserEmail = 'user_email';
  static const String kUserMobile = 'user_mobile';
  static const String kUserToken = 'user_token';
  static const String kIsGuest = 'is_guest';
  static const String kIsFirstTime =
      'first_time'; // ! this is to know if user enter to app first time ..
  static const String kIsLogin =
      'first_time'; // ! this is to know if user login or register  ..
}

class UrlKeys {
//!
  static const categoryEndPoint = "category/categories";
  static const productCategoryEndPoint = "productsFilter?category_id=";
  static const brandsEndPoint = "getBrands";
  //! this is the CartUrls ..
  static const getMyCartEndPoint = "cart/";
  static const addMyCartEndPoint = "cart/add-product/";
  static const deleteFromCartEndPoint =
      "cart/delete-product"; //?  this need id in end ex:{{mainURL}}deleteProductCart/1
  //! global
  static const getAreaEndPoint = 'getAreas';
  //! Address
  static const getMyAddressEndPoint = 'getMyAddresses';
  static const deleteMyAddressEndPoint = 'deleteMyAddress';
  static const addMyAddressEndPoint = 'addAddress';
  //! MyWish
  static const getMyWishEndPoint = 'favorite/';
  static const addRemoveFromFavEndPoint =
      'addAndRemoveFromFavorite'; //! this need Id  ex:{{mainURL}}addAndRemoveFromFavorite/4 -> (4 is product id you want add it or remove it from the wish)
  //!  change password
  static const changePassEndPoint = 'auth/changePassword';
  //! UserAccounts
  static const editAccountEndPoint = 'auth/updateMe';
  static const logoutEndPoint = 'logout';
  //! order
  static const getOrdersEndPoint = 'orders';
  static const createOrder = 'orders';
  static const getOrdersByIdEndPoint =
      'getMyOrderById'; //! need id ex:endpoint/id
  //! search
  static const searchEndPoint =
      'searchProduct?name='; //? here write name of product
  //!account
  static const terminateEndPoint = 'terminate'; //! this is to termite account

  //! OLD URL
  static const oldUrl = "https://bp.linekw.xyz/api/";
  // ! URL
  // static const baseUrl = "https://demo1.weisro.com/api/";
  static const baseUrl = "http://127.0.0.1:3002/best-price/api/v0/";
  // static const baseUrl = "https://api.ghinashop.net/best-price/api/v0/";
  static const apiKey = "ADFRETYUUBFD!#@%*%4455iup!98SCZ@";
}
