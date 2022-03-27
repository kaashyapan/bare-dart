/////////////////////////////////////////////////////////////////
// Generated code by bare_codegen - Fri, Apr 01, 2022 03:45 AM //
/////////////////////////////////////////////////////////////////

part of 'schema.dart';

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
    p.packString(value);
    return p;
  }

  static Employee unpack(Unpacker p) {
    final value = p.unpackString();
    return Employee(value: value);
  }
}

extension TerminatedEmployeeBare on TerminatedEmployee {
  Packer pack(Packer p) {
    return p;
  }

  static TerminatedEmployee unpack(Unpacker p) {
    return TerminatedEmployee();
  }
}

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

extension AddressBare on Address {
  Packer pack(Packer p) {
    return p;
  }

  static Address unpack(Unpacker p) {
    return Address();
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

extension NumFieldsBare on NumFields {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static NumFields fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packInt64(fld1);
    p.packInt8(fld2);
    p.packInt16(fld3);
    p.packInt32(fld4);
    p.packInt64(fld5);
    p.packUint64(fld6);
    p.packUint8(fld7);
    p.packUint16(fld8);
    p.packUint32(fld9);
    p.packUint64(fld10);
    p.packDouble(fld11);
    p.packDouble(fld12);
    return p;
  }

  static NumFields unpack(Unpacker p) {
    final fld1 = p.unpackInt64();
    final fld2 = p.unpackInt8();
    final fld3 = p.unpackInt16();
    final fld4 = p.unpackInt32();
    final fld5 = p.unpackInt64();
    final fld6 = p.unpackUint64();
    final fld7 = p.unpackUint8();
    final fld8 = p.unpackUint16();
    final fld9 = p.unpackUint32();
    final fld10 = p.unpackUint64();
    final fld11 = p.unpackDouble();
    final fld12 = p.unpackDouble();
    return NumFields(
        fld1: fld1,
        fld2: fld2,
        fld3: fld3,
        fld4: fld4,
        fld5: fld5,
        fld6: fld6,
        fld7: fld7,
        fld8: fld8,
        fld9: fld9,
        fld10: fld10,
        fld11: fld11,
        fld12: fld12);
  }
}

extension PrimitiveFieldsBare on PrimitiveFields {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static PrimitiveFields fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packBool(fld1);
    numfields.pack(p);
    p.packString(fld2);
    return p;
  }

  static PrimitiveFields unpack(Unpacker p) {
    final fld1 = p.unpackBool();
    NumFields numfields;
    numfields = NumFieldsBare.unpack(p);

    final fld2 = p.unpackString();
    return PrimitiveFields(fld1: fld1, numfields: numfields, fld2: fld2);
  }
}

extension AggregateFieldsBare on AggregateFields {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static AggregateFields fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packLength(list1.length);
    list1.forEach((e) => p.packString(e));

    p.packLength(list2.length);
    list2.forEach((e) => p.packString(e));

    p.packLength(list3.length);
    list3.forEach((e) => p.packString(e));

    p.packLength(map1.length);
    map1.forEach((k, v) {
      p.packString(k);
      p.packString(v);
    });

    p.packStringOptional(opt1);
    if (opt2 == null) {
      p.packNull();
    } else {
      p.packNonNull();
      opt2!.pack(p);
    }
    ;
    if (opt3 == null) {
      p.packNull();
    } else {
      p.packNonNull();
      p.packLength(opt3!.length);
      opt3!.forEach((e) => p.packString(e));
    }
    ;
    if (opt4 == null) {
      p.packNull();
    } else {
      p.packNonNull();
      p.packLength(opt4!.length);
      opt4!.forEach((k, v) {
        p.packString(k);
        p.packString(v);
      });
    }
    ;
    p.packLength(anon1.length);
    anon1.forEach((e) => e.pack(p));

    p.packLength(anon2.length);
    anon2.forEach((e) => e.pack(p));

