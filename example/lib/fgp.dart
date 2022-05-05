/////////////////////////////////////////////////////////////////
// Generated code by bare_codegen - Thu, May 05, 2022 02:44 PM //
/////////////////////////////////////////////////////////////////

import 'package:bare/bare.dart';
import 'package:fixnum/fixnum.dart';
import 'dart:typed_data';

part 'fgp.bare.dart';

class AppInfo {
  String value;
  AppInfo({required this.value});

  static AppInfo fromBare(data) => AppInfoBare.fromBare(data);

  String toString() => 'AppInfo {${value}}';
}

class AppError {
  String value;
  AppError({required this.value});

  static AppError fromBare(data) => AppErrorBare.fromBare(data);

  String toString() => 'AppError {${value}}';
}

class AppWarning {
  String value;
  AppWarning({required this.value});

  static AppWarning fromBare(data) => AppWarningBare.fromBare(data);

  String toString() => 'AppWarning {${value}}';
}

class AppSuccess {
  String value;
  AppSuccess({required this.value});

  static AppSuccess fromBare(data) => AppSuccessBare.fromBare(data);

  String toString() => 'AppSuccess {${value}}';
}

class OkResponse {
  OkResponse(); // Bare void type
}

enum AppResponseKind {
  APP_INFO,
  APP_WARNING,
  APP_ERROR,
  APP_SUCCESS,
  OK_RESPONSE,
}

class AppResponse {
  AppResponseKind kind;
  dynamic value;

  AppResponse({required this.kind, required this.value});

  static AppResponse fromBare(data) => AppResponseBare.fromBare(data);

  @override
  String toString() => '${kind}  ${value}';
}

class Date {
  String value;
  Date({required this.value});

  static Date fromBare(data) => DateBare.fromBare(data);

  String toString() => 'Date {${value}}';
}

class Guid {
  String value;
  Guid({required this.value});

  static Guid fromBare(data) => GuidBare.fromBare(data);

  String toString() => 'Guid {${value}}';
}

class Prts {
  List<int> value;
  Prts({required this.value});

  static Prts fromBare(data) => PrtsBare.fromBare(data);

  String toString() => 'Prts {${value}}';
}

class Parts {
  List<int> part;
  Parts({required this.part});

  static Parts fromBare(data) => PartsBare.fromBare(data);

  @override
  String toString() => 'Parts { part: ${part} }';
}

class Species {
  Guid id;
  String name;
  bool disabled;
  bool deleted;
  String meazure;
  Prts parts;
  int sno;
  Species(
      {required this.id,
      required this.name,
      required this.disabled,
      required this.deleted,
      required this.meazure,
      required this.parts,
      required this.sno});

  static Species fromBare(data) => SpeciesBare.fromBare(data);

  @override
  String toString() =>
      'Species { id: ${id}, name: ${name}, disabled: ${disabled}, deleted: ${deleted}, meazure: ${meazure}, parts: ${parts}, sno: ${sno} }';
}

class Region {
  Guid id;
  String name;
  String state;
  bool disabled;
  bool deleted;
  int sno;
  Region(
      {required this.id,
      required this.name,
      required this.state,
      required this.disabled,
      required this.deleted,
      required this.sno});

  static Region fromBare(data) => RegionBare.fromBare(data);

  @override
  String toString() =>
      'Region { id: ${id}, name: ${name}, state: ${state}, disabled: ${disabled}, deleted: ${deleted}, sno: ${sno} }';
}

class SpeciesRegionRegion {
  Guid SpeciesRegionId;
  bool speciesRegionDisabled;
  Guid regionId;
  String region;
  String state;
  bool regionDisabled;
  SpeciesRegionRegion(
      {required this.SpeciesRegionId,
      required this.speciesRegionDisabled,
      required this.regionId,
      required this.region,
      required this.state,
      required this.regionDisabled});

  static SpeciesRegionRegion fromBare(data) =>
      SpeciesRegionRegionBare.fromBare(data);

  @override
  String toString() =>
      'SpeciesRegionRegion { SpeciesRegionId: ${SpeciesRegionId}, speciesRegionDisabled: ${speciesRegionDisabled}, regionId: ${regionId}, region: ${region}, state: ${state}, regionDisabled: ${regionDisabled} }';
}

