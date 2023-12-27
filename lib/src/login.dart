import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ionicons/ionicons.dart';
import 'package:program_beginning/src/change_server_configration.dart';
import 'package:program_beginning/widgets/input_field.dart';


// ignore: must_be_immutable
class LoginDialog extends StatefulWidget {
  int systemType;
  Function onEnterId;
  Function onClickDone;
  Function onClickCancel;
  Color redColor;
  Function? onChangeConfigration;
  LoginDialog({
    required this.onClickCancel,
    required this.systemType,
    required this.onClickDone,
    required this.onEnterId,
    required this.redColor,
    this.onChangeConfigration,
    super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  FocusNode idNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  GlobalKey<FormState> key = GlobalKey<FormState>();
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.onChangeConfigration == null ?
                          IconButton(
                              onPressed: () {
                                if(key.currentState!.validate()){
                                showDialog(context: context, builder: (context)=> ChangeServerConfigration(id: int.parse(id.text),password: password.text,onClickDone: widget.onClickDone,onChangeConfigration: widget.onChangeConfigration!,redColor: widget.redColor,));
                              }
                              }, icon: const Icon(Icons.settings)):const SizedBox(width: 5,),
                          Text(
                            "تسجيل الدخول",
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          (widget.systemType == 1)?
                          IconButton(
                              onPressed: () {
                                if (GetStorage().read("darkMode")) {
                                  setState(() {
                                    Get.changeThemeMode(ThemeMode.light);
                                    GetStorage().write("darkMode", false);
                                  });
                                } else {
                                  setState(() {
                                    Get.changeThemeMode(ThemeMode.dark);
                                    GetStorage().write("darkMode", true);
                                  });
                                }
                              },
                              icon: Icon(
                                GetStorage().read("darkMode")
                                    ? Ionicons.moon
                                    : Ionicons.sunny,
                              )):const SizedBox(width: 10,),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputField(
                        isRequired: true,
                        node: idNode,
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        controller: id,
                        label: "رقم الموظف",
                        onFieldSubmitted: (v) async {
                          if (v.trim() != "") {
                            await widget.onEnterId();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        isRequired: false,
                        readOnly: true,
                        node: nameNode,
                        keyboardType: TextInputType.text,
                        controller: name,
                        label: "أسم الموظف",
                        onFieldSubmitted: (v) async {
                          passwordNode.requestFocus();
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      InputField(
                        obscureText: true,
                        isRequired: true,
                        node: passwordNode,
                        keyboardType: TextInputType.text,
                        controller: password,
                        label: "كلمة المرور",
                        onFieldSubmitted: (v) async {
                          if(key.currentState!.validate()){
                            await widget.onClickDone(id.text,password.text);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              // onLongPress: () async {
                              //   // await db.backup();
                              //   await db.flushhost();
                              // },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor),
                              onPressed: () async {
                                if(key.currentState!.validate()){
                                  await widget.onClickDone(id.text,password.text);
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
                                widget.onClickCancel();
                              },
                              // onLongPress: () async {
                              //   if (id.text == "000" &&
                              //       password.text == "USOFT/MERO") {
                              //     await GetStorage.init();
                              //     GetStorage().write("Access", true);
                              //   }
                              // },
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
