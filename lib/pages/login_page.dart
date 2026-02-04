import 'package:flutter/material.dart';
import 'package:instagram/pages/feed_page.dart';
import 'package:instagram/pages/register_page.dart';
import 'package:instagram/service/firebase_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  List<Map<String, dynamic>> textlar = [
    // ingliz tili
    {
      "email" : "Enter your email",
      "email_label" : "Email",
      "password" : "Enter your password",
      "password_label" : "Password",
      "login" : "Log in",
      "forget" : "Forgot password?",
      "create" : "Create new account",
      "error" : "Please complete the form",
      "404" : "User Not Found"
    },

    // o'zbek tili
    {
      "email" : "Pochta manzilingizni kiriting",
      "email_label" : "Pochta",
      "password" : "Parolingizni kiriting",
      "password_label" : "Parol",
      "login" : "Hisobga o'tish",
      "forget" : "Parolingizni unutdingizmi?",
      "create" : "Yangi hisob yaratish",
      "error" : "Iltimos ma'lumot kiriting",
      "404" : "Bunday foydalanuvchi mavjud emas"
    },

    // rus tili
    {
      "email" : "Введите ваш email",
      "email_label" : "Email",
      "password" : "Введите пароль",
      "password_label" : "Пароль",
      "login" : "Войти",
      "forget" : "Забыли пароль?",
      "create" : "Создать новый аккаунт",
      "error" : "Пожалуйста, заполните форму",
      "404" : "Пользователь не найден"
    }
  ];

  List<String> languages = [
    "English (US)",
    "Uzbek (UZ)",
    "Russian (RU)"
  ];

  int currentIndex = 0;

  void changeLanguage(int index){
    setState(() {
      currentIndex = index;
    });
  }

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  void login() async {
    if(_emailController.text.isNotEmpty && _passController.text.isNotEmpty){

      try{
        // ma'lumotni firebase databazasiga yuborish
        FireBaseService service = FireBaseService();
        final result = await service.login(_emailController.text, _passController.text);

        // agar ro'yhat o'tgan bo'sa, feedga o'tkazamiz
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => FeedPage()
          )
        );
      } catch(error){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "${textlar[currentIndex]["404"]}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            duration: Duration(seconds: 2),
          )
        );
      }

    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "${textlar[currentIndex]["error"]}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: GestureDetector(
                    onTap: (){
                      showModalBottomSheet(
                          context: context,
                          builder: (context){
                            return Container(
                              margin: EdgeInsets.all(10),
                              height: 300,
                              width: 500,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 35
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      changeLanguage(0);
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                width: 60,
                                                height: 60,
                                                "assets/english.png"
                                            ),
        
                                            SizedBox(width: 20,),
        
                                            Text(
                                              "English",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25
                                              ),
                                            )
                                          ],
                                        ),
        
                                        Icon(
                                          Icons.ads_click,
                                          size: 27,
                                        )
        
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      changeLanguage(1);
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                width: 60,
                                                height: 60,
                                                "assets/uzbek.png"
                                            ),
        
                                            SizedBox(width: 20,),
        
                                            Text(
                                              "Uzbek",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25
                                              ),
                                            )
                                          ],
                                        ),
        
                                        Icon(
                                          Icons.ads_click,
                                          size: 27,
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: (){
                                      changeLanguage(2);
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                width: 60,
                                                height: 60,
                                                "assets/russian.png"
                                            ),
        
                                            SizedBox(width: 20,),
        
                                            Text(
                                              "Russian",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25
                                              ),
                                            )
                                          ],
                                        ),
        
                                        Icon(
                                          Icons.ads_click,
                                          size: 27,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${languages[currentIndex]}",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: 29,
                        )
                      ],
                    ),
                  ),
                ),
        
                SizedBox(height: 35,),
        
                Image.asset(
                  height: 100,
                  width: 100,
                  "assets/logo.png"
                ),
        
                SizedBox(height: 70,),
        
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: textlar[currentIndex]["email"],
                    labelText: textlar[currentIndex]["email_label"],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                  ),
                ),
        
                SizedBox(height: 15,),
        
                TextField(
                  controller: _passController,
                  decoration: InputDecoration(
                      hintText: textlar[currentIndex]["password"],
                      labelText: textlar[currentIndex]["password_label"],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      )
                  ),
                ),
        
                SizedBox(height: 15,),
        
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    fixedSize: Size(340, 50)
                  ),
                  onPressed: login,
                  child: Text(
                    textlar[currentIndex]["login"],
                    style: TextStyle(
                      fontSize: 18
                    ),
                  )
                ),
        
                SizedBox(height: 25,),
        
                Text(
                  textlar[currentIndex]["forget"],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
        
                SizedBox(height: 130,),
        
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    fixedSize: Size(340, 50),
                    side: BorderSide(
                      color: Colors.blueAccent,
                      width: 2
                    )
                  ),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPage()
                      )
                    );
                  },
                  child: Text(
                    textlar[currentIndex]["create"],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
