import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePag;
  MovieHorizontal({@required this.peliculas, @required this.siguientePag});
  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3,
  );



  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent-200){

        siguientePag();
      }
    });

    return Container(
      height: _screeSize.height*0.2,
      child: PageView.builder(
          pageSnapping: false,
          controller: _pageController,
        //children:_tarjetas(context),
        itemCount: peliculas.length,
        itemBuilder: (context,i){

              return _tarjeta(context, peliculas[i]);

        },
      ),
    );
  }
 Widget _tarjeta(BuildContext context, Pelicula pelicula){
   pelicula.uniqueId='${pelicula.id}-poster';
    final tarjeta = Container(
       margin: EdgeInsets.only(right: 15.0),
       child: Column(
         children:[
           Hero(
             tag: pelicula.uniqueId,
             child: ClipRRect(borderRadius: BorderRadius.circular(20.0),
                 child: FadeInImage(
                   placeholder: AssetImage('assets/img/no-image-jpg'),
                   image: NetworkImage(pelicula.getPosterImg()),
                   fit: BoxFit.cover,
                   height: 140.0,

                 )

             ),
           ),
           SizedBox(height:5.0),
           Text(
             pelicula.title,
             overflow: TextOverflow.ellipsis,
             style: Theme.of(context).textTheme.caption,
           ),

         ],
       ),
     );
    return GestureDetector(
      child: tarjeta,
      onTap: (){
        Navigator.pushNamed(context, 'detalle',arguments: pelicula);
      },
    );

 }
 List<Widget> _tarjetas(BuildContext context) {

    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children:[
            ClipRRect(borderRadius: BorderRadius.circular(20.0),
             child: FadeInImage(
                    placeholder: AssetImage('assets/img/no-image-jpg'),
                    image: NetworkImage(pelicula.getPosterImg()),
                    fit: BoxFit.cover,
                    height: 140.0,
             )

            ),
            SizedBox(height:5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),

          ],
        ),
      );

    }).toList();

 }
}
