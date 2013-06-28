package me.beltramo.bbq;

import haxe.Json;

class JsonType {

	public static function create<T>( json : String ) : T {
		return JsonType.decode( json );
	}

  public static function encode(o : Dynamic) {
    return Json.stringify({
      type : Type.getClassName(Type.getClass(o)),
      data : o
    });
  }

  public static function decode<T>(s : String) : T {
    var o : Dynamic = Json.parse(s);
    var inst = Type.createEmptyInstance(Type.resolveClass(o.type));
    populate(inst, o.data);
    return inst;
  }

  static function populate(inst, data) {
    for(field in Reflect.fields(data)) {
      Reflect.setField(inst, field, Reflect.field(data, field));
    }
  }
}