    anon3.pack(p);
    return p;
  }

  static AggregateFields unpack(Unpacker p) {
    List<String> list1;
    list1 = <String>[];
    final list1Length = p.unpackLength();
    for (var i = 0; i < list1Length; i++) {
      final e = p.unpackString();
      list1.add(e);
    }

    List<String> list2;
    list2 = <String>[];
    final list2Length = p.unpackLength();
    for (var i = 0; i < list2Length; i++) {
      final e = p.unpackString();
      list2.add(e);
    }

    List<String> list3;
    list3 = <String>[];
    final list3Length = p.unpackLength();
    for (var i = 0; i < list3Length; i++) {
      final e = p.unpackString();
      list3.add(e);
    }

    Map<String, String> map1;
    List<MapEntry<String, String>> entries = [];
    final map1Length = p.unpackLength();
    for (var i = 0; i < map1Length; i++) {
      final k = p.unpackString();
      final v = p.unpackString();
      entries.add(MapEntry(k, v));
    }
    final _map1 = <String, String>{};
    _map1.addEntries(entries);
    map1 = _map1;

    final opt1 = p.unpackStringOptional();
    NumFields? opt2;
    if (p.unpackNull()) {
      opt2 = null;
    } else {
      opt2 = NumFieldsBare.unpack(p);
    }
    ;
    List<String>? opt3;
    if (p.unpackNull()) {
      opt3 = null;
    } else {
      opt3 = <String>[];
      final opt3Length = p.unpackLength();
      for (var i = 0; i < opt3Length; i++) {
        final e = p.unpackString();
        opt3.add(e);
      }
    }
    ;
    Map<String, String>? opt4;
    if (p.unpackNull()) {
      opt4 = null;
    } else {
      List<MapEntry<String, String>> entries = [];
      final opt4Length = p.unpackLength();
      for (var i = 0; i < opt4Length; i++) {
        final k = p.unpackString();
        final v = p.unpackString();
        entries.add(MapEntry(k, v));
      }
      final _map1 = <String, String>{};
      _map1.addEntries(entries);
      opt4 = _map1;
    }
    ;
    List<Anon1> anon1;
    anon1 = <Anon1>[];
    final anon1Length = p.unpackLength();
    for (var i = 0; i < anon1Length; i++) {
      final e = Anon1Bare.unpack(p);
      anon1.add(e);
    }

    List<Anon2> anon2;
    anon2 = <Anon2>[];
    final anon2Length = p.unpackLength();
    for (var i = 0; i < anon2Length; i++) {
      final e = Anon2Bare.unpack(p);
      anon2.add(e);
    }

    final anon3 = Anon3Bare.unpack(p);
    return AggregateFields(
        list1: list1,
        list2: list2,
        list3: list3,
        map1: map1,
        opt1: opt1,
        opt2: opt2,
        opt3: opt3,
        opt4: opt4,
        anon1: anon1,
        anon2: anon2,
        anon3: anon3);
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
    department.pack(p);
    p.packBinary(somedata1);
    p.packBinaryFixedLength(4, somedata2);
    p.packBinaryOptional(somedata3);
    p.packBinaryFixedLengthOptional(4, somedata4);
    p.packLength(orders.length);
    orders.forEach((e) => e.pack(p));

    return p;
  }

  static Customer unpack(Unpacker p) {
    final name = p.unpackString();
    final email = p.unpackString();
    Address address;
    address = AddressBare.unpack(p);

    Department department;
    department = DepartmentBare.unpack(p);

    final somedata1 = p.unpackBinary();
    final somedata2 = p.unpackBinaryFixedLength(4);
    final somedata3 = p.unpackBinaryOptional();
    final somedata4 = p.unpackBinaryFixedLengthOptional(4);
    List<Anon4> orders;
    orders = <Anon4>[];
    final ordersLength = p.unpackLength();
    for (var i = 0; i < ordersLength; i++) {
      final e = Anon4Bare.unpack(p);
      orders.add(e);
    }

    return Customer(
        name: name,
        email: email,
        address: address,
        department: department,
        somedata1: somedata1,
        somedata2: somedata2,
        somedata3: somedata3,
        somedata4: somedata4,
        orders: orders);
  }
}

extension RecordTypeBare on RecordType {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static RecordType fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    final bareIdx = kind.getBareIdx;
    p.packUint64(Int64(bareIdx));

