/////////////////////////////////////////////////////////////////
// Generated code by bare_codegen - Fri, Apr 01, 2022 03:45 AM //
/////////////////////////////////////////////////////////////////

part of 'bare_sample.dart';

extension PublicKeyBare on PublicKey {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static PublicKey fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packBinaryFixedLength(128, value);
    return p;
  }

  static PublicKey unpack(Unpacker p) {
    final value = p.unpackBinaryFixedLength(128);
    return PublicKey(value: value);
  }
}

extension TimeBare on Time {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Time fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(value);
    return p;
  }

  static Time unpack(Unpacker p) {
    final value = p.unpackString();
    return Time(value: value);
  }
}

extension DepartmentBare on Department {
  Packer pack(Packer p) {
    p.packUint64(Int64(_getBareIdx));
    return p;
  }

  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Department fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  static Department unpack(Unpacker data) {
    final bareIdx = data.unpackUint64().toInt();

    if (bareIdx == 0) return Department.ACCOUNTING;
    if (bareIdx == 1) return Department.ADMINISTRATION;
    if (bareIdx == 2) return Department.CUSTOMER_SERVICE;
    if (bareIdx == 3) return Department.DEVELOPMENT;
    if (bareIdx == 99) return Department.JSMITH;
    throw ('Invalid Department enum option');
  }

  int get _getBareIdx {
    switch (this) {
      case Department.ACCOUNTING:
        return 0;
      case Department.ADMINISTRATION:
        return 1;
      case Department.CUSTOMER_SERVICE:
        return 2;
      case Department.DEVELOPMENT:
        return 3;
      case Department.JSMITH:
        return 99;
      default:
        throw ('Invalid Department enum option');
    }
  }
}

extension AddressBare on Address {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Address fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(address.length);
    address.forEach((e) => p.packString(e));

    p.packString(city);
    p.packString(state);
    p.packString(country);
    return p;
  }

  static Address unpack(Unpacker p) {
    List<String> address;
    address = <String>[];
    final addressLength = p.unpackLength();
    for (var i = 0; i < addressLength; i++) {
      final e = p.unpackString();
      address.add(e);
    }

    final city = p.unpackString();
    final state = p.unpackString();
    final country = p.unpackString();
    return Address(
        address: address, city: city, state: state, country: country);
  }
}

extension CustomerBare on Customer {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Customer fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(name);
    p.packString(email);
    address.pack(p);
    p.packLength(orders.length);
    orders.forEach((e) => e.pack(p));

    p.packLength(metadata.length);
    metadata.forEach((k, v) {
      p.packString(k);
      p.packBinary(v);
    });

    return p;
  }

  static Customer unpack(Unpacker p) {
    final name = p.unpackString();
    final email = p.unpackString();
    Address address;
    address = AddressBare.unpack(p);

    List<Anon1> orders;
    orders = <Anon1>[];
    final ordersLength = p.unpackLength();
    for (var i = 0; i < ordersLength; i++) {
      final e = Anon1Bare.unpack(p);
      orders.add(e);
    }

    Map<String, List<int>> metadata;
    List<MapEntry<String, List<int>>> entries = [];
    final metadataLength = p.unpackLength();
    for (var i = 0; i < metadataLength; i++) {
      final k = p.unpackString();
      final v = p.unpackBinary();
      entries.add(MapEntry(k, v));
    }
    final _map1 = <String, List<int>>{};
    _map1.addEntries(entries);
    metadata = _map1;

    return Customer(
        name: name,
        email: email,
        address: address,
        orders: orders,
        metadata: metadata);
  }
}

extension EmployeeBare on Employee {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Employee fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(name);
    p.packString(email);
    address.pack(p);
    department.pack(p);
    hireDate.pack(p);
    if (publicKey == null) {
      p.packNull();
    } else {
      p.packNonNull();
      publicKey!.pack(p);
    }
    ;
    p.packLength(metadata.length);
    metadata.forEach((k, v) {
      p.packString(k);
      p.packBinary(v);
    });

    return p;
  }

  static Employee unpack(Unpacker p) {
    final name = p.unpackString();
    final email = p.unpackString();
    Address address;
    address = AddressBare.unpack(p);

    Department department;
    department = DepartmentBare.unpack(p);

    Time hireDate;
    hireDate = TimeBare.unpack(p);

    PublicKey? publicKey;
    if (p.unpackNull()) {
      publicKey = null;
    } else {
      publicKey = PublicKeyBare.unpack(p);
    }
    ;
    Map<String, List<int>> metadata;
    List<MapEntry<String, List<int>>> entries = [];
    final metadataLength = p.unpackLength();
    for (var i = 0; i < metadataLength; i++) {
      final k = p.unpackString();
      final v = p.unpackBinary();
      entries.add(MapEntry(k, v));
    }
    final _map1 = <String, List<int>>{};
    _map1.addEntries(entries);
    metadata = _map1;

    return Employee(
        name: name,
        email: email,
        address: address,
        department: department,
        hireDate: hireDate,
        publicKey: publicKey,
        metadata: metadata);
  }
}

extension Anon1Bare on Anon1 {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Anon1 fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packInt64(orderId);
    p.packInt32(quantity);
    return p;
  }

  static Anon1 unpack(Unpacker p) {
    final orderId = p.unpackInt64();
    final quantity = p.unpackInt32();
    return Anon1(orderId: orderId, quantity: quantity);
  }
}