class SpeciesRegion {
  Guid speciesId;
  String speciesName;
  bool speciesDisabled;
  List<SpeciesRegionRegion> regions;
  SpeciesRegion(
      {required this.speciesId,
      required this.speciesName,
      required this.speciesDisabled,
      required this.regions});

  static SpeciesRegion fromBare(data) => SpeciesRegionBare.fromBare(data);

  @override
  String toString() =>
      'SpeciesRegion { speciesId: ${speciesId}, speciesName: ${speciesName}, speciesDisabled: ${speciesDisabled}, regions: ${regions} }';
}

class AddSpeciesRegion {
  Guid speciesId;
  Guid regionId;
  AddSpeciesRegion({required this.speciesId, required this.regionId});

  static AddSpeciesRegion fromBare(data) => AddSpeciesRegionBare.fromBare(data);

  @override
  String toString() =>
      'AddSpeciesRegion { speciesId: ${speciesId}, regionId: ${regionId} }';
}

class DeleteSpeciesRegion {
  Guid speciesId;
  Guid speciesRegionId;
  DeleteSpeciesRegion({required this.speciesId, required this.speciesRegionId});

  static DeleteSpeciesRegion fromBare(data) =>
      DeleteSpeciesRegionBare.fromBare(data);

  @override
  String toString() =>
      'DeleteSpeciesRegion { speciesId: ${speciesId}, speciesRegionId: ${speciesRegionId} }';
}

class DisableSpeciesRegion {
  Guid speciesId;
  Guid speciesRegionId;
  bool disabled;
  DisableSpeciesRegion(
      {required this.speciesId,
      required this.speciesRegionId,
      required this.disabled});

  static DisableSpeciesRegion fromBare(data) =>
      DisableSpeciesRegionBare.fromBare(data);

  @override
  String toString() =>
      'DisableSpeciesRegion { speciesId: ${speciesId}, speciesRegionId: ${speciesRegionId}, disabled: ${disabled} }';
}

class AnimalPrice {
  Guid id;
  Guid speciesRegionId;
  String meazure;
  int part;
  double price;
  String pDate;
  bool isActive;
  AnimalPrice(
      {required this.id,
      required this.speciesRegionId,
      required this.meazure,
      required this.part,
      required this.price,
      required this.pDate,
      required this.isActive});

  static AnimalPrice fromBare(data) => AnimalPriceBare.fromBare(data);

  @override
  String toString() =>
      'AnimalPrice { id: ${id}, speciesRegionId: ${speciesRegionId}, meazure: ${meazure}, part: ${part}, price: ${price}, pDate: ${pDate}, isActive: ${isActive} }';
}

class FetchPriceRequest {
  Guid speciesId;
  Guid speciesRegionId;
  String pDate;
  int part;
  FetchPriceRequest(
      {required this.speciesId,
      required this.speciesRegionId,
      required this.pDate,
      required this.part});

  static FetchPriceRequest fromBare(data) =>
      FetchPriceRequestBare.fromBare(data);

  @override
  String toString() =>
      'FetchPriceRequest { speciesId: ${speciesId}, speciesRegionId: ${speciesRegionId}, pDate: ${pDate}, part: ${part} }';
}

class QuarterlyPrice {
  double price;
  String pDate;
  QuarterlyPrice({required this.price, required this.pDate});

  static QuarterlyPrice fromBare(data) => QuarterlyPriceBare.fromBare(data);

  @override
  String toString() => 'QuarterlyPrice { price: ${price}, pDate: ${pDate} }';
}

class SpeciesList {
  List<Species> value;
  SpeciesList({required this.value});

  static SpeciesList fromBare(data) => SpeciesListBare.fromBare(data);

  String toString() => 'SpeciesList {${value}}';
}

class RegionList {
  List<Region> value;
  RegionList({required this.value});

  static RegionList fromBare(data) => RegionListBare.fromBare(data);

  String toString() => 'RegionList {${value}}';
}

