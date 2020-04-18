import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './contentProvider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => ContentProvider(),
      )
    ],
    child: new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Indonesia Corona Update',
      home: new Home(),
    ),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: [
          SizedBox(height: 50),
          Container(
            width: double.infinity,
            height: 200,
            child: Image.asset('img/corona.png'),
          ),
          Text(
            "Indonesia melawan Corona",
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'DancingScript',
                fontWeight: FontWeight.bold),
          ),
          RefreshIndicator(
            onRefresh: () =>
                Provider.of<ContentProvider>(context, listen: false).getData(),
            child: FutureBuilder(
                future: Provider.of<ContentProvider>(context, listen: false)
                    .getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Consumer<ContentProvider>(builder: (context, data, _) {
                    return Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 20, bottom: 5),
                          child: Card(
                            elevation: 2,
                            color: Colors.yellow,
                            child: ListTile(
                              title: Text("Konfirmasi "),
                              leading:
                                  Icon(Icons.info_outline, color: Colors.white),
                              trailing: Text(
                                  data.dataModel.konfirmasi.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Card(
                            elevation: 2,
                            color: Colors.green,
                            child: ListTile(
                              title: Text("Sembuh "),
                              leading:
                                  Icon(Icons.thumb_up, color: Colors.white),
                              trailing: Text(data.dataModel.sembuh.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Card(
                            elevation: 2,
                            color: Colors.red,
                            child: ListTile(
                              title: Text("Meninggal "),
                              leading: Icon(Icons.error, color: Colors.white),
                              trailing: Text(
                                  data.dataModel.meninggal.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: Card(
                            elevation: 2,
                            color: Colors.blue,
                            child: ListTile(
                              title: Text("Perawatan "),
                              leading: Icon(Icons.settings_backup_restore,
                                  color: Colors.white),
                              trailing: Text(
                                  data.dataModel.perawatan.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Tgl. update: ${data.dataModel.waktuUpadte.toString()}",
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    );
                  });
                }),
          ),
        ]));
  }
}
