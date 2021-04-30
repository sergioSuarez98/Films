import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/models/pelicula_model.dart';
import 'package:peliculas/src/pages/providers/peliculas_providers.dart';

class DataDelegate extends SearchDelegate{
  final peliculas = [
    'Spiderman',
    'Avengers',
    'En busca de la felicidad',
    'Iron man',
    'Iron man2',
    'Iron man3',
    'Iron man4',


  ];
  final peliculasRecientes = [
    'Spiderman',
    'Capitan America'
  ];
  String seleccion = '';
  final peliculasProvider = new PeliculasProvider();
  @override
  List<Widget> buildActions(BuildContext context) {
    //acciones del appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            //query es una variable dentro de search delegate que guarda lo que se escribe
            query = "";
          }
      )
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del AppBar

    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),

        onPressed:(){
          //viene integrado en search delegete

          close(context, null);

        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar

    return Center(
      child: Container(
        height: 100,
        width: 100,
        color:Colors.blueAccent ,
        child: Text(seleccion),
      ),
    );
    return  Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //Sugerencias que aparecen cuando la personas escribe

    if (query.isEmpty){
      return Container();
    }
    return FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot){
          if (snapshot.hasData) {
            final peliculas = snapshot.data;
            return ListView(

              children: peliculas.map((pelicula) {
                return ListTile(
                  leading:  FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    width: 50.0,
                    fit: BoxFit.contain,

                  ),
                  title: Text(pelicula.title),
                  subtitle: Text(pelicula.originalTitle),
                  onTap: (){
                    //cierra la busqueda
                    close(context, null);
                    pelicula.uniqueId = null;
                    Navigator.pushNamed(context, 'detalle', arguments:  pelicula);

                  },
                );
              }).toList(),
            );
          } else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
      },
    );
  }

  // final listaSugerida = (query.isEmpty) ? peliculasRecientes
  //     : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())
  // ).toList();
  //
  //
  // return ListView.builder(
  // itemCount: listaSugerida.length,
  // itemBuilder: (context,i){
  //
  // return ListTile(
  // leading: Icon(Icons.movie),
  // title: Text(listaSugerida[i]),
  // onTap: (){
  // seleccion = listaSugerida[i];
  // //viene implementado ya
  // showResults(context);
  // },
  // );
  //
  // }
  //
  // );

}