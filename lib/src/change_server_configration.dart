import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:program_beginning/widgets/input_field.dart';

// ignore: must_be_immutable
class ChangeServerConfigration extends StatefulWidget {
  int id;
  String password;
  Function onClickDone;
  Function onChangeConfigration;
  Color redColor;
  ChangeServerConfigration({super.key,required this.id,required this.password,required this.onClickDone,required this.onChangeConfigration,required this.redColor});

  @override
  State<ChangeServerConfigration> createState() => _ChangeServerConfigrationState();
}

class _ChangeServerConfigrationState extends State<ChangeServerConfigration> {
  late TextEditingController serverName;
  late TextEditingController userName;
  late TextEditingController password;
  FocusNode serverNameNode = FocusNode();
  FocusNode userNameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    serverName = TextEditingController(text:GetStorage().read("server_name")??"");
    userName = TextEditingController(text:GetStorage().read("user_name")??"");
    password = TextEditingController(text:GetStorage().read("password")??"");
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            decelerationRate: ScrollDecelerationRate.fast,
          ),
          child: WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 12,
                    left: 12,
                    right: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Form(
                    key: key,
                    child: Column(children: [
                      Text(
                        "Connection String",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        textDirection: TextDirection.ltr,
                        isRequired: true,
                        node: serverNameNode,
                        autoFocus: true,
                        keyboardType: TextInputType.text,
                        controller: serverName,
                        label: "Server Name",
                        onFieldSubmitted: (v) async {
                          if (v.trim() != "") {
                              userNameNode.requestFocus();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        textDirection: TextDirection.ltr,
                        isRequired: true,
                        node: userNameNode,
                        keyboardType: TextInputType.text,
                        controller: userName,
                        label: "User Name",
                        onFieldSubmitted: (v) async {
                          passwordNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        textDirection: TextDirection.ltr,
                        obscureText: true,
                        isRequired: true,
                        node: passwordNode,
                        keyboardType: TextInputType.text,
                        controller: password,
                        label: "Password",
                        onFieldSubmitted: (v) async {

                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  await widget.onChangeConfigration();
                                }
                              },
                              child: Text(
                                "موافق",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.white),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: widget.redColor),
                              child: Text(
                                "إلغاء",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(color: Colors.white),
                              )),
                        ],
                      )
                    ]),
                  ),
                ),
              ))),
    );
  }
}
