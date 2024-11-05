// Mocks generated by Mockito 5.4.4 from annotations
// in final_assignment/test/unit_test/property_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:final_assignment/core/failure/failure.dart' as _i6;
import 'package:final_assignment/features/home/domain/entity/property_entity.dart'
    as _i7;
import 'package:final_assignment/features/home/domain/repository/property_repository.dart'
    as _i2;
import 'package:final_assignment/features/home/domain/usecases/property_usecase.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIPropertyRepository_0 extends _i1.SmartFake
    implements _i2.IPropertyRepository {
  _FakeIPropertyRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PropertyUsecase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPropertyUsecase extends _i1.Mock implements _i4.PropertyUsecase {
  @override
  _i2.IPropertyRepository get propertyRepository => (super.noSuchMethod(
        Invocation.getter(#propertyRepository),
        returnValue: _FakeIPropertyRepository_0(
          this,
          Invocation.getter(#propertyRepository),
        ),
        returnValueForMissingStub: _FakeIPropertyRepository_0(
          this,
          Invocation.getter(#propertyRepository),
        ),
      ) as _i2.IPropertyRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.PropertyEntity>>> pagination(
    int? page,
    int? limit,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #pagination,
          [
            page,
            limit,
          ],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.PropertyEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.PropertyEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, List<_i7.PropertyEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.PropertyEntity>>(
          this,
          Invocation.method(
            #pagination,
            [
              page,
              limit,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, List<_i7.PropertyEntity>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, _i7.PropertyEntity>> getPropertyById(
          String? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPropertyById,
          [id],
        ),
        returnValue:
            _i5.Future<_i3.Either<_i6.Failure, _i7.PropertyEntity>>.value(
                _FakeEither_1<_i6.Failure, _i7.PropertyEntity>(
          this,
          Invocation.method(
            #getPropertyById,
            [id],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, _i7.PropertyEntity>>.value(
                _FakeEither_1<_i6.Failure, _i7.PropertyEntity>(
          this,
          Invocation.method(
            #getPropertyById,
            [id],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, _i7.PropertyEntity>>);
}