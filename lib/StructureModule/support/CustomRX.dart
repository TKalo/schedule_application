import 'dart:async';

import 'package:rxdart/rxdart.dart';

class RxValue <T> {
  
  RxValue({T startWith}) :_data = startWith != null ? BehaviorSubject<T>().startWith(startWith) : BehaviorSubject<T>();
  final BehaviorSubject<T> _data;
  Stream<T> get getData => _data.stream;
  void setData(T data) => _data.add(data);
  void get getRX => _data;
}

class RxList <T> {
  final BehaviorSubject<List<T>> _data;
  RxList({List<T> startWith}) :_data = startWith != null ? BehaviorSubject<List<T>>().startWith(startWith) : BehaviorSubject<List<T>>().startWith([]);
  Stream<List<T>> get getData => _data.stream;
  void setData(List<T> data) => _data.add(data);
  void addData(T data) async => _data.add((await _data.first)..add(data));
  void removeData(T data) async => _data.add((await _data.first)..remove(_data));
  void get getRX => _data;
}

class RxMap <K,V> {
  final BehaviorSubject<Map<K,V>> _data ;
  RxMap({Map<K,V> startWith}) :_data =  startWith != null ? BehaviorSubject<Map<K,V>>().startWith(startWith) : BehaviorSubject<Map<K,V>>().startWith({});
  Stream<Map<K,V>> get getData => _data.stream;
  void setData(Map<K,V> data) => _data.add(data);
  void addData(K key,V value) async => _data.add((await _data.first)..update(key, (old) => value, ifAbsent: () => value));
  void removeData(K key) async => _data.add((await _data.first)..remove(key));
  void get getRX => _data;
}