import 'package:dartz/dartz.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/property_usecase.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/property_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'property_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PropertyUsecase>()])
void main() {
  late PropertyUsecase mockPropertyUseCase;
  late ProviderContainer container;

  setUp(() {
    mockPropertyUseCase = MockPropertyUsecase();
    container = ProviderContainer(
      overrides: [
        propertyViewModelProvider.overrideWith(
          (ref) => PropertyViewmodel(propertyUsecase: mockPropertyUseCase),
        ),
      ],
    );
  });
  tearDown(() {
    container.dispose();
  });

  test('Pagination should correctly handle new data', () async {
    when(mockPropertyUseCase.pagination(any, any))
        .thenAnswer((_) async => const Right([
              PropertyEntity(
                id: '1',
                propertyTitle: 'Property 1',
                propertyPrice: 100000,
                propertyCategory: 'House',
                propertyLocation: 'Location 1',
                propertyImage: 'Image1.jpg',
              ),
              PropertyEntity(
                id: '2',
                propertyTitle: 'Property 2',
                propertyPrice: 200000,
                propertyCategory: 'Flat',
                propertyLocation: 'Location 2',
                propertyImage: 'Image2.jpg',
              ),
            ]));

    final viewModel = container.read(propertyViewModelProvider.notifier);
    await viewModel.getProperty();

    // Assertions to verify state changes
    final state = container.read(propertyViewModelProvider);
    expect(state.isLoading, false);
    expect(state.property.isNotEmpty, true);
    expect(state.property.length, 2);
    expect(state.page, equals(1)); // Assuming initial page is 1
  });
  tearDown(() {
    container.dispose();
  });

  test('Pagination should handle empty data by setting has ReachedMax',
      () async {
    when(mockPropertyUseCase.pagination(any, any))
        .thenAnswer((_) async => const Right([]));

    final viewModel = container.read(propertyViewModelProvider.notifier);
    await viewModel.getProperty();

    // Assertions to verify handling of empty data
    final state = container.read(propertyViewModelProvider);
    expect(state.hasReachedMax, true);
    expect(state.isLoading, true);
  });
  tearDown(() {
    container.dispose();
  });
  test('resetState should correctly reset the state and fetch initial data',
      () async {
    when(mockPropertyUseCase.pagination(any, any)).thenAnswer(
      (_) async => const Right([
        PropertyEntity(
          id: '1',
          propertyTitle: 'Property 1',
          propertyPrice: 100000,
          propertyCategory: 'Apartment',
          propertyLocation: 'Location 1',
          propertyImage: 'image1.jpg',
        ),
      ]),
    );

    final viewModel = container.read(propertyViewModelProvider.notifier);

    // Simulate state change before reset
    await viewModel.getProperty();

    // Reset the state
    await viewModel.resetState();

    // Assertions to verify state reset and fetching initial data
    final state = container.read(propertyViewModelProvider);
    expect(state.isLoading, isFalse);
    expect(state.property.isNotEmpty, isTrue);
    expect(state.page, equals(1)); 
  });
}
