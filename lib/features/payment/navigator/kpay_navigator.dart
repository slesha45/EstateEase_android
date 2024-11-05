import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/payment/view/kpay_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
final kPayNavigatorProvider = Provider<Kpay>((ref) {
  return Kpay();
});
 
class Kpay {}
 
mixin KpayRoute {
  openKhaltiView() {
    NavigateRoute.pushRoute(const KhaltiPaymentView());
  }
}