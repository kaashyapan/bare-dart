import 'package:bare/bare.dart';

class Rec1 {
  List<Rec2> lsrecs = [];
  Rec1(this.lsrecs);
  Packer pack(Packer p) {
    p.packLength(lsrecs.length);
    lsrecs.forEach((e) {
      e.pack(p);
    });
    return p;
  }

  @override
  String toString() {
    return ('lsrecs : ${lsrecs}');
  }

  static Rec1 unpack(Unpacker p) {
    final len = p.unpackLength();
    List<Rec2> lsrecs = [];
    for (var i = 0; i < len; i++) {
      lsrecs.add(Rec2.unpack(p));
    }
    return Rec1(lsrecs);
  }
}

class Rec2 {
  String? fld1, fld2;
  Rec2(this.fld1, this.fld2);
  Packer pack(Packer p) {
    p.packStringOptional(fld1);
    p.packStringOptional(fld2);
    return p;
  }

  static Rec2 unpack(Unpacker p) {
    final fld1 = p.unpackStringOptional();
    final fld2 = p.unpackStringOptional();
    return Rec2(fld1, fld2);
  }

  @override
  String toString() {
    return ('fld1 : ${fld1}, fld2 : ${fld2}');
  }
}
