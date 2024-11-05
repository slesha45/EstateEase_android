import 'package:final_assignment/features/booking/domain/entity/booking_entity.dart';
import 'package:final_assignment/features/booking/domain/usecases/booking_usecase.dart';
import 'package:final_assignment/features/booking/presentation/viewmodel/booking_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'booking_test.mocks.dart';

@GenerateNiceMocks([MockSpec<BookingUsecase>()])
void main() {
  late MockBookingUsecase mockBookingUsecase;
  late ProviderContainer container;

  setUp(() {
    mockBookingUsecase = MockBookingUsecase();
    container = ProviderContainer(
      overrides: [
        bookingViewmodelProvider.overrideWith(
          (ref) => BookingViewmodel(bookingUsecase: mockBookingUsecase),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

 test('addBooking should correctly update state on success', () async {
    final booking = BookingEntity(
      property: 'Property 1',
      date: DateTime.now(),
      time: '12:00 PM',
    );

    when(mockBookingUsecase.addBooking(booking))
        .thenAnswer((_) async => const Right(true));

    final viewModel = container.read(bookingViewmodelProvider.notifier);
    await viewModel.addBooking(booking);

    final state = container.read(bookingViewmodelProvider);
    expect(state.error, isNull);
  });
  
  test('BookingViewModel should initialize with correct initial state', () {
    final initialState = container.read(bookingViewmodelProvider);
    expect(initialState.isLoading, false);
    expect(initialState.error, isNull);
  });
}
