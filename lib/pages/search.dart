import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:viscus/models/user.dart';
import 'package:viscus/pages/activity_feed.dart';
import 'package:viscus/pages/home_page.dart';
import 'package:viscus/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with
    AutomaticKeepAliveClientMixin<Search> {
  TextEditingController searchController = TextEditingController();
  Future<QuerySnapshot> searchResultsFuture;

  handleSearch(String query){
    Future<QuerySnapshot>users = usersRef.where
      ("displayName", isGreaterThanOrEqualTo: query).getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  clearSearch(){
    searchController.clear();
  }
  AppBar buildSearchField(){
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          hintText: "Search",
          filled: true,
          prefixIcon: Icon(Icons.account_box,
          size: 28.0,
          ),
          suffixIcon: IconButton(
              icon: Icon(Icons.clear),
              onPressed: clearSearch,
              ),
        ),
        onFieldSubmitted: handleSearch,
      ),
    );

  }
  Container builNoContent(){
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(color: Colors.white,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Icon(Icons.search,
            size: 400,),

            Text("Find Users", textAlign: TextAlign.center, style: TextStyle(
              fontFamily: 'Iceland',
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 70
            ),)


          ],
        ),
      ),
    );

  }

  buildSearchResults(){
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot){
        if(!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
         User user =  User.fromDocument(doc);
         UserResult searchResult = UserResult(user);
         searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return Scaffold(
      appBar: buildSearchField(),
      body: searchResultsFuture == null ? builNoContent() : buildSearchResults(),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;
  UserResult (this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.7),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () => showProfile(context,profileId: user.id),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(user.photoUrl),
              ),
              title: Text(user.displayName,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),),
              subtitle: Text(user.username, style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ),
          Divider(height: 2.0,
          color: Colors.white30,)
        ],
      ),
    );
  }
}
