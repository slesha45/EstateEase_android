class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = 'http:// 172.26.0.19:5000/api/';
  static const String baseUrl = "http://10.0.2.2:5000/api/";

  // ====================== Auth Routes ======================
  static const String loginUser = "user/login";
  static const String registerUser = "user/create";
  static const String getMe = "user/profile/get";
  static const String getToken = "user/token";
  static const String verifyUser = "user/verifyUser";

// ============Property Routes ==========
  static const String getAllProperty = 'property/get_all_property';
  static const String updateProperty = 'property/update_property';
  static const String paginationProperty = 'property/pagination';
  static const int limitPage = 2;
  static const String getSingleProperty = 'property/get_single_property';

  // static const String imageUrl = 'http://192.168.1.133:5000/property/'
  static const String imageUrl = 'http://10.0.2.2:5000/property/';

  // ====================== Booking Routes ======================
  static const String createBooking = 'booking/bookings';
  static const String getAllBookings = 'booking/all_bookings';
  static const String getUserBookings = 'booking/mybookings';
  static const String updateBookingStatus = 'booking/bookings/status';
  static const String updatePaymentMethod = 'booking/bookings/payment';

  // ====================== Wishlist Routes ======================
  static const String getUserFavorites = 'wishlist/all';
  static const String addFavorite = 'wishlist/add';
  static const String deleteFavorite = 'wishlist/remove';
}
