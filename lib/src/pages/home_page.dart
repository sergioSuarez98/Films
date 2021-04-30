import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/providers/peliculas_providers.dart';
import 'package:peliculas/src/pages/search/search_delegate.dart';
import 'package:peliculas/src/pages/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/pages/widgets/movie_horizontal.dart';




class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculasProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: DataDelegate());
              }
              )
        ],
      ),
      body: Container(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      )
    );
  }

 Widget _swiperTarjetas() {

   return FutureBuilder(
     future: peliculasProvider.getEnCines(),
     builder: (BuildContext context, AsyncSnapshot<List> snapshot){
       if (snapshot.hasData){
   return CardSwiper(
   peliculas: snapshot.data
   );
   }else{
         return Container(child: Center(child: CircularProgressIndicator()));
   }
     },

   );
 }

 Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1,),

          ),
          SizedBox(height: 10.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,

            builder: (BuildContext context, AsyncSnapshot<List> snapshot){
              if(snapshot.hasData){
                return MovieHorizontal(peliculas: snapshot.data, siguientePag: peliculasProvider.getPopular);
              }else{
                return CircularProgressIndicator();
              }

              return Container();
            } ,
          ),


        ],
      ),
    );

 }
}
