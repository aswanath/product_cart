// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:product_cart/core/network/dio_client.dart' as _i4;
import 'package:product_cart/dependency_injection/module/dio_module.dart'
    as _i8;
import 'package:product_cart/modules/product/data/repository/iproduct_repository.dart'
    as _i5;
import 'package:product_cart/modules/product/data/repository/product_repository.dart'
    as _i6;
import 'package:product_cart/modules/product/presentation/bloc/product_bloc.dart'
    as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i3.Dio>(() => dioModule.dio);
    gh.factory<_i4.DioClient>(() => _i4.DioClient(gh<_i3.Dio>()));
    gh.factory<_i5.IProductRepository>(
        () => _i6.ProductRepository(gh<_i4.DioClient>()));
    gh.factory<_i7.ProductBloc>(
        () => _i7.ProductBloc(gh<_i5.IProductRepository>()));
    return this;
  }
}

class _$DioModule extends _i8.DioModule {}
