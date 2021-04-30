import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/pages/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 40.0),

      child: Swiper(
        layout: SwiperLayout.STACK,
        itemCount: peliculas.length,
        itemWidth: _screeSize.width * 0.7,
        itemHeight: _screeSize.height * 0.5,
        itemBuilder: (BuildContext context,int index){

          peliculas[index].uniqueId='${peliculas[index].id}-tarjetas';

          return Hero(
            tag: peliculas[index].id,
            child: ClipRRect(

              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: ()=>Navigator.pushNamed(context, 'detalle',arguments: peliculas[index]),
                child: FadeInImage(
                  image: NetworkImage(peliculas[index].getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),

            ),
          );


        },
      ),
    );
  }
}
