// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:typed_data';
import 'package:fixnum/fixnum.dart';

class Packer {
  /// Provide the [_bufSize] size, that minimal enough to fit your most used data packets.
  /// Try to find balance, small buffer is good, and if most of your data will fit to it, performance will be good.
  /// If buffer not enough it will be increased automatically.
  Packer([this._bufSize = 64]) {
    _newBuf(_bufSize);
  }

  int _bufSize;

  late Uint8List _buf;
  late ByteData _dat;
  int _offset = 0;

  void _newBuf(int size) {
    _buf = Uint8List(size);
    _dat = ByteData.view(_buf.buffer, _buf.offsetInBytes);
    _offset = 0;
  }

  final _builder = BytesBuilder(copy: false);
  final _strCodec = const Utf8Codec();

  void _nextBuf() {
    _flushBuf();
    _bufSize = _bufSize *= 2;
    _newBuf(_bufSize);
  }

  /// Flush [_buf] to [_builder] when [_buf] if almost full
  /// or when packer completes his job and transforms to bytes
  void _flushBuf() {
    _builder.add(Uint8List.view(
      _buf.buffer,
      _buf.offsetInBytes,
      _offset,
    ));
  }

  /// Pack binary and string uses this internally.
  void _putBytes(List<int> bytes) {
    final length = bytes.length;
    if (_buf.length - _offset < length) _nextBuf();
    if (_offset == 0) {
      /// buf flushed to builder, next new buf created, so we can write directly to builder
      _builder.add(bytes);
    } else {
      /// buf has space for us
      _buf.setRange(_offset, _offset + length, bytes);
      _offset += length;
    }
  }

  /// Explicitly pack null value.
  /// Other packXXX implicitly handle null values.
  void packNull() {
    if (_buf.length - _offset < 1) _nextBuf();
    _dat.setUint8(_offset++, 0x00);
  }

  void packNonNull() {
    if (_buf.length - _offset < 1) _nextBuf();
    _dat.setUint8(_offset++, 0x01);
  }

