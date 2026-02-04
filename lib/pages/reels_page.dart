import 'package:flutter/material.dart';
import 'package:instagram/class/reel_class.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';



class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {

  final PageController _pageController = PageController();
  final List<VideoPlayerController> controllers = [];

  int currentIndex = 0;

  final List<ReelClass> reels_videos = [
    ReelClass(
        text: "Ronalduni 2018-yildagi akrobatik goli",
        likes_count: 1000000,
        comments_count: 20000,
        username: "@example1",
        profile_photo: "assets/cr7.jpg",
        video: "assets/ronaldo.mp4"
    ),
    ReelClass(
        text: "Messini legendarniy dribling goli",
        likes_count: 2000,
        comments_count: 1000,
        username: "@example2",
        profile_photo: "assets/messi.jpg",
        video: "assets/messi.mp4"
    ),
    ReelClass(
        text: "Neymarning 2022 JCHdagi goli",
        likes_count: 15000,
        comments_count: 1500,
        username: "@example3",
        profile_photo: "assets/neymar.jpg",
        video: "assets/neymar.mp4"
    ),
    ReelClass(
        text: "Mbappenin 2025-yildagi top 5 goli",
        likes_count: 14000,
        comments_count: 3000,
        username: "@example4",
        profile_photo: "assets/bape.jpg",
        video: "assets/bape.mp4"
    ),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(var r in reels_videos){
      final controller = VideoPlayerController.asset(r.video)
          ..initialize().then((_){
            setState(() {
            });
          })
          ..setLooping(true);
          controllers.add(controller);
    }
    controllers.first.play();
  }


  @override
  void dispose() {

    for(var c in controllers){
      c.dispose();
    }
    _pageController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  void change(int index){
    controllers[currentIndex].pause();
    controllers[index].play();
    currentIndex = index;
  }

  void toggle(){
    final video = controllers[currentIndex];

    if(video.value.isPlaying){
      setState(() {
        video.pause();
      });
    } else{
      setState(() {
        video.play();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          "Reels",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25
          ),
        ),
        centerTitle: true,
      ),

      body: PageView.builder(
        onPageChanged: change,
        controller: _pageController,
        itemCount: reels_videos.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index){
          return Stack(
            children: [
              Center(
                child: GestureDetector(
                  onTap: toggle,
                  child: AspectRatio(
                    aspectRatio: controllers[index].value.aspectRatio,
                    child: VideoPlayer(controllers[index]),
                  ),
                ),
              ),

              Positioned(
                left: 16,
                right: 100,
                bottom: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // photo + username
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            "${reels_videos[index].profile_photo}"
                          ),
                          radius: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "${reels_videos[index].username}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),

                        SizedBox(width: 10),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue
                          ),
                          onPressed: (){
                            //
                          },
                          child: Text(
                            "Follow",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white
                            ),
                          )
                        ),
                      ],
                    ),

                    SizedBox(height: 10),

                    Text(
                      "${reels_videos[index].text}",
                      style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
                      maxLines: 1,
                    )
                  ],
                )
              ),

              Positioned(
                right: 7,
                bottom: 80,
                child: Column(
                  children: [
                    // like
                    Icon(
                      Icons.favorite,
                      size: 34,
                      color: Colors.white,
                    ),
                    Text(
                      "${NumberFormat.compact().format(reels_videos[index].likes_count)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                      ),
                    ),

                    SizedBox(height: 20),

                    // dislike
                    Icon(
                      Icons.thumb_down,
                      size: 28,
                      color: Colors.white,
                    ),

                    SizedBox(height: 7),

                    Text(
                      "Dislike",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),

                    SizedBox(height: 23),


                    // comment
                    Icon(
                      Icons.add_comment,
                      size: 28,
                      color: Colors.white,
                    ),
                    Text(
                      "${NumberFormat.compact().format(reels_videos[index].comments_count)}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),

                    SizedBox(height: 25),

                    // share
                    Icon(
                      Icons.share,
                      size: 28,
                      color: Colors.white,
                    ),

                    SizedBox(height: 7),

                    Text(
                      "Share",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                      ),
                    ),
                  ],
                )
              )
            ],
          );
        }
      ),

    );
  }
}
