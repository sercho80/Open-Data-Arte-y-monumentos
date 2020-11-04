import 'package:arte_y_monumentos/providers/data_providers.dart';
import 'package:arte_y_monumentos/screens/listazonas_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ListaTiposScreen extends StatelessWidget {
  Map<String, Object> args = new Map<String, Object>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    box.write('tipo', null);
    args = Get.arguments ?? new Map<String, Object>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Tipos de Monumentos"),
      ),
      //drawer: MenuWidget(),
      body: _lista(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAll(ListaZonasScreen(), arguments: args);
        },
        child: Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _lista(BuildContext context) {
    return FutureBuilder(
      future:
          dataProvider.cargarLocalidades(box.read('localidad') ?? args['localidad']),
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            children: _listaElementos(context, snapshot.data),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  List<Widget> _listaElementos(BuildContext context, List<String> data) {
    final List<Widget> lst = [];
    data.forEach((element) {
      final w = ListTile(
        title: Text(element),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          box.write('tipo', element);
          args['tipo'] = element;
          //Get.offAll(ListaMonumentosFiltrados(), arguments: args);
        },
      );
      lst.add(w);
      lst.add(Divider());
    });
    return lst;
  }
}
