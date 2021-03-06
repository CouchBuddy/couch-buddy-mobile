import 'dart:async';
import 'dart:io';
import 'package:multicast_dns/multicast_dns.dart';

class Discovery {
  static Future<Uri> start() async {
    const String name = '_couchbuddy._tcp.local';
    final factory = (dynamic host, int port, {bool reuseAddress, bool reusePort, int ttl}) {
      return RawDatagramSocket.bind(host, port, reuseAddress: true, reusePort: false, ttl: ttl);
    };

    final MDnsClient client = MDnsClient(rawDatagramSocketFactory: factory);
    // Start the client with default options.
    await client.start();

    // Get the PTR record for the service.
    await for (PtrResourceRecord ptr in client
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      // Use the domainName from the PTR record to get the SRV record,
      // which will have the port and local hostname.
      // Note that duplicate messages may come through, especially if any
      // other mDNS queries are running elsewhere on the machine.
      await for (SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
          ResourceRecordQuery.service(ptr.domainName))) {

        // Search IP address
        await for (IPAddressResourceRecord ip in client
            .lookup<IPAddressResourceRecord>(ResourceRecordQuery.addressIPv4(srv.target))) {
          print('Service instance found at ${srv.target}:${srv.port} with ${ip.address}.');
          client.stop();
          return Uri(host: ip.address.address, port: srv.port, scheme: 'http');
        }
      }
    }

    print('Service not found');
    client.stop();
    return null;
  }
}
