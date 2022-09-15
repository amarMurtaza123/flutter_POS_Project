import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_system/auth_controller.dart';
import 'package:pos_system/signup_page.dart';

class WellcomePage extends StatefulWidget {
  String email;
  WellcomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<WellcomePage> createState() => _WellcomePageState();
}

class _WellcomePageState extends State<WellcomePage> {

  // List of document ids
  List<String> docIDs = [];

  // get Document IDs
  Future getDocID() async {
    await FirebaseFirestore.instance.collection('customers').get().then(
            (snapshot) => snapshot.docs.forEach((document) {
              print(document.reference);
              docIDs.add(document.reference.id);
            }),
    );
  }

  @override
  void initState() {
    getDocID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            Container(
              width: width,
              height: height * 0.35,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'img/signin_btn.jpg',

                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: height*0.14,),
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white70,
                    backgroundImage: AssetImage(
                        'img/profile.jpg'
                    ),
                  ),
                ],
              ),



            ),
            SizedBox(height: 30,),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wellcome',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    widget.email,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
                child: Container(
                  height: height,
                  child: FutureBuilder(
                      future: getDocID(),
                      builder: (context, snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: docIDs.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(docIDs[index]),
                              );
                            },
                          );
                        }else{
                          return CircularProgressIndicator();
                        }
                      }),
                ),
              ),

            SizedBox(height: 10),
            GestureDetector(
              onTap: (){
                AuthController.instance.logout();
              },
              child: Container(
                width: width*0.5,
                height: height*0.08,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                    image: AssetImage(
                      'img/signin_btn.jpg',

                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  
                ),
                              



              ),
            ),

           
           // SizedBox(height: width*0.08,),
            // RichText(text: TextSpan(
            //   text: 'Sign Up using one the following methode',
            //   style: TextStyle(
            //     color:Colors.grey[500],
            //     fontSize: 16,
            //   ),
            //
            // )),


          ],
        ),
      ),
    );
  }
}
