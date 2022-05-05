/////////////////////////////////////////////////////////////////
// Generated code by bare_codegen - Thu, May 05, 2022 06:11 PM //
/////////////////////////////////////////////////////////////////

part of 'fgp.dart';

extension AppInfoBare on AppInfo {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AppInfo fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static AppInfo unpack(Unpacker p) {
    final value = p.unpackString();
    return AppInfo(value: value);
  }
}

extension AppErrorBare on AppError {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AppError fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static AppError unpack(Unpacker p) {
    final value = p.unpackString();
    return AppError(value: value);
  }
}

extension AppWarningBare on AppWarning {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AppWarning fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static AppWarning unpack(Unpacker p) {
    final value = p.unpackString();
    return AppWarning(value: value);
  }
}

extension AppSuccessBare on AppSuccess {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AppSuccess fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static AppSuccess unpack(Unpacker p) {
    final value = p.unpackString();
    return AppSuccess(value: value);
  }
}

extension OkResponseBare on OkResponse {
  Packer pack(Packer p) {
    return p;
  }

  static OkResponse unpack(Unpacker p) {
    return OkResponse();
  }
}

extension AppResponseBare on AppResponse {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AppResponse fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    final bareIdx = kind.getBareIdx;
    p.packUint8(bareIdx);

    if (bareIdx == 0) (value as AppInfo).pack(p);
    if (bareIdx == 1) (value as AppWarning).pack(p);
    if (bareIdx == 2) (value as AppError).pack(p);
    if (bareIdx == 3) (value as AppSuccess).pack(p);
    if (bareIdx == 4) (value as OkResponse).pack(p);
    return p;
  }

  static AppResponse unpack(Unpacker p) {
    final bareIdx = p.unpackUint8();

    if (bareIdx == 0) {
      final _kind = AppResponseKind.APP_INFO;
      final _value = AppInfoBare.unpack(p);
      return AppResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 1) {
      final _kind = AppResponseKind.APP_WARNING;
      final _value = AppWarningBare.unpack(p);
      return AppResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 2) {
      final _kind = AppResponseKind.APP_ERROR;
      final _value = AppErrorBare.unpack(p);
      return AppResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 3) {
      final _kind = AppResponseKind.APP_SUCCESS;
      final _value = AppSuccessBare.unpack(p);
      return AppResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 4) {
      final _kind = AppResponseKind.OK_RESPONSE;
      final _value = OkResponseBare.unpack(p);
      return AppResponse(kind: _kind, value: _value);
    }

    throw ('Invalid AppResponse union option -  ${bareIdx}');
  }
}

extension AppResponseKindBare on AppResponseKind {
  int get getBareIdx {
    if (this == AppResponseKind.APP_INFO) return 0;
    if (this == AppResponseKind.APP_WARNING) return 1;
    if (this == AppResponseKind.APP_ERROR) return 2;
    if (this == AppResponseKind.APP_SUCCESS) return 3;
    if (this == AppResponseKind.OK_RESPONSE) return 4;
    throw ('Invalid AppResponse union option - ${this}');
  }
}

extension DateBare on Date {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Date fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static Date unpack(Unpacker p) {
    final value = p.unpackString();
    return Date(value: value);
  }
}

extension GuidBare on Guid {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Guid fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static Guid unpack(Unpacker p) {
    final value = p.unpackString();
    return Guid(value: value);
  }
}

extension PrtsBare on Prts {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Prts fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => p.packInt32(e));

    return p;
  }

  static Prts unpack(Unpacker p) {
    List<int> value;
    value = <int>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = p.unpackInt32();
      value.add(e);
    }

    return Prts(value: value);
  }
}

extension PartsBare on Parts {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Parts fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(part.length);
    part.forEach((e) => p.packInt32(e));

    return p;
  }

  static Parts unpack(Unpacker p) {
    List<int> part;
    part = <int>[];
    final partLength = p.unpackLength();
    for (var i = 0; i < partLength; i++) {
      final e = p.unpackInt32();
      part.add(e);
    }

    return Parts(part: part);
  }
}

extension SpeciesBare on Species {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Species fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    id.pack(p);
    p.packString(name);
    p.packBool(disabled);
    p.packBool(deleted);
    p.packString(meazure);
    parts.pack(p);
    p.packInt32(sno);
    return p;
  }

  static Species unpack(Unpacker p) {
    Guid id;
    id = GuidBare.unpack(p);

    final name = p.unpackString();
    final disabled = p.unpackBool();
    final deleted = p.unpackBool();
    final meazure = p.unpackString();
    Prts parts;
    parts = PrtsBare.unpack(p);

    final sno = p.unpackInt32();
    return Species(
        id: id,
        name: name,
        disabled: disabled,
        deleted: deleted,
        meazure: meazure,
        parts: parts,
        sno: sno);
  }
}

