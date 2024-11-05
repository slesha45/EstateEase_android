import 'package:final_assignment/features/booking/domain/usecases/booking_usecase.dart';
import 'package:final_assignment/features/mybooking/presentation/navigator/booking_list_navigator.dart';
import 'package:final_assignment/features/mybooking/presentation/state/booking_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bookingListViewModelProvider =
    StateNotifierProvider<BookingListViewModel, BookingListState>(
  (ref) {
    final bookingUsecase = ref.watch(bookingUsecaseProvider);
    return BookingListViewModel(
        bookingUsecase: bookingUsecase,
        navigator: ref.read(bookingListNavigatorProvider));
  },
);

class BookingListViewModel extends StateNotifier<BookingListState> {
  final BookingUsecase bookingUsecase;
  final BookingListViewNavigator navigator;
  BookingListViewModel({required this.bookingUsecase, required this.navigator})
      : super(BookingListState.initial()) {
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    state = state.copyWith(isLoading: true);
    final result = await bookingUsecase.getBookings();
    result.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(
          isLoading: false,
          bookings: r,
        );
      },
    );
  }

  void openKhaltiView() {
    navigator.openKhaltiView();
  }

  void getbookings(param0, selectedQuantity, propertyPrice) {}
}
