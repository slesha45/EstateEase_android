import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/shared_prefs/user_shared_prefs.dart';
import 'package:final_assignment/features/home/domain/entity/property_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/property_usecase.dart';
import 'package:final_assignment/features/single_property/presentation/viewmodel/single_property_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'single_property_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PropertyUsecase>()])
void main() {
  late PropertyUsecase mockPropertyUsecase;
  late ProviderContainer container;

  setUp(() {
    mockPropertyUsecase = MockPropertyUsecase();
    container = ProviderContainer(
      overrides: [
        singlePropertyViewModelProvider.overrideWith(
          (ref) => SinglePropertyViewModel(
            propertyUsecase: mockPropertyUsecase,
            userSharedPrefs: ref.watch(userSharedPrefsProvider),
          ),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test('getSingleProperty should correctly fetch and update state', () async {
    // Arrange
    final propertyId = '1';
    const property = PropertyEntity(
      id: '1',
      propertyTitle: 'Property 1',
      propertyPrice: 500000,
      propertyCategory: 'Residential',
      propertyLocation: 'Location 1',
      propertyImage: 'image1.jpg',
    );

    when(mockPropertyUsecase.getPropertyById(propertyId))
        .thenAnswer((_) async => const Right(property));

    final viewModel = container.read(singlePropertyViewModelProvider.notifier);
    
    // Act
    await viewModel.getSingleProperty(propertyId);

    // Assert
    final state = container.read(singlePropertyViewModelProvider);
    expect(state.isLoading, false);
    expect(state.singleProperty, isNotNull);
    expect(state.singleProperty!.id, property.id);
    expect(state.error, isNull);
  });
}