    if (bareIdx == 0) (value as Customer).pack(p);
    if (bareIdx == 1) (value as AggregateFields).pack(p);
    if (bareIdx == 2) (value as PrimitiveFields).pack(p);
    if (bareIdx == 90) (value as Address).pack(p);
    if (bareIdx == 91) (value as Department).pack(p);
    return p;
  }

  static RecordType unpack(Unpacker p) {
    final bareIdx = p.unpackUint64().toInt();

    if (bareIdx == 0) {
      final _kind = RecordTypeKind.CUSTOMER;
      final _value = CustomerBare.unpack(p);
      return RecordType(kind: _kind, value: _value);
    }

    if (bareIdx == 1) {
      final _kind = RecordTypeKind.AGGREGATE_FIELDS;
      final _value = AggregateFieldsBare.unpack(p);
      return RecordType(kind: _kind, value: _value);
    }

    if (bareIdx == 2) {
      final _kind = RecordTypeKind.PRIMITIVE_FIELDS;
      final _value = PrimitiveFieldsBare.unpack(p);
      return RecordType(kind: _kind, value: _value);
    }

    if (bareIdx == 90) {
      final _kind = RecordTypeKind.ADDRESS;
      final _value = AddressBare.unpack(p);
      return RecordType(kind: _kind, value: _value);
    }

    if (bareIdx == 91) {
      final _kind = RecordTypeKind.DEPARTMENT;
      final _value = DepartmentBare.unpack(p);
      return RecordType(kind: _kind, value: _value);
    }

    throw ('Invalid RecordType enum option');
  }
}

extension RecordTypeKindBare on RecordTypeKind {
  int get getBareIdx {
    if (this == RecordTypeKind.CUSTOMER) return 0;
    if (this == RecordTypeKind.AGGREGATE_FIELDS) return 1;
    if (this == RecordTypeKind.PRIMITIVE_FIELDS) return 2;
    if (this == RecordTypeKind.ADDRESS) return 90;
    if (this == RecordTypeKind.DEPARTMENT) return 91;
    throw ('Invalid RecordType enum option');
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
    p.packBool(fld1);
    p.packString(fld2);
    return p;
  }

  static Anon1 unpack(Unpacker p) {
    final fld1 = p.unpackBool();
    final fld2 = p.unpackString();
    return Anon1(fld1: fld1, fld2: fld2);
  }
}

extension Anon2Bare on Anon2 {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Anon2 fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    final bareIdx = kind.getBareIdx;
    p.packUint64(Int64(bareIdx));

    if (bareIdx == 0) (value as Employee).pack(p);
    if (bareIdx == 1) (value as TerminatedEmployee).pack(p);
    return p;
  }

  static Anon2 unpack(Unpacker p) {
    final bareIdx = p.unpackUint64().toInt();

    if (bareIdx == 0) {
      final _kind = Anon2Kind.EMPLOYEE;
      final _value = EmployeeBare.unpack(p);
      return Anon2(kind: _kind, value: _value);
    }

    if (bareIdx == 1) {
      final _kind = Anon2Kind.TERMINATED_EMPLOYEE;
      final _value = TerminatedEmployeeBare.unpack(p);
      return Anon2(kind: _kind, value: _value);
    }

    throw ('Invalid Anon2 enum option');
  }
}

extension Anon2KindBare on Anon2Kind {
  int get getBareIdx {
    if (this == Anon2Kind.EMPLOYEE) return 0;
    if (this == Anon2Kind.TERMINATED_EMPLOYEE) return 1;
    throw ('Invalid Anon2 enum option');
  }
}

extension Anon3Bare on Anon3 {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Anon3 fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packBool(fld1);
    p.packStringOptional(fld2);
    return p;
  }

  static Anon3 unpack(Unpacker p) {
    final fld1 = p.unpackBool();
    final fld2 = p.unpackStringOptional();
    return Anon3(fld1: fld1, fld2: fld2);
  }
}

extension Anon4Bare on Anon4 {
  Uint8List toBare() {
    final x = Packer();
    pack(x);
    return x.takeBytes();
  }

  static Anon4 fromBare(data) {
    Unpacker unpacker = Unpacker.fromList(data);
    return unpack(unpacker);
  }

  Packer pack(Packer p) {
    p.packString(orderId);
    p.packString(orderDesc);
    return p;
  }

  static Anon4 unpack(Unpacker p) {
    final orderId = p.unpackString();
    final orderDesc = p.unpackString();
    return Anon4(orderId: orderId, orderDesc: orderDesc);
  }
}
