// ignore_for_file: omit_local_variable_types, prefer_single_quotes

import 'dart:convert';
import 'dart:typed_data';
import 'package:fixnum/fixnum.dart';

class Unpacker {
  Unpacker(this._list) : _d = ByteData.view(_list.buffer, _list.offsetInBytes);

  ///Convenient
  Unpacker.fromList(List<int> l) : this(Uint8List.fromList(l));

  final Uint8List _list;
  final ByteData _d;
  int _offset = 0;

  final _strCodec = const Utf8Codec();

  bool unpackNull() {
    final nullByte = _d.getUint8(_offset);
    _offset++;
    if (nullByte == 0x00) {
      return true;
    } else if (nullByte == 0x01) {
      return false;
    }
    throw _formatException(
        'Invalid null indicator at offset ${_offset - 1}', nullByte);
  }

  bool? unpackBoolOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackBool();
    }
  }

  bool unpackBool() {
    final booleanByte = _d.getUint8(_offset);
    _offset++;
    if (booleanByte == 0x00) {
      return false;
    } else if (booleanByte == 0x01) {
      return true;
    }
    throw _formatException('bool', booleanByte);
  }

  int? unpackInt8Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackInt8();
    }
  }

  int unpackInt8() {
    final byte = _d.getInt8(_offset);
    _offset++;
    return byte;
  }

  int? unpackUint8Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackUint8();
    }
  }

  int unpackUint8() {
    final byte = _d.getUint8(_offset);
    _offset += 1;
    return byte;
  }

  int? unpackInt16Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackInt16();
    }
  }

  int unpackInt16() {
    final byte = _d.getInt16(_offset, Endian.little);
    _offset += 2;
    return byte;
  }

  int? unpackUint16Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackUint16();
    }
  }

  int unpackUint16() {
    final byte = _d.getUint16(_offset, Endian.little);
    _offset += 2;
    return byte;
  }

  int? unpackInt32Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackInt32();
    }
  }

  int unpackInt32() {
    final byte = _d.getInt32(_offset, Endian.little);
    _offset += 4;
    return byte;
  }

  int? unpackUint32Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackUint32();
    }
  }

  int unpackUint32() {
    final bytes = _d.getUint32(_offset, Endian.little);
    _offset += 4;
    return bytes;
  }

  /// unpack [int] or `null`.
  Int64? unpackInt64Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackInt64();
    }
  }

  Int64 unpackInt64() {
    final value = _d.getInt64(_offset, Endian.little);
    _offset += 8;
    return Int64(value);
  }

  Int64? unpackUint64Optional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackUint64();
    }
  }

  Int64 unpackUint64() {
    final value = _d.getUint64(_offset, Endian.little);
    _offset += 8;
    return Int64(value);
  }

  Int64 unpackUint() {
    final value = _list.skip(_offset).take(8).toList();
    return decoder_uint(value);
  }

  Int64? unpackUintOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackUint();
    }
  }

  Int64 unpackInt() {
    final uint = unpackUint().shiftRightUnsigned(1);
    if ((uint & Int64.ONE) == Int64.ONE) {
      return ~uint;
    } else {
      return uint;
    }
  }

  Int64? unpackIntOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackInt();
    }
  }

  /// unpack [double] or `null`.
  double? unpackDoubleOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackDouble();
    }
  }

  double unpackDouble() {
    // 8 byte double + 1 control byte
    final value = _d.getFloat64(_offset, Endian.little);
    _offset += 8;
    return value;
  }

  /// unpack [double] or `null`.
  double? unpackFloatOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackFloat();
    }
  }

  double unpackFloat() {
    // 8 byte double + 1 control byte
    final value = _d.getFloat32(_offset, Endian.little);
    _offset += 4;
    return value;
  }

  /// unpack `List<int>` or null.
  List<int>? unpackBinaryOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackBinary();
    }
  }

  List<int> unpackBinary() {
    List<int> bytes = [];
    final length = unpackUint();
    for (var i = 0; i < length.toInt(); i++) {
      bytes.add(_d.getUint8(_offset + i));
    }
    _offset = _offset + length.toInt();
    return bytes;
  }

  List<int> unpackBinaryFixedLength(int length) {
    List<int> bytes = [];
    for (var i = 0; i < length; i++) {
      bytes.add(_d.getUint8(_offset + i));
    }
    _offset = _offset + length;
    return bytes;
  }

  List<int>? unpackBinaryFixedLengthOptional(int length) {
    if (unpackNull()) {
      return null;
    } else {
      return unpackBinaryFixedLength(length);
    }
  }

  String unpackString() {
    final bytes = unpackBinary();
    return _strCodec.decode(bytes);
  }

  String? unpackStringOptional() {
    if (unpackNull()) {
      return null;
    } else {
      return unpackString();
    }
  }

  void printBytes() {
    print(_list);
  }

  Int64 decoder_uint(List<int> bytes) {
    final rest = bytes.skipWhile((e) => most_siginifanct_bit_set(e)).toList();
    final value = bytes.takeWhile((e) => most_siginifanct_bit_set(e)).toList();
    value.add(rest.first);
    var acc = Int64.ZERO;
    for (var i = 0; i < value.length; i++) {
      acc = (Int64(value[i] & 0x7F) << (i * 7)) | acc;
      _offset += 1;
    }
    return acc;
  }

  int unpackLength() {
    return unpackUint().toInt();
  }

  Exception _formatException(String type, int b) => FormatException(
      'Try to unpack $type value, but it\'s not an $type, byte = $b');
}

bool most_siginifanct_bit_set(int value) => (value & 0x80) == 0x80;
