/////////////////////////////////////////////////////////////////
// Generated code by bare_codegen - Fri, Apr 01, 2022 03:45 AM //
/////////////////////////////////////////////////////////////////

import 'package:bare/bare.dart';
import 'package:fixnum/fixnum.dart';
import 'dart:typed_data';

part 'bare_sample.bare.dart';

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

enum Department {
  ACCOUNTING,
  ADMINISTRATION,
  CUSTOMER_SERVICE,
  DEVELOPMENT,
  JSMITH,
}

class Address {
  List<String> address;
  String city;
  String state;
  String country;
  Address(
      {required this.address,
      required this.city,
      required this.state,
      required this.country});

  static Address fromBare(data) => AddressBare.fromBare(data);

  @override
  String toString() =>
      'Address { address: ${address}, city: ${city}, state: ${state}, country: ${country} }';
}

class Customer {
  String name;
  String email;
  Address address;
  List<Anon1> orders;
  Map<String, List<int>> metadata;
  Customer(
      {required this.name,
      required this.email,
      required this.address,
      required this.orders,
      required this.metadata});

  static Customer fromBare(data) => CustomerBare.fromBare(data);

  @override
  String toString() =>
      'Customer { name: ${name}, email: ${email}, address: ${address}, orders: ${orders}, metadata: ${metadata} }';
}

class Employee {
  String name;
  String email;
  Address address;
  Department department;
  Time hireDate;
  PublicKey? publicKey;
  Map<String, List<int>> metadata;
  Employee(
      {required this.name,
      required this.email,
      required this.address,
      required this.department,
      required this.hireDate,
      this.publicKey,
      required this.metadata});

  static Employee fromBare(data) => EmployeeBare.fromBare(data);

  @override
  String toString() =>
      'Employee { name: ${name}, email: ${email}, address: ${address}, department: ${department}, hireDate: ${hireDate}, publicKey: ${publicKey}, metadata: ${metadata} }';
}

class Anon1 {
  Int64 orderId;
  int quantity;
  Anon1({required this.orderId, required this.quantity});

  static Anon1 fromBare(data) => Anon1Bare.fromBare(data);

  @override
  String toString() => 'Anon1 { orderId: ${orderId}, quantity: ${quantity} }';
}