class AnimalPriceList {
  List<AnimalPrice> value;
  AnimalPriceList({required this.value});

  static AnimalPriceList fromBare(data) => AnimalPriceListBare.fromBare(data);

  String toString() => 'AnimalPriceList {${value}}';
}

class QuarterlyPriceList {
  List<QuarterlyPrice> value;
  QuarterlyPriceList({required this.value});

  static QuarterlyPriceList fromBare(data) =>
      QuarterlyPriceListBare.fromBare(data);

  String toString() => 'QuarterlyPriceList {${value}}';
}

class AddNewSpecies {
  Species value;
  AddNewSpecies({required this.value});

  static AddNewSpecies fromBare(data) => AddNewSpeciesBare.fromBare(data);

  String toString() => 'AddNewSpecies {${value}}';
}

class UpdateSpecies {
  Species value;
  UpdateSpecies({required this.value});

  static UpdateSpecies fromBare(data) => UpdateSpeciesBare.fromBare(data);

  String toString() => 'UpdateSpecies {${value}}';
}

class AddNewRegion {
  Region value;
  AddNewRegion({required this.value});

  static AddNewRegion fromBare(data) => AddNewRegionBare.fromBare(data);

  String toString() => 'AddNewRegion {${value}}';
}

class UpdateRegion {
  Region value;
  UpdateRegion({required this.value});

  static UpdateRegion fromBare(data) => UpdateRegionBare.fromBare(data);

  String toString() => 'UpdateRegion {${value}}';
}

class ListSpecies {
  ListSpecies(); // Bare void type
}

class ListRegions {
  ListRegions(); // Bare void type
}

class ListSpeciesRegions {
  ListSpeciesRegions(); // Bare void type
}

class UpdatePrice {
  List<AnimalPrice> value;
  UpdatePrice({required this.value});

  static UpdatePrice fromBare(data) => UpdatePriceBare.fromBare(data);

  String toString() => 'UpdatePrice {${value}}';
}

class ListPricesForDate {
  FetchPriceRequest value;
  ListPricesForDate({required this.value});

  static ListPricesForDate fromBare(data) =>
      ListPricesForDateBare.fromBare(data);

  String toString() => 'ListPricesForDate {${value}}';
}

class ListQuarterlyPrices {
  FetchPriceRequest value;
  ListQuarterlyPrices({required this.value});

  static ListQuarterlyPrices fromBare(data) =>
      ListQuarterlyPricesBare.fromBare(data);

  String toString() => 'ListQuarterlyPrices {${value}}';
}

class SpeciesRegionList {
  List<SpeciesRegion> value;
  SpeciesRegionList({required this.value});

  static SpeciesRegionList fromBare(data) =>
      SpeciesRegionListBare.fromBare(data);

  String toString() => 'SpeciesRegionList {${value}}';
}

enum FgpRequestKind {
  ADD_NEW_SPECIES,
  UPDATE_SPECIES,
  LIST_SPECIES,
  ADD_NEW_REGION,
  UPDATE_REGION,
  LIST_REGIONS,
  LIST_SPECIES_REGIONS,
  ADD_SPECIES_REGION,
  DISABLE_SPECIES_REGION,
  DELETE_SPECIES_REGION,
  UPDATE_PRICE,
  LIST_PRICES_FOR_DATE,
  LIST_QUARTERLY_PRICES,
}

class FgpRequest {
  FgpRequestKind kind;
  dynamic value;

  FgpRequest({required this.kind, required this.value});

  static FgpRequest fromBare(data) => FgpRequestBare.fromBare(data);

  @override
  String toString() => '${kind}  ${value}';
}

enum FgpResponseKind {
  SPECIES_LIST,
  REGION_LIST,
  SPECIES_REGION_LIST,
  SPECIES_REGION,
  ANIMAL_PRICE_LIST,
  QUARTERLY_PRICE_LIST,
  APP_RESPONSE,
}

class FgpResponse {
  FgpResponseKind kind;
  dynamic value;

  FgpResponse({required this.kind, required this.value});

  static FgpResponse fromBare(data) => FgpResponseBare.fromBare(data);

  @override
  String toString() => '${kind}  ${value}';
}
