/*
 * Package : Bare
 * Author : kāśyapan <vichitraveeryan@gmail.com>
 * Date   : 20/03/2022
 * Copyright : kāśyapan
 */
import 'package:test/test.dart';
import '../lib/schema.dart';
import 'package:collection/collection.dart';
import 'package:fixnum/fixnum.dart';

Function deepEq = const DeepCollectionEquality().equals;

void main() {
  // Common

  test('Employee pack -> ', () {
    final e = Employee(value: "My Employee");
    final byts = e.toBare();
    final e1 = Employee.fromBare(byts);
    expect(e.toString(), e1.toString());
  });
  test('Customers pack -> ', () {
    final e = Customer(
        name: "The Joker",
        address: Address(),
        email: 'apple@google.com',
        somedata1: [11, 77, 121, 32],
        somedata2: [11, 77, 121, 32],
        somedata3: [11, 77, 121, 32],
        somedata4: [11, 77, 121, 32],
        department: Department.ACCOUNTING,
        orders: [Orders4(orderId: "true", orderDesc: "fld2")]); //
    final byts = e.toBare();
    final e1 = Customer.fromBare(byts);
    expect(e.toString(), e1.toString());
  });

  test('Numfields pack -> ', () {
    final e = NumFields(
      fld1: Int64(1),
      fld2: 1,
      fld3: 1,
      fld4: 1,
      fld5: Int64(1),
      fld6: Int64(1),
      fld7: 1,
      fld8: 1,
      fld9: 1,
      fld10: Int64(1),
      fld11: 1.2,
      fld12: 1.2,
    );
    final byts = e.toBare();
    final e1 = NumFields.fromBare(byts);
    expect(e.toString(), e1.toString());
  });

  test('Primitive pack -> ', () {
    final numfields = NumFields(
      fld1: Int64(1),
      fld2: 1,
      fld3: 1,
      fld4: 1,
      fld5: Int64(1),
      fld6: Int64(1),
      fld7: 1,
      fld8: 1,
      fld9: 1,
      fld10: Int64(1),
      fld11: 1.2,
      fld12: 1.2,
    );
    final e =
        PrimitiveFields(fld1: true, numfields: numfields, fld2: "some string");
    final byts = e.toBare();
    final e1 = PrimitiveFields.fromBare(byts);
    expect(e.toString(), e1.toString());
  });
  test('Aggregate pack -> ', () {
    final e = AggregateFields(
        list1: ["str1", "str2"],
        list2: [],
        list3: ['a', 'b', 'c', 'd'],
        map1: {'a': '1', 'b': '2'},
        anon1: [Anon11(fld1: true, fld2: "3")],
        anon2: [],
        anon3: Anon33(fld1: false, fld2: "fld2"));
    final byts = e.toBare();
    final e1 = AggregateFields.fromBare(byts);
    expect(e.toString(), e1.toString());
  });

  test('Aggregate pack 2 -> ', () {
    final numfields = NumFields(
      fld1: Int64(1),
      fld2: 1,
      fld3: 1,
      fld4: 1,
      fld5: Int64(1),
      fld6: Int64(1),
      fld7: 1,
      fld8: 1,
      fld9: 1,
      fld10: Int64(1),
      fld11: 1.2,
      fld12: 1.2,
    );
    final e = AggregateFields(
        list1: ["str1", "str2"],
        list2: ["a"],
        list3: ['a', 'b', 'c', 'd'],
        map1: {'a': '1', 'b': '2'},
        opt1: "String1",
        opt2: numfields,
        opt3: ['a', 'b'],
        opt4: {'a': '1', 'b': '2'},
        anon1: [Anon11(fld1: true, fld2: "3")],
        anon2: [
          Anon22(kind: Anon22Kind.EMPLOYEE, value: Employee(value: "value"))
        ],
        anon3: Anon33(fld1: false, fld2: "fld2"));
    final byts = e.toBare();
    final e1 = AggregateFields.fromBare(byts);
    expect(e.toString(), e1.toString());
  });
  test('Record type 1 -> ', () {
    final e = RecordType(kind: RecordTypeKind.ADDRESS, value: Address());
    final byts = e.toBare();
    final e1 = RecordType.fromBare(byts);
    expect(e.toString(), e1.toString());
  });

  test('Record type 2 -> ', () {
    final customer = Customer(
        name: "The Joker",
        address: Address(),
        email: 'apple@google.com',
        somedata1: [11, 77, 121, 32],
        somedata2: [11, 77, 121, 32],
        somedata3: [11, 77, 121, 32],
        somedata4: [11, 77, 121, 32],
        department: Department.ACCOUNTING,
        orders: [Orders4(orderId: "true", orderDesc: "fld2")]); //

    final e = RecordType(kind: RecordTypeKind.CUSTOMER, value: customer);
    final byts = e.toBare();
    final e1 = RecordType.fromBare(byts);
    expect(e.toString(), e1.toString());
  });

  test('Record type 3 -> ', () {
    final numfields = NumFields(
      fld1: Int64(1),
      fld2: 1,
      fld3: 1,
      fld4: 1,
      fld5: Int64(1),
      fld6: Int64(1),
      fld7: 1,
      fld8: 1,
      fld9: 1,
      fld10: Int64(1),
      fld11: 1.2,
      fld12: 1.2,
    );
    final aggregateFields = AggregateFields(
        list1: ["str1", "str2"],
        list2: ["a"],
        list3: ['a', 'b', 'c', 'd'],
        map1: {'a': '1', 'b': '2'},
        opt1: "String1",
        opt2: numfields,
        opt3: ['a', 'b'],
        opt4: {'a': '1', 'b': '2'},
        anon1: [Anon11(fld1: true, fld2: "3")],
        anon2: [
          Anon22(
              kind: Anon22Kind.EMPLOYEE,
              value: Employee(value: "Employee value"))
        ],
        anon3: Anon33(fld1: false, fld2: "fld2"));

    final e = RecordType(
        kind: RecordTypeKind.AGGREGATE_FIELDS, value: aggregateFields);
    final byts = e.toBare();
    final e1 = RecordType.fromBare(byts);
    expect(e.toString(), e1.toString());
  });
}
