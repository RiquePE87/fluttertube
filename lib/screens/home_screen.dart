import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:fluttertube/blocs/videos_bloc.dart';
import 'package:fluttertube/delegates/data_search.dart';
import 'package:fluttertube/widgets/video_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0,
        title: Image.asset('images/youtubeLogo.png', width: 100, height: 100,),
        actions: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text('0'),
          ),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async{
              String result = await showSearch(context: context, delegate: DataSearch());
              if (result != null){
                BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              }
            },
          )
        ],
      ),
      body: StreamBuilder(
        builder: (context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
                itemBuilder: (context,index){
                  return VideoTile(snapshot.data[index]);
                },
              itemCount: 10,
            );
          }else{
            return Container();
          }

        },
        stream: BlocProvider.getBloc<VideosBloc>().outVideos,
      ),
    );
  }
}
