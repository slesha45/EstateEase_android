import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/mybooking/presentation/view/booking_list_view.dart';
import 'package:final_assignment/features/payment/navigator/kpay_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingListNavigatorProvider = Provider<BookingListViewNavigator>((ref) {
  return BookingListViewNavigator();
});

class BookingListViewNavigator with KpayRoute {}

mixin BookingListViewNavigatorRoute {
  void openBookingDetail() {
    NavigateRoute.pushRoute(const BookingListView());
  }
}
