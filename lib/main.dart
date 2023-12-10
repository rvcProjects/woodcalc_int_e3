import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:woodcalc_int_e3/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      home: const WoodCalc()));
}

class WoodCalc extends StatefulWidget {
  const WoodCalc({super.key});

  @override
  State<WoodCalc> createState() => _WoodCalcState();
}

class _WoodCalcState extends State<WoodCalc> {
  late String nombreProd, idProd, longitudProd;
  late double precioProd;

  getNombreProd(nombre) {
    nombreProd = nombre;
  }

  getIdProd(id) {
    idProd = id;
  }

  getLongitudProd(longitud) {
    longitudProd = longitud;
  }

  getPrecioProd(precio) {
    precioProd = double.parse(precio);
  }

  createData() {
    print("Creando registro");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Productos").doc(nombreProd);

    Map<String, dynamic> productos = {
      "nombreProd": nombreProd,
      "idProd": idProd,
      "longitudProd": longitudProd,
      "precioProd": precioProd
    };

    documentReference.set(productos).whenComplete(() {
      print("$nombreProd creado");
    });
  }

  readData() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Productos").doc(nombreProd);

    documentReference.get().then((datasnapshot) {
      print("Nombre: ${datasnapshot.get("nombreProd").toString()}");
      print("ID: ${datasnapshot.get("idProd").toString()}");
      print("Longitud: ${datasnapshot.get("longitudProd").toString()}");
      print("Precio: ${datasnapshot.get("precioProd").toString()}");
    });
  }

  updateData() {
    print("Actualizando registro...");

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Productos").doc(nombreProd);

    Map<String, dynamic> productos = {
      "nombreProd": nombreProd,
      "idProd": idProd,
      "longitudProd": longitudProd,
      "precioProd": precioProd
    };

    documentReference.update(productos).whenComplete(() {
      print("$nombreProd actualizado");
    });
  }

  deleteData() {
    print("Borrando registro...");
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Productos").doc(nombreProd);
    documentReference.delete().whenComplete(() {
      print("$nombreProd borrado.");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("WoodCalc"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Nombre del Producto",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0))),
                onChanged: (String nombreProd) {
                  getNombreProd(nombreProd);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "ID del Producto",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0))),
                onChanged: (String idProd) {
                  getIdProd(idProd);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Longitud (In)",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0))),
                onChanged: (String longitudProd) {
                  getLongitudProd(longitudProd);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Precio",
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey, width: 2.0))),
                onChanged: (String precioProd) {
                  getPrecioProd(precioProd);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      createData();
                    },
                    child: const Text("Crear"),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      readData();
                    },
                    child: const Text("Leer"),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      updateData();
                    },
                    child: const Text("Actualizar"),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () {
                      deleteData();
                    },
                    child: const Text("Borrar"),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                textDirection: TextDirection.ltr,
                children: <Widget>[
                  Expanded(child: Text("Nombre")),
                  Expanded(child: Text("ID")),
                  Expanded(child: Text("Longitud")),
                  Expanded(child: Text("Precio")),
                ],
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Productos")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot documentSnapshot = snapshot
                              .data?.docs[index] as DocumentSnapshot<Object?>;
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Text(documentSnapshot["nombreProd"]),
                                ),
                                Expanded(
                                  child: Text(documentSnapshot["idProd"]),
                                ),
                                Expanded(
                                  child: Text(documentSnapshot["longitudProd"]),
                                ),
                                Expanded(
                                  child: Text(documentSnapshot["precioProd"]
                                      .toString()),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return const Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: CircularProgressIndicator());
                  }
                }),
          ]),
        ));
  }
}
