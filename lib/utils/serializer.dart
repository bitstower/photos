abstract class Serializer<T> {
  T fromJson(Map json);
  Map toJson(T src);
}
