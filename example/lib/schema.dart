/////////////////////////////////////////////////////////////////
// Generated code by bare_codegen - Fri, Apr 01, 2022 03:45 AM //
/////////////////////////////////////////////////////////////////

import 'package:bare/bare.dart';
import 'package:fixnum/fixnum.dart';
import 'dart:typed_data';

part 'schema.bare.dart';

class Employee {
  String value;
  Employee({required this.value});

  static Employee fromBare(data) => EmployeeBare.fromBare(data);

  String toString() => 'Employee {${value}}';
}

class TerminatedEmployee {
  TerminatedEmployee(); // Bare void type
}

class PublicKey {
  List<int> value;
  PublicKey({required this.value});

  static PublicKey fromBare(data) => PublicKeyBare.fromBare(data);

  String toString() => 'PublicKey {${value}}';
}

class Time {
  String value;
  Time({required this.value});

  static Time fromBare(data) => TimeBare.fromBare(data);

  String toString() => 'Time {${value}}';
}

class Address {
  Address(); // Bare void type
}

enum Department {
  ACCOUNTING,
  ADMINISTRATION,
  CUSTOMER_SERVICE,
  DEVELOPMENT,
  JSMITH,
}

class NumFields {
  Int64 fld1;
  int fld2;
  int fld3;
  int fld4;
  Int64 fld5;
  Int64 fld6;
  int fld7;
  int fld8;
  int fld9;
  Int64 fld10;
  double fld11;
  double fld12;
  NumFields(
      {required this.fld1,
      required this.fld2,
      required this.fld3,
      required this.fld4,
      required this.fld5,
      required this.fld6,
      required this.fld7,
      required this.fld8,
      required this.fld9,
      required this.fld10,
      required this.fld11,
      required this.fld12});

  static NumFields fromBare(data) => NumFieldsBare.fromBare(data);

  @override
  String toString() =>
      'NumFields { fld1: ${fld1}, fld2: ${fld2}, fld3: ${fld3}, fld4: ${fld4}, fld5: ${fld5}, fld6: ${fld6}, fld7: ${fld7}, fld8: ${fld8}, fld9: ${fld9}, fld10: ${fld10}, fld11: ${fld11}, fld12: ${fld12} }';
}

class PrimitiveFields {
  bool fld1;
  NumFields numfields;
  String fld2;
  PrimitiveFields(
      {required this.fld1, required this.numfields, required this.fld2});

  static PrimitiveFields fromBare(data) => PrimitiveFieldsBare.fromBare(data);

  @override
  String toString() =>
      'PrimitiveFields { fld1: ${fld1}, numfields: ${numfields}, fld2: ${fld2} }';
}

class AggregateFields {
  List<String> list1;
  List<String> list2;
  List<String> list3;
  Map<String, String> map1;
  String? opt1;
  NumFields? opt2;
  List<String>? opt3;
  Map<String, String>? opt4;
  List<Anon1> anon1;
  List<Anon2> anon2;
  Anon3 anon3;
  AggregateFields(
      {required this.list1,
      required this.list2,
      required this.list3,
      required this.map1,
      this.opt1,
      this.opt2,
      this.opt3,
      this.opt4,
      required this.anon1,
      required this.anon2,
      required this.anon3});

  static AggregateFields fromBare(data) => AggregateFieldsBare.fromBare(data);

  @override
  String toString() =>
      'AggregateFields { list1: ${list1}, list2: ${list2}, list3: ${list3}, map1: ${map1}, opt1: ${opt1}, opt2: ${opt2}, opt3: ${opt3}, opt4: ${opt4}, anon1: ${anon1}, anon2: ${anon2}, anon3: ${anon3} }';
}

class Customer {
  String name;
  String email;
  Address address;
  Department department;
  List<int> somedata1;
  List<int> somedata2;
  List<int>? somedata3;
  List<int>? somedata4;
  List<Anon4> orders;
  Customer(
      {required this.name,
      required this.email,
      required this.address,
      required this.department,
      required this.somedata1,
      required this.somedata2,
      this.somedata3,
      this.somedata4,
      required this.orders});

  static Customer fromBare(data) => CustomerBare.fromBare(data);

  @override
  String toString() =>
      'Customer { name: ${name}, email: ${email}, address: ${address}, department: ${department}, somedata1: ${somedata1}, somedata2: ${somedata2}, somedata3: ${somedata3}, somedata4: ${somedata4}, orders: ${orders} }';
}

enum RecordTypeKind {
  CUSTOMER,
  AGGREGATE_FIELDS,
  PRIMITIVE_FIELDS,
  ADDRESS,
  DEPARTMENT,
}

class RecordType {
  RecordTypeKind kind;
  dynamic value;

  RecordType({required this.kind, required this.value});

  static RecordType fromBare(data) => RecordTypeBare.fromBare(data);

  @override
  String toString() => '${kind}  ${value}';
}

class Anon1 {
  bool fld1;
  String fld2;
  Anon1({required this.fld1, required this.fld2});

  static Anon1 fromBare(data) => Anon1Bare.fromBare(data);

  @override
  String toString() => 'Anon1 { fld1: ${fld1}, fld2: ${fld2} }';
}

enum Anon2Kind {
  EMPLOYEE,
  TERMINATED_EMPLOYEE,
}

class Anon2 {
  Anon2Kind kind;
  dynamic value;

  Anon2({required this.kind, required this.value});

  static Anon2 fromBare(data) => Anon2Bare.fromBare(data);

  @override
  String toString() => '${kind}  ${value}';
}

class Anon3 {
  bool fld1;
  String? fld2;
  Anon3({required this.fld1, this.fld2});

  static Anon3 fromBare(data) => Anon3Bare.fromBare(data);

  @override
  String toString() => 'Anon3 { fld1: ${fld1}, fld2: ${fld2} }';
}

class Anon4 {
  String orderId;
  String orderDesc;
  Anon4({required this.orderId, required this.orderDesc});

  static Anon4 fromBare(data) => Anon4Bare.fromBare(data);

  @override
  String toString() => 'Anon4 { orderId: ${orderId}, orderDesc: ${orderDesc} }';
}
