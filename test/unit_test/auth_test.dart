import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

// Generate mocks for the necessary classes
@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late ProviderContainer container;
  late LoginViewNavigator mockLoginViewNavigator;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginViewNavigator = MockLoginViewNavigator();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockLoginViewNavigator, mockAuthUsecase),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test("Login with valid credentials", () async {
    // Arrange
    const correctEmail = 'slesha@gmail.com';
    const correctPassword = 'slesha123';

    when(mockAuthUsecase.loginUser(correctEmail, correctPassword))
    .thenAnswer((invocation){
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
        email == correctEmail && password == correctPassword
        ? const Right(true)
        :Left(Failure(error: 'Invalid'))
      );
    });

    // Act
   container.read(authViewModelProvider.notifier).loginUser(correctEmail, correctPassword);
 
    final authState = container.read(authViewModelProvider);
 
    //ASSERT
    expect(authState.error, isNull);
  });

  test("login with invalid credentials", () async {
    // Arrange
    const incorrectEmail = 'slesha@gmailcom';
    const incorrectPassword = 'slesha1234';
 
    when(mockAuthUsecase.loginUser(incorrectEmail, incorrectPassword))
    .thenAnswer((invocation){
      final email = invocation.positionalArguments[0] as String;
      final password = invocation.positionalArguments[1] as String;
      return Future.value(
        email == incorrectEmail && password == incorrectPassword
        ? const Right(true)
        :Left(Failure(error: 'Invalid'))
      );
    });
  });

test('Register with valid data', () async {
    // Arrange
    const authEntity = AuthEntity(
      fName: 'Slesha',
      lName: 'Dahal',
      phone: 1234567890,
      email: 'slesha@gmail.com',
      password: 'password123',
    );
 
    when(mockAuthUsecase.registerUser(authEntity)).thenAnswer(
      (_) async => const Right(true),
    );
 
    // Act
    await container.read(authViewModelProvider.notifier).registerUser(authEntity);
 
    final authState = container.read(authViewModelProvider);
 
    // Assert
    expect(authState.error, isNull);
  });

  test("Logout and navigate to login view", () async {
  // Act
  container.read(authViewModelProvider.notifier).logout();

  // Assert
  verify(mockLoginViewNavigator.openLoginView()).called(1);
});

}
