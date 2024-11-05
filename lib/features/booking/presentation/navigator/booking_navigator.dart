import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/booking/presentation/view/booking_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final bookingViewNavigatorProvider = Provider<BookingViewNavigator>((ref) {
  return BookingViewNavigator();
});
 
class BookingViewNavigator with BookingViewRoute {}
 
mixin BookingViewRoute {
  openBookingView() {
    NavigateRoute.popAndPushRoute( BookingView(null));
  }
}