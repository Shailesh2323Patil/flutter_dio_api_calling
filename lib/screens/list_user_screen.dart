import 'package:dio/dio.dart';
import 'package:dio_api_calling/model/list_user_response.dart';
import 'package:dio_api_calling/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../http_service.dart';

class ListUserScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListUserScreenState();
  }
}

class ListUserScreenState extends State<ListUserScreen> {
  HttpService? httpService;

  bool isLoading = false;

  ListUserResponse? listUserResponse;

  List<User>? users;

  Future getListUser() async {
    Response response;
    try {
      isLoading = true;
      response = await httpService!.getRequest("/api/users?page=2");
      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          listUserResponse = ListUserResponse.fromJson(response.data);
          users = listUserResponse?.users;
        });
      } else {
        print("There is some problem status code is not 200");
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    httpService = HttpService();
    getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Get List User"),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : users != null
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      final user = users![index];

                      return ListTile(
                        title: Text(user.firstName.toString()),
                        leading: Image.network(user.avatar.toString()),
                        subtitle: Text(user.email.toString()),
                      );
                    },
                    itemCount: users?.length)
                : Center(child: Text("No User Object")));
  }
}