extension RegionBare on Region {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Region fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    id.pack(p);
    p.packString(name);
    p.packString(state);
    p.packBool(disabled);
    p.packBool(deleted);
    p.packInt32(sno);
    return p;
  }

  static Region unpack(Unpacker p) {
    Guid id;
    id = GuidBare.unpack(p);

    final name = p.unpackString();
    final state = p.unpackString();
    final disabled = p.unpackBool();
    final deleted = p.unpackBool();
    final sno = p.unpackInt32();
    return Region(
        id: id,
        name: name,
        state: state,
        disabled: disabled,
        deleted: deleted,
        sno: sno);
  }
}

extension SpeciesRegionRegionBare on SpeciesRegionRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static SpeciesRegionRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    SpeciesRegionId.pack(p);
    p.packBool(speciesRegionDisabled);
    regionId.pack(p);
    p.packString(region);
    p.packString(state);
    p.packBool(regionDisabled);
    return p;
  }

  static SpeciesRegionRegion unpack(Unpacker p) {
    Guid SpeciesRegionId;
    SpeciesRegionId = GuidBare.unpack(p);

    final speciesRegionDisabled = p.unpackBool();
    Guid regionId;
    regionId = GuidBare.unpack(p);

    final region = p.unpackString();
    final state = p.unpackString();
    final regionDisabled = p.unpackBool();
    return SpeciesRegionRegion(
        SpeciesRegionId: SpeciesRegionId,
        speciesRegionDisabled: speciesRegionDisabled,
        regionId: regionId,
        region: region,
        state: state,
        regionDisabled: regionDisabled);
  }
}

extension SpeciesRegionBare on SpeciesRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static SpeciesRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    speciesId.pack(p);
    p.packString(speciesName);
    p.packBool(speciesDisabled);
    p.packLength(regions.length);
    regions.forEach((e) => e.pack(p));

    return p;
  }

  static SpeciesRegion unpack(Unpacker p) {
    Guid speciesId;
    speciesId = GuidBare.unpack(p);

    final speciesName = p.unpackString();
    final speciesDisabled = p.unpackBool();
    List<SpeciesRegionRegion> regions;
    regions = <SpeciesRegionRegion>[];
    final regionsLength = p.unpackLength();
    for (var i = 0; i < regionsLength; i++) {
      final e = SpeciesRegionRegionBare.unpack(p);
      regions.add(e);
    }

    return SpeciesRegion(
        speciesId: speciesId,
        speciesName: speciesName,
        speciesDisabled: speciesDisabled,
        regions: regions);
  }
}

extension AddSpeciesRegionBare on AddSpeciesRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AddSpeciesRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    speciesId.pack(p);
    regionId.pack(p);
    return p;
  }

  static AddSpeciesRegion unpack(Unpacker p) {
    Guid speciesId;
    speciesId = GuidBare.unpack(p);

    Guid regionId;
    regionId = GuidBare.unpack(p);

    return AddSpeciesRegion(speciesId: speciesId, regionId: regionId);
  }
}

extension DeleteSpeciesRegionBare on DeleteSpeciesRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static DeleteSpeciesRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    speciesId.pack(p);
    speciesRegionId.pack(p);
    return p;
  }

  static DeleteSpeciesRegion unpack(Unpacker p) {
    Guid speciesId;
    speciesId = GuidBare.unpack(p);

    Guid speciesRegionId;
    speciesRegionId = GuidBare.unpack(p);

    return DeleteSpeciesRegion(
        speciesId: speciesId, speciesRegionId: speciesRegionId);
  }
}

extension DisableSpeciesRegionBare on DisableSpeciesRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static DisableSpeciesRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    speciesId.pack(p);
    speciesRegionId.pack(p);
    p.packBool(disabled);
    return p;
  }

  static DisableSpeciesRegion unpack(Unpacker p) {
    Guid speciesId;
    speciesId = GuidBare.unpack(p);

    Guid speciesRegionId;
    speciesRegionId = GuidBare.unpack(p);

    final disabled = p.unpackBool();
    return DisableSpeciesRegion(
        speciesId: speciesId,
        speciesRegionId: speciesRegionId,
        disabled: disabled);
  }
}