  /// Pack [bool] or `null`.
  void packBoolOptional(bool? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packBool(v);
    }
  }

  void packBool(bool v) {
    if (_buf.length - _offset < 1) _nextBuf();
    _dat.setUint8(_offset++, v ? 0x01 : 0x00);
  }

  void packInt8Optional(int? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packInt8(v);
    }
  }

  void packInt8(int v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setInt8(_offset++, v);
  }

  void packUint8Optional(int? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packUint8(v);
    }
  }

  void packUint8(int v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setUint8(_offset++, v);
  }

  void packInt16Optional(int? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packInt16(v);
    }
  }

  void packInt16(int v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setInt16(_offset, v, Endian.little);
    _offset += 2;
  }

  void packUint16Optional(int? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packUint16(v);
    }
  }

  void packUint16(int v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setUint16(_offset, v, Endian.little);
    _offset += 2;
  }

  void packInt32Optional(int? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packInt32(v);
    }
  }

  void packInt32(int v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setInt32(_offset, v, Endian.little);
    _offset += 4;
  }

  void packUint32Optional(int? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packUint32(v);
    }
  }

  void packUint32(int v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setUint32(_offset, v, Endian.little);
    _offset += 4;
  }

  /// Pack [int] or `null`.
  void packInt64Optional(Int64? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packInt64(v);
    }
  }

  void packInt64(Int64 v) {
    // max 8 byte int + 1 control byte
    if (_buf.length - _offset < 9) _nextBuf();
    v.toUnsigned(64);
    _dat.setInt64(_offset, v.toInt(), Endian.little);
    _offset += 8;
  }

  void packIntOptional(Int64? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packInt(v);
    }
  }

  void packInt(Int64 v) {
    if (_buf.length - _offset < 9) _nextBuf();
    var value = (v << 1).toUnsigned(64);
    if (value < Int64.ZERO) {
      value = ~(value);
    }
    final bytes = split_value_into_7_bit_groups_least_significant_first(value);
    _putBytes(bytes.toList());
  }

  void packUintOptional(Int64? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packUint(v);
    }
  }

  void packUint(Int64 v) {
    if (_buf.length - _offset < 9) _nextBuf();
    final bytes = split_value_into_7_bit_groups_least_significant_first(v);
    _putBytes(bytes.toList());
  }

  void packUint64(Int64 v) {
    if (_buf.length - _offset < 9) _nextBuf();
    v.toUnsigned(64);
    _dat.setUint64(_offset, v.toInt(), Endian.little);
    _offset += 8;
  }

  void packUint64Optional(Int64? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packUint64(v);
    }
  }

  void packDoubleOptional(double? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packDouble(v);
    }
  }

  void packDouble(double v) {
    if (_buf.length - _offset < 9) _nextBuf();
    _dat.setFloat64(_offset, v, Endian.little);
    _offset += 8;
  }

  void packFloatOptional(double? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packFloat(v);
    }
  }

  void packFloat(double v) {
    if (_buf.length - _offset < 5) _nextBuf();
    _dat.setFloat32(_offset, v, Endian.little);
    _offset += 4;
  }

  void packString(String v) {
    if (_buf.length - _offset < 4) _nextBuf();
    final encoded = _strCodec.encode(v);
    final length = encoded.length;
    if (length <= 0xFFFFFFFF) {
      packUint(Int64(length));
      _putBytes(encoded);
    } else {
      throw ArgumentError('Max String length is 0xFFFFFFFF');
    }
  }

  void packStringOptional(String? v) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (v == null) {
      _dat.setUint8(_offset++, 0x00);
      return;
    } else {
      _dat.setUint8(_offset++, 0x01);
      packString(v);
    }
  }

  void packBinaryOptional(List<int>? buffer) {
    // max 4 byte binary header + 1 control byte
    if (_buf.length - _offset < 1) _nextBuf();
    if (buffer == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packBinary(buffer);
    }
  }

  void packBinary(List<int> buffer) {
    if (_buf.length - _offset < 5) _nextBuf();
    final length = buffer.length;
    packLength(length);
    _putBytes(buffer);
  }

  void packBinaryFixedLengthOptional(int length, List<int>? buffer) {
    if (_buf.length - _offset < 1) _nextBuf();
    if (buffer == null) {
      _dat.setUint8(_offset++, 0x00);
    } else {
      _dat.setUint8(_offset++, 0x01);
      packBinaryFixedLength(length, buffer);
    }
  }

  void packBinaryFixedLength(int length, List<int> buffer) {
    if (_buf.length - _offset < 5) _nextBuf();
    if (buffer.length == length) {
      _putBytes(buffer);
    } else {
      throw 'Tried to encode a binary of length ${buffer.length} into a fixed length binary of length ${length}';
    }
  }

  void packLength(int length) {
    packUint(Int64(length));
  }

  Uint8List takeBytes() {
    Uint8List bytes;
    if (_builder.isEmpty) {
      bytes = Uint8List.view(
        _buf.buffer,
        _buf.offsetInBytes,
        _offset,
      );
    } else {
      _flushBuf();
      bytes = _builder.takeBytes();
    }
    return bytes;
  }

  void printBytes() {
    Uint8List bytes;
    if (_builder.isEmpty) {
      bytes = Uint8List.view(
        _buf.buffer,
        _buf.offsetInBytes,
        _offset,
      );
    } else {
      bytes = _builder.toBytes();
    }
    print(bytes);
    return;
  }
}

Iterable<int> split_value_into_7_bit_groups_least_significant_first(
    Int64 value) {
  List<int> list = [];
  while (value > Int64(127)) {
    list = [((value.toInt() & 0xFF) | 0x80), ...list];
    value = value.shiftRightUnsigned(7);
  }

  final x = value & 0xFF;
  final y = [x.toInt(), ...list];

  return y.reversed;
}
