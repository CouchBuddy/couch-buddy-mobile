import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../models/download.dart';

class DownloadsBloc {
  final _downloadsFetcher = PublishSubject<List<Download>>();
  IO.Socket socket;
  List<Download> _downloads = [];

  DownloadsBloc() {
    socket = IO.io('http://192.168.1.2:3001/downloads', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('connected to socket-io server');
    });
  }

  Stream<List<Download>> get downloads => _downloadsFetcher.stream;

  fetchDownloads() async {
    socket.on('torrent:all', (torrents) {
      _downloads = List.from(torrents).map((torrent) => Download.fromJson(torrent)).toList();
      _downloadsFetcher.sink.add(_downloads);
    });

    socket.on('torrent:download', (torrent) {
      final int i = _downloads.indexWhere((t) => t.infoHash == torrent['infoHash']);

      if (i >= 0) {
        _downloads[i] = Download.fromJson(torrent);
      } else {
        _downloads.add(Download.fromJson(torrent));
      }

      _downloadsFetcher.sink.add(_downloads);
    });
  }

  dispose() {
    _downloadsFetcher.close();
    socket.off('torrent:all');
    socket.off('torrent:download');
  }
}