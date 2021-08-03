import 'package:dio/dio.dart';
import 'package:dio_api_calling/http_service.dart';
import 'package:dio_api_calling/model/single_user_response.dart';
import 'package:dio_api_calling/model/user.dart';
import 'package:flutter/material.dart';

class SingleUserScreen extends StatefulWidget {
  @override
  _SingleUserScreenState createState() {
    return _SingleUserScreenState();
  }
}

class _SingleUserScreenState extends State<SingleUserScreen> {

  HttpService? httpService;

  SingleUserResponse? singleUserResponse;
  User? user;

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;
      response = await httpService!.getRequest("/api/users/2");
      isLoading = false;

      if(response.statusCode == 200) {
        setState(() {
          singleUserResponse = SingleUserResponse.fromJson(response.data);
          user = singleUserResponse?.user;
        });
      }
      else {
        print("There is some problem status code is not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    httpService = HttpService();
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Get Single User"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : user != null ? Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(user!.avatar.toString()),
                Container(
                  height: 16,
                ),
                Text("Hello, ${user!.firstName} ${user!.lastName} ")
              ],
            )) : Center(child: Text("No User Object"))
    );
  }
}