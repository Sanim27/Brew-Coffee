import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  //collection reference . . .
  //final FirebaseFirestore brewCollection = FirebaseFirestore.instance;
  final CollectionReference brewCollection=FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars,String name,int strength) async{
    return await brewCollection.doc(uid).set(
        {'sugars': sugars,
          'name': name,
          'strength': strength,}
    );
  }

  //brew list from a snapshot
  List <Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Brew(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '0',
          strength: doc.get('strength') ?? 100
      );
    }).toList();
  }

  //userData from snapshots...
  // UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
  //   return UserData(
  //     uid:uid,
  //     name: snapshot.data['name']??'',
  //     sugars: snapshot.data['sugars']??'',
  //     strength: snapshot.data['strength']??''
  //   );
  // }
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>?; // Ensure data is cast to the correct type
    if (data == null) {
      throw Exception("Snapshot data is null");
    }

    return UserData(
        uid: snapshot.id,
        name: data['name'] ?? '',
        sugars: data['sugars'] ?? '',
        strength: data['strength'] ?? 0
    );
  }



  //get brews stream
  Stream <List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}