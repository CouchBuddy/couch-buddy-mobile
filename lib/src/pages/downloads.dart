import 'package:flutter/material.dart';

import '../blocs/downloads_bloc.dart';
import '../utils/format.dart';
import '../models/download.dart';
import '../utils/localization.dart';
import '../widgets/stream_builder_enhanced.dart';

class Downloads extends StatefulWidget {
  Downloads({ Key key }) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  DownloadsBloc bloc;

  String _(String key, [int howMany = 1]) => AppLocalizations.of(context).translate(key, howMany);

  @override
  void initState() {
    bloc = DownloadsBloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchDownloads();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(_('download', 2)),
      ),
      body:
        StreamBuilderEnhanced(
          initialData: List<Download>(),
          stream: bloc.downloads,
          builder: (List<Download> downloads) => ListView.builder(
            padding: EdgeInsets.all(8.0),
            itemCount: downloads.length,
            itemBuilder: (BuildContext context, int i) {
              return _buildDownloadCard(downloads[i]);
            },
          )
        )
    );
  }

  Widget _buildDownloadCard(Download download) {
    String title = download.info != null ? download.info.title : download.name;

    title += download.info != null ? ' S${download.info.season}' : '';
    title += download.info != null ? ' E${download.info.episode}' : '';

    return Card(
      color: Colors.black,
      elevation: 8,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              opacity: 0.45,
              child: LinearProgressIndicator(
                value: download.progress,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Text(title),
                subtitle: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${formatBytes(download.downloaded)} / ${formatBytes(download.length)}'),
                        Text('D ${formatBytes(download.downloadSpeed)}/s - U ${formatBytes(download.uploadSpeed)}/s'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Remaining: ${download.timeRemaining != null ? formatTime(download.timeRemaining) : 'Unknown'}'),
                        Text('Peers: ${download.numPeers}'),
                      ],
                    )
                  ],
                )
              ),
            ],
          ),
        ],
      )
    );
  }
}
