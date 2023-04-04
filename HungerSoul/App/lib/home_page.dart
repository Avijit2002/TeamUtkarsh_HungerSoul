import 'package:flutter/material.dart';
import 'package:food_donation_app/DonationList.dart';
import 'donation_form.dart';
import 'TrackingPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/api.dart';
import 'VolunteerForn.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String id = 'home-page';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var loggedinUser;
  getcurrentuser()async{
    try{
      final user = await FirebaseAuth.instance.currentUser!.email;
      loggedinUser = user;
    }
    catch(e){
      print(e);
    }
  }

  dynamic post;
  getpost() async{
      //post = await Api.GetPost();
  }
  @override
  void initState() {
    super.initState();
    getcurrentuser();
    getpost();
    print(post);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            //backgroundColor: Color(0xFF7CFC00),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.dashboard)),
                Tab(icon: Icon(Icons.feed_rounded)),
                Tab(icon: Icon(Icons.leaderboard)),
              ],
            ),
            title: Text('Donor Dashboard',

                style: TextStyle(
                  //fontFamily: 'Montserrat',
                  //fontWeight: FontWeight.w900,
            ),
            ),
          ),
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Text(
                      'Welcome, Avijit!',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          "Join the Zero Hunger Revolution! Donate food to make a difference in someone's life today.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        title: Text(
                          'Make a Donation Request',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Request for food donation pickup from your home',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pushNamed(context, DonationForm.id);
                        },
                      ),
                    ),
                    Card(
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        title: Text(
                          'Track your Donations',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Track your current donation.',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => FoodDonationTrackingPage(),
                            settings: RouteSettings(arguments: {'step':'0'}),
                          ),);
                        },
                      ),
                    ),
                    Card(
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        title: Text(
                          'Donation History',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'See your past donations.',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) => DonationsList(),
                            settings: RouteSettings(arguments: {'step':'0'}),
                          ),);
                        },
                      ),
                    ),
                    Card(
                      margin:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ListTile(
                        title: Text(
                          'Join as Volenteer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Join the revolution by filling this form',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.pushNamed(context, VolunteerForm.id);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //2nd tab
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: const Text('Feed Section',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),),
                  ),
                  Expanded(
                    child: FutureBuilder(
                        future: Api.GetPost(),
                        builder: (context,snapshot){
                          print(snapshot.data);
                      if(snapshot.hasData){
                        dynamic p = snapshot.data;
                        post = new List.from(p.reversed);
                        return ListView.builder(
                          itemCount: post.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(
                                        post[index]['title'],
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Text(post[index]['content'],
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(posts[index].date),
                                          Text(post[index]['author']),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      else{
                        return Text('No Post');
                      }
                    }),
                  ),
                ],
              ),

              //3rd tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: const Text('Community Section',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),),
                ),
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text('Top Donors',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                        child: Text(users[index].name[0]),
                        ),
                      title: Text(users[index].name),
                      trailing: Text('${users[index].points} pts'),
          );
        },
      ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text('Badges',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),),
                ),
                Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: badges.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Image.network(
                                  badges[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      badges[index].name,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.0),
                                    Text(badges[index].description),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  final String title;
  final String content;
  final String date;
  final String author;

  Post({
    required this.title,
    required this.content,
    required this.date,
    required this.author,
  });
}

List<Post> posts = [
  Post(
    title: 'How You Can Help Fight Hunger in Your Community',
    content:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tempus justo vitae felis convallis, eu feugiat arcu sagittis. Vestibulum convallis nulla lorem, id efficitur nulla eleifend quis. Sed luctus felis at massa rhoncus laoreet. Donec at arcu a leo commodo rhoncus. Nulla facilisi.',
    date: 'March 14, 2023',
    author: 'John Doe',
  ),
  Post(
    title: 'How You Can Help Fight Hunger in Your Community',
    content:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tempus justo vitae felis convallis, eu feugiat arcu sagittis. Vestibulum convallis nulla lorem, id efficitur nulla eleifend quis. Sed luctus felis at massa rhoncus laoreet. Donec at arcu a leo commodo rhoncus. Nulla facilisi.',
    date: 'March 13, 2023',
    author: 'John Doe',
  ),
  Post(
    title: 'How You Can Help Fight Hunger in Your Community',
    content:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tempus justo vitae felis convallis, eu feugiat arcu sagittis. Vestibulum convallis nulla lorem, id efficitur nulla eleifend quis. Sed luctus felis at massa rhoncus laoreet. Donec at arcu a leo commodo rhoncus. Nulla facilisi.',
    date: 'March 12, 2023',
    author: 'John Doe',
  ),
  Post(
    title: 'How You Can Help Fight Hunger in Your Community',
    content:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tempus justo vitae felis convallis, eu feugiat arcu sagittis. Vestibulum convallis nulla lorem, id efficitur nulla eleifend quis. Sed luctus felis at massa rhoncus laoreet. Donec at arcu a leo commodo rhoncus. Nulla facilisi.',
    date: 'March 12, 2023',
    author: 'John Doe',
  ),
  Post(
    title: 'Food Donations Needed for Local Shelter',
    content:
    'Sed non elit non elit non elit non elit non elit non elit non elit. Sed non elit non elit non elit non elit non elit non elit non elit. Sed non elit non elit non elit non elit non elit non elit non elit. Sed non elit non elit non elit non elit non elit non elit non elit.',
    date: 'March 9, 2023',
    author: 'Jane Smith',
  ),
  Post(
    title: 'Volunteer Opportunities at Local Food Bank',
    content:
    'Vestibulum blandit eros id sapien pulvinar vestibulum. Sed maximus, libero vitae pellentesque finibus, risus magna iaculis sapien, eu fringilla nisi quam eget enim. Maecenas condimentum ipsum vel lacus sagittis, ut tristique nisi sagittis. Nullam euismod ex nunc, eget lobortis mi rhoncus eu. Morbi ac odio vel ex pharetra ultrices. ',
    date: 'March 8, 2023',
    author: 'Tom Johnson',
  ),
];




class Badge {
  final String name;
  final String description;
  final String imageUrl;

  Badge({
    required this.name,
    required this.description,
    required this.imageUrl,
  });
}

List<Badge> badges = [
  Badge(
    name: 'Food Donor',
    description: 'Donated 10 or more times',
    imageUrl: 'https://png.pngtree.com/png-vector/20210823/ourmid/pngtree-bronze-blank-medal-award-with-ribbon-vector-png-image_3826543.jpg',
  ),
  Badge(
    name: 'Super Donor',
    description: 'Donated 50 or more times',
    imageUrl: 'https://images.cdn2.stockunlimited.net/preview1300/blue-and-silver-badge-design_1959372.jpg',
  ),
  Badge(
    name: 'Hunger Hero',
    description: 'Donated 100 or more times',
    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTM3NvD7coe3QRjaSVNfjuojLApo6d1uw_Br4gqrcYUNcGdDRe2KrE6b5Zk3cTjbysQBcA&usqp=CAU',
  ),
];



class User {
  final String name;
  final int points;

  User({
    required this.name,
    required this.points,
  });
}

List<User> users = [
  User(name: 'Atulya Narayan', points: 1000),
  User(name: 'Shivam Kumar', points: 500),
  User(name: 'Shivani Jha', points: 250),
  User(name: 'Vinit Thakur', points: 100),
];