extension AnimalPriceBare on AnimalPrice {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AnimalPrice fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    id.pack(p);
    speciesRegionId.pack(p);
    p.packString(meazure);
    p.packInt32(part);
    p.packDouble(price);
    p.packString(pDate);
    p.packBool(isActive);
    return p;
  }

  static AnimalPrice unpack(Unpacker p) {
    Guid id;
    id = GuidBare.unpack(p);

    Guid speciesRegionId;
    speciesRegionId = GuidBare.unpack(p);

    final meazure = p.unpackString();
    final part = p.unpackInt32();
    final price = p.unpackDouble();
    final pDate = p.unpackString();
    final isActive = p.unpackBool();
    return AnimalPrice(
        id: id,
        speciesRegionId: speciesRegionId,
        meazure: meazure,
        part: part,
        price: price,
        pDate: pDate,
        isActive: isActive);
  }
}

extension FetchPriceRequestBare on FetchPriceRequest {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static FetchPriceRequest fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    speciesId.pack(p);
    speciesRegionId.pack(p);
    p.packString(pDate);
    p.packInt32(part);
    return p;
  }

  static FetchPriceRequest unpack(Unpacker p) {
    Guid speciesId;
    speciesId = GuidBare.unpack(p);

    Guid speciesRegionId;
    speciesRegionId = GuidBare.unpack(p);

    final pDate = p.unpackString();
    final part = p.unpackInt32();
    return FetchPriceRequest(
        speciesId: speciesId,
        speciesRegionId: speciesRegionId,
        pDate: pDate,
        part: part);
  }
}

extension QuarterlyPriceBare on QuarterlyPrice {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static QuarterlyPrice fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packDouble(price);
    p.packString(pDate);
    return p;
  }

  static QuarterlyPrice unpack(Unpacker p) {
    final price = p.unpackDouble();
    final pDate = p.unpackString();
    return QuarterlyPrice(price: price, pDate: pDate);
  }
}

extension SpeciesListBare on SpeciesList {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static SpeciesList fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => e.pack(p));

    return p;
  }

  static SpeciesList unpack(Unpacker p) {
    List<Species> value;
    value = <Species>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = SpeciesBare.unpack(p);
      value.add(e);
    }

    return SpeciesList(value: value);
  }
}

extension RegionListBare on RegionList {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static RegionList fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => e.pack(p));

    return p;
  }

  static RegionList unpack(Unpacker p) {
    List<Region> value;
    value = <Region>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = RegionBare.unpack(p);
      value.add(e);
    }

    return RegionList(value: value);
  }
}

extension AnimalPriceListBare on AnimalPriceList {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AnimalPriceList fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => e.pack(p));

    return p;
  }

  static AnimalPriceList unpack(Unpacker p) {
    List<AnimalPrice> value;
    value = <AnimalPrice>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = AnimalPriceBare.unpack(p);
      value.add(e);
    }

    return AnimalPriceList(value: value);
  }
}

extension QuarterlyPriceListBare on QuarterlyPriceList {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static QuarterlyPriceList fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => e.pack(p));

    return p;
  }

  static QuarterlyPriceList unpack(Unpacker p) {
    List<QuarterlyPrice> value;
    value = <QuarterlyPrice>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = QuarterlyPriceBare.unpack(p);
      value.add(e);
    }

    return QuarterlyPriceList(value: value);
  }
}

extension AddNewSpeciesBare on AddNewSpecies {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AddNewSpecies fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    value.pack(p);
    return p;
  }

  static AddNewSpecies unpack(Unpacker p) {
    Species value;
    value = SpeciesBare.unpack(p);

    return AddNewSpecies(value: value);
  }
}

extension UpdateSpeciesBare on UpdateSpecies {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static UpdateSpecies fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    value.pack(p);
    return p;
  }

  static UpdateSpecies unpack(Unpacker p) {
    Species value;
    value = SpeciesBare.unpack(p);

    return UpdateSpecies(value: value);
  }
}

extension AddNewRegionBare on AddNewRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AddNewRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    value.pack(p);
    return p;
  }

  static AddNewRegion unpack(Unpacker p) {
    Region value;
    value = RegionBare.unpack(p);

    return AddNewRegion(value: value);
  }
}

extension UpdateRegionBare on UpdateRegion {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static UpdateRegion fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    value.pack(p);
    return p;
  }

  static UpdateRegion unpack(Unpacker p) {
    Region value;
    value = RegionBare.unpack(p);

    return UpdateRegion(value: value);
  }
}

extension ListSpeciesBare on ListSpecies {
  Packer pack(Packer p) {
    return p;
  }

