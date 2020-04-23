import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderEnhanced<T> extends StreamBuilderBase<T, AsyncSnapshot<T>> {
  /// Creates a new [StreamBuilder] that builds itself based on the latest
  /// snapshot of interaction with the specified [stream] and whose build
  /// strategy is given by [builder].
  ///
  /// The [initialData] is used to create the initial snapshot.
  ///
  /// The [builder] must not be null.
  const StreamBuilderEnhanced({
    Key key,
    this.initialData,
    Stream<T> stream,
    @required this.builder,
    this.sliver: false
  }) : assert(builder != null),
       super(key: key, stream: stream);

  /// The build strategy currently used by this builder.
  final Widget Function(T data) builder;

  /// The data that will be used to create the initial snapshot.
  ///
  /// Providing this value (presumably obtained synchronously somehow when the
  /// [Stream] was created) ensures that the first frame will show useful data.
  /// Otherwise, the first frame will be built with the value null, regardless
  /// of whether a value is available on the stream: since streams are
  /// asynchronous, no events from the stream can be obtained before the initial
  /// build.
  final T initialData;

  /// If true, returns a RenderSliver Widget
  final bool sliver;

  @override
  AsyncSnapshot<T> initial() => AsyncSnapshot<T>.withData(ConnectionState.none, initialData);

  @override
  AsyncSnapshot<T> afterConnected(AsyncSnapshot<T> current) => current.inState(ConnectionState.waiting);

  @override
  AsyncSnapshot<T> afterData(AsyncSnapshot<T> current, T data) {
    return AsyncSnapshot<T>.withData(ConnectionState.active, data);
  }

  @override
  AsyncSnapshot<T> afterError(AsyncSnapshot<T> current, Object error) {
    return AsyncSnapshot<T>.withError(ConnectionState.active, error);
  }

  @override
  AsyncSnapshot<T> afterDone(AsyncSnapshot<T> current) => current.inState(ConnectionState.done);

  @override
  AsyncSnapshot<T> afterDisconnected(AsyncSnapshot<T> current) => current.inState(ConnectionState.none);

  @override
  Widget build(BuildContext context, AsyncSnapshot<T> snapshot) {
    Widget toReturn;

    if (snapshot.hasData) {
      return builder(snapshot.data);
    } else if (snapshot.hasError) {
      toReturn = Center(
        child: Text(
          snapshot.error.toString(),
          style: TextStyle(color: Colors.white),
        )
      );
    } else {
      toReturn = Center(
        child: CircularProgressIndicator(
          valueColor:
            AlwaysStoppedAnimation<Color>(Color.fromRGBO(219, 0, 0, 1.0)),
        )
      );
    }

    return sliver ? SliverList(delegate: SliverChildListDelegate([ toReturn ]))
      : toReturn;
  }
}