  static ListSpecies unpack(Unpacker p) {
    return ListSpecies();
  }
}

extension ListRegionsBare on ListRegions {
  Packer pack(Packer p) {
    return p;
  }

  static ListRegions unpack(Unpacker p) {
    return ListRegions();
  }
}

extension ListSpeciesRegionsBare on ListSpeciesRegions {
  Packer pack(Packer p) {
    return p;
  }

  static ListSpeciesRegions unpack(Unpacker p) {
    return ListSpeciesRegions();
  }
}

extension UpdatePriceBare on UpdatePrice {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static UpdatePrice fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => e.pack(p));

    return p;
  }

  static UpdatePrice unpack(Unpacker p) {
    List<AnimalPrice> value;
    value = <AnimalPrice>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = AnimalPriceBare.unpack(p);
      value.add(e);
    }

    return UpdatePrice(value: value);
  }
}

extension ListPricesForDateBare on ListPricesForDate {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static ListPricesForDate fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    value.pack(p);
    return p;
  }

  static ListPricesForDate unpack(Unpacker p) {
    FetchPriceRequest value;
    value = FetchPriceRequestBare.unpack(p);

    return ListPricesForDate(value: value);
  }
}

extension ListQuarterlyPricesBare on ListQuarterlyPrices {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static ListQuarterlyPrices fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    value.pack(p);
    return p;
  }

  static ListQuarterlyPrices unpack(Unpacker p) {
    FetchPriceRequest value;
    value = FetchPriceRequestBare.unpack(p);

    return ListQuarterlyPrices(value: value);
  }
}

extension SpeciesRegionListBare on SpeciesRegionList {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static SpeciesRegionList fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(value.length);
    value.forEach((e) => e.pack(p));

    return p;
  }

  static SpeciesRegionList unpack(Unpacker p) {
    List<SpeciesRegion> value;
    value = <SpeciesRegion>[];
    final valueLength = p.unpackLength();
    for (var i = 0; i < valueLength; i++) {
      final e = SpeciesRegionBare.unpack(p);
      value.add(e);
    }

    return SpeciesRegionList(value: value);
  }
}

extension FgpRequestBare on FgpRequest {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static FgpRequest fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    final bareIdx = kind.getBareIdx;
    p.packUint8(bareIdx);

    if (bareIdx == 0) (value as AddNewSpecies).pack(p);
    if (bareIdx == 1) (value as UpdateSpecies).pack(p);
    if (bareIdx == 2) (value as ListSpecies).pack(p);
    if (bareIdx == 3) (value as AddNewRegion).pack(p);
    if (bareIdx == 4) (value as UpdateRegion).pack(p);
    if (bareIdx == 5) (value as ListRegions).pack(p);
    if (bareIdx == 6) (value as ListSpeciesRegions).pack(p);
    if (bareIdx == 7) (value as AddSpeciesRegion).pack(p);
    if (bareIdx == 8) (value as DisableSpeciesRegion).pack(p);
    if (bareIdx == 9) (value as DeleteSpeciesRegion).pack(p);
    if (bareIdx == 10) (value as UpdatePrice).pack(p);
    if (bareIdx == 11) (value as ListPricesForDate).pack(p);
    if (bareIdx == 12) (value as ListQuarterlyPrices).pack(p);
    return p;
  }

  static FgpRequest unpack(Unpacker p) {
    final bareIdx = p.unpackUint8();

    if (bareIdx == 0) {
      final _kind = FgpRequestKind.ADD_NEW_SPECIES;
      final _value = AddNewSpeciesBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 1) {
      final _kind = FgpRequestKind.UPDATE_SPECIES;
      final _value = UpdateSpeciesBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 2) {
      final _kind = FgpRequestKind.LIST_SPECIES;
      final _value = ListSpeciesBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 3) {
      final _kind = FgpRequestKind.ADD_NEW_REGION;
      final _value = AddNewRegionBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 4) {
      final _kind = FgpRequestKind.UPDATE_REGION;
      final _value = UpdateRegionBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 5) {
      final _kind = FgpRequestKind.LIST_REGIONS;
      final _value = ListRegionsBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 6) {
      final _kind = FgpRequestKind.LIST_SPECIES_REGIONS;
      final _value = ListSpeciesRegionsBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 7) {
      final _kind = FgpRequestKind.ADD_SPECIES_REGION;
      final _value = AddSpeciesRegionBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 8) {
      final _kind = FgpRequestKind.DISABLE_SPECIES_REGION;
      final _value = DisableSpeciesRegionBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 9) {
      final _kind = FgpRequestKind.DELETE_SPECIES_REGION;
      final _value = DeleteSpeciesRegionBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 10) {
      final _kind = FgpRequestKind.UPDATE_PRICE;
      final _value = UpdatePriceBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 11) {
      final _kind = FgpRequestKind.LIST_PRICES_FOR_DATE;
      final _value = ListPricesForDateBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    if (bareIdx == 12) {
      final _kind = FgpRequestKind.LIST_QUARTERLY_PRICES;
      final _value = ListQuarterlyPricesBare.unpack(p);
      return FgpRequest(kind: _kind, value: _value);
    }

    throw ('Invalid FgpRequest union option -  ${bareIdx}');
  }
}

extension FgpRequestKindBare on FgpRequestKind {
  int get getBareIdx {
    if (this == FgpRequestKind.ADD_NEW_SPECIES) return 0;
    if (this == FgpRequestKind.UPDATE_SPECIES) return 1;
    if (this == FgpRequestKind.LIST_SPECIES) return 2;
    if (this == FgpRequestKind.ADD_NEW_REGION) return 3;
    if (this == FgpRequestKind.UPDATE_REGION) return 4;
    if (this == FgpRequestKind.LIST_REGIONS) return 5;
    if (this == FgpRequestKind.LIST_SPECIES_REGIONS) return 6;
    if (this == FgpRequestKind.ADD_SPECIES_REGION) return 7;
    if (this == FgpRequestKind.DISABLE_SPECIES_REGION) return 8;
    if (this == FgpRequestKind.DELETE_SPECIES_REGION) return 9;
    if (this == FgpRequestKind.UPDATE_PRICE) return 10;
    if (this == FgpRequestKind.LIST_PRICES_FOR_DATE) return 11;
    if (this == FgpRequestKind.LIST_QUARTERLY_PRICES) return 12;
    throw ('Invalid FgpRequest union option - ${this}');
  }
}

extension FgpResponseBare on FgpResponse {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static FgpResponse fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    final bareIdx = kind.getBareIdx;
    p.packUint8(bareIdx);

    if (bareIdx == 0) (value as SpeciesList).pack(p);
    if (bareIdx == 1) (value as RegionList).pack(p);
    if (bareIdx == 2) (value as SpeciesRegionList).pack(p);
    if (bareIdx == 3) (value as SpeciesRegion).pack(p);
    if (bareIdx == 4) (value as AnimalPriceList).pack(p);
    if (bareIdx == 5) (value as QuarterlyPriceList).pack(p);
    if (bareIdx == 6) (value as AppResponse).pack(p);
    return p;
  }

  static FgpResponse unpack(Unpacker p) {
    final bareIdx = p.unpackUint8();

    if (bareIdx == 0) {
      final _kind = FgpResponseKind.SPECIES_LIST;
      final _value = SpeciesListBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 1) {
      final _kind = FgpResponseKind.REGION_LIST;
      final _value = RegionListBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 2) {
      final _kind = FgpResponseKind.SPECIES_REGION_LIST;
      final _value = SpeciesRegionListBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 3) {
      final _kind = FgpResponseKind.SPECIES_REGION;
      final _value = SpeciesRegionBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 4) {
      final _kind = FgpResponseKind.ANIMAL_PRICE_LIST;
      final _value = AnimalPriceListBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 5) {
      final _kind = FgpResponseKind.QUARTERLY_PRICE_LIST;
      final _value = QuarterlyPriceListBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    if (bareIdx == 6) {
      final _kind = FgpResponseKind.APP_RESPONSE;
      final _value = AppResponseBare.unpack(p);
      return FgpResponse(kind: _kind, value: _value);
    }

    throw ('Invalid FgpResponse union option -  ${bareIdx}');
  }
}

extension FgpResponseKindBare on FgpResponseKind {
  int get getBareIdx {
    if (this == FgpResponseKind.SPECIES_LIST) return 0;
    if (this == FgpResponseKind.REGION_LIST) return 1;
    if (this == FgpResponseKind.SPECIES_REGION_LIST) return 2;
    if (this == FgpResponseKind.SPECIES_REGION) return 3;
    if (this == FgpResponseKind.ANIMAL_PRICE_LIST) return 4;
    if (this == FgpResponseKind.QUARTERLY_PRICE_LIST) return 5;
    if (this == FgpResponseKind.APP_RESPONSE) return 6;
    throw ('Invalid FgpResponse union option - ${this}');
  }
}
