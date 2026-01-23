import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram/pages/feed_page.dart';
import 'package:instagram/pages/login_page.dart';
import 'package:instagram/service/firebase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


List<Map<String, dynamic>> textlar = [
  // ===================== ENGLISH =====================
  {
    // Register 1 - Email
    "email_question": "What's your email address",
    "email_explain": "Enter the email address where you can be contacted. No one else will see this on your profile",
    "email_hint": "Email address",
    "email_label": "Email",
    "email_reminder": "You may receive notification or check out your email",
    "email_error": "Email should end with '@gmail.com'",

    // Register 2 - Password
    "password_question": "Create a password",
    "password_explain": "Create a password with at least 8 characters",
    "password_hint": "Password",
    "password_label": "Password",
    "password_reminder": "Make sure your password is strong and secure",
    "password_error": "Password must be at least 8 characters",

    // Register 3 - DOB
    "dob_question": "What's your date of birth?",
    "dob_explain": "Use your real date of birth. This information will not be public",
    "dob_hint": "Date of birth",
    "dob_label": "Date of birth",
    "dob_reminder": "You must be at least 13 years old",
    "dob_error": "Please enter a valid date",

    // Register 4 - Full name
    "name_question": "What's your full name?",
    "name_explain": "Enter your real name",
    "name_hint": "Full name",
    "name_label": "Full name",
    "name_reminder": "Your name will be visible on your profile",
    "name_error": "Name cannot be empty",

    // Register 5 - Username
    "username_question": "Create a username",
    "username_explain": "Choose a unique username for your profile",
    "username_hint": "Username",
    "username_label": "Username",
    "username_reminder": "You can change it later in settings",
    "username_error": "Username must be at least 4 characters",

    // Common
    "next": "Next",
    "loginga": "I already have an account",
    "errorcha" : "Something is wrong"
  },

  // ===================== UZBEK =====================
  {
    // Register 1 - Email
    "email_question": "Email manzilingizni kiriting",
    "email_explain": "Siz bilan bog‘lanish mumkin bo‘lgan email manzilni kiriting. Bu ma’lumot profilingizda ko‘rinmaydi",
    "email_hint": "Email manzil",
    "email_label": "Email",
    "email_reminder": "Sizga bildirishnoma yuborilishi mumkin",
    "email_error": "Email '@gmail.com' bilan tugashi kerak",

    // Register 2 - Password
    "password_question": "Parol yarating",
    "password_explain": "Kamida 8 ta belgidan iborat parol kiriting",
    "password_hint": "Parol",
    "password_label": "Parol",
    "password_reminder": "Parolingiz ishonchli bo‘lishi kerak",
    "password_error": "Parol kamida 8 ta belgidan iborat bo‘lishi kerak",

    // Register 3 - DOB
    "dob_question": "Tug‘ilgan sanangizni kiriting",
    "dob_explain": "Haqiqiy tug‘ilgan sanangizni kiriting. Bu ma’lumot oshkor qilinmaydi",
    "dob_hint": "Tug‘ilgan sana",
    "dob_label": "Tug‘ilgan sana",
    "dob_reminder": "Siz kamida 13 yoshda bo‘lishingiz kerak",
    "dob_error": "Iltimos, to‘g‘ri sana kiriting",

    // Register 4 - Full name
    "name_question": "To‘liq ismingizni kiriting",
    "name_explain": "Haqiqiy ismingizni kiriting",
    "name_hint": "To‘liq ism",
    "name_label": "To‘liq ism",
    "name_reminder": "Ismingiz profilingizda ko‘rinadi",
    "name_error": "Ism bo‘sh bo‘lishi mumkin emas",

    // Register 5 - Username
    "username_question": "Foydalanuvchi nomi yarating",
    "username_explain": "Profilingiz uchun noyob nom tanlang",
    "username_hint": "Foydalanuvchi nomi",
    "username_label": "Foydalanuvchi nomi",
    "username_reminder": "Keyinroq sozlamalarda o‘zgartirishingiz mumkin",
    "username_error": "Foydalanuvchi nomi kamida 4 ta belgidan iborat bo‘lishi kerak",

    // Common
    "next": "Keyingi",
    "loginga": "Menda allaqachon hisob bor",
    "errorcha" : "Nimadir xato ketti"
  },

  // ===================== RUSSIAN =====================
  {
    // Register 1 - Email
    "email_question": "Какой у вас email адрес?",
    "email_explain": "Введите email адрес, по которому с вами можно связаться. Он не будет виден другим",
    "email_hint": "Email адрес",
    "email_label": "Email",
    "email_reminder": "Вы можете получить уведомление",
    "email_error": "Email должен заканчиваться на '@gmail.com'",

    // Register 2 - Password
    "password_question": "Создайте пароль",
    "password_explain": "Пароль должен содержать минимум 8 символов",
    "password_hint": "Пароль",
    "password_label": "Пароль",
    "password_reminder": "Пароль должен быть надёжным",
    "password_error": "Пароль должен быть не менее 8 символов",

    // Register 3 - DOB
    "dob_question": "Укажите дату рождения",
    "dob_explain": "Введите вашу настоящую дату рождения",
    "dob_hint": "Дата рождения",
    "dob_label": "Дата рождения",
    "dob_reminder": "Вам должно быть не менее 13 лет",
    "dob_error": "Введите корректную дату",

    // Register 4 - Full name
    "name_question": "Введите ваше полное имя",
    "name_explain": "Введите ваше настоящее имя",
    "name_hint": "Полное имя",
    "name_label": "Полное имя",
    "name_reminder": "Имя будет отображаться в профиле",
    "name_error": "Имя не может быть пустым",

    // Register 5 - Username
    "username_question": "Создайте имя пользователя",
    "username_explain": "Выберите уникальное имя пользователя",
    "username_hint": "Имя пользователя",
    "username_label": "Имя пользователя",
    "username_reminder": "Вы сможете изменить его позже в настройках",
    "username_error": "Имя пользователя должно быть не менее 4 символов",

    // Common
    "next": "Далее",
    "loginga": "У меня уже есть аккаунт",
    "errorcha" : "что-то пошло не так"
  },
];


int currentIndex = 0;

late String gmail;
late String password;
late String fullName;
late String dob;
late String username;


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  List<Map<String, dynamic>> languages = [
    {
      "tili" : "en",
      "bayroq" : "assets/english.png"
    },
    {
      "tili" : "uz",
      "bayroq" : "assets/uzbek.png"
    },
    {
      "tili" : "ru",
      "bayroq" : "assets/russian.png"
    }
  ];

  void changeLanguage(int index){
    setState(() {
      currentIndex = index;
    });
  }


  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // orqaga qaytish uchun holos
      appBar: AppBar(
        actions: [
          GestureDetector(
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
              children: [
                Text(
                  "${languages[currentIndex]["tili"]}",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(width: 10,),
                Image.asset(
                    width: 40,
                    height: 40,
                    "${languages[currentIndex]["bayroq"]}"
                ),
                SizedBox(width: 20,)
              ],
            ),
          )
        ],
      ),

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // gmail
                    Text(
                      "${textlar[currentIndex]["email_question"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),

                    SizedBox(height: 10,),

                    // tushuntirish
                    Text(
                        "${textlar[currentIndex]["email_explain"]}",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.grey.shade800
                      ),
                    ),

                    SizedBox(height: 25,),

                    // input
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: textlar[currentIndex]["email_hint"],
                        labelText: textlar[currentIndex]["email_label"],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                    ),

                    SizedBox(height: 25,),

                    // SMS tushuntirish
                    Text(
                      "${textlar[currentIndex]["email_reminder"]}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600
                      ),
                    ),

                    SizedBox(height: 15,),

                    // Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        fixedSize: Size(400, 50)
                      ),
                      onPressed: (){
                        if(_emailController.text.isNotEmpty){
                          if(_emailController.text.endsWith("@gmail.com")){
                            setState(() {
                              gmail = _emailController.text;
                            });

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register2()
                              )
                            );

                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                content: Text(
                                  "${textlar[currentIndex]["email_error"]}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              )
                            );
                          }
                        }
                      },
                      child: Text(
                        "${textlar[currentIndex]["next"]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23
                        ),
                      )
                    ),
                  ],
                ),
              ),

              // loginga
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage()
                    )
                  );
                },
                child: Text(
                  "${textlar[currentIndex]["loginga"]}",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}


class Register2 extends StatefulWidget {
  const Register2({
    super.key,
  });

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {

  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // gmail
                    Text(
                      "${textlar[currentIndex]["password_question"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),

                    SizedBox(height: 10,),

                    // tushuntirish
                    Text(
                      "${textlar[currentIndex]["password_explain"]}",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey.shade800
                      ),
                    ),

                    SizedBox(height: 25,),

                    // input
                    TextField(
                      controller: _passController,
                      decoration: InputDecoration(
                          hintText: textlar[currentIndex]["password_hint"],
                          labelText: textlar[currentIndex]["password_label"],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 25,),

                    // SMS tushuntirish
                    Text(
                      "${textlar[currentIndex]["password_reminder"]}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600
                      ),
                    ),

                    SizedBox(height: 15,),

                    // Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            fixedSize: Size(400, 50)
                        ),
                        onPressed: (){
                          if(_passController.text.isNotEmpty){
                            if(_passController.text.length >= 8){
                              setState(() {
                                password = _passController.text;
                              });

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register3()
                                  )
                              );

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "${textlar[currentIndex]["password_error"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  )
                              );
                            }
                          }
                        },
                        child: Text(
                          "${textlar[currentIndex]["next"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23
                          ),
                        )
                    ),
                  ],
                ),
              ),

              // loginga
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      )
                  );
                },
                child: Text(
                  "${textlar[currentIndex]["loginga"]}",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Register3 extends StatefulWidget {
  const Register3({
    super.key,
  });

  @override
  State<Register3> createState() => _Register3State();
}

class _Register3State extends State<Register3> {

  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // gmail
                    Text(
                      "${textlar[currentIndex]["dob_question"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),

                    SizedBox(height: 10,),

                    // tushuntirish
                    Text(
                      "${textlar[currentIndex]["dob_explain"]}",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey.shade800
                      ),
                    ),

                    SizedBox(height: 25,),

                    // input
                    TextField(
                      controller: _dobController,
                      decoration: InputDecoration(
                          hintText: textlar[currentIndex]["dob_hint"],
                          labelText: textlar[currentIndex]["dob_label"],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 25,),

                    // SMS tushuntirish
                    Text(
                      "${textlar[currentIndex]["dob_reminder"]}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600
                      ),
                    ),

                    SizedBox(height: 15,),

                    // Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            fixedSize: Size(400, 50)
                        ),
                        onPressed: (){
                          if(_dobController.text.isNotEmpty){
                            setState(() {
                              dob = _dobController.text;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register4()
                                )
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "${textlar[currentIndex]["dob_error"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                )
                            );
                          }
                        },
                        child: Text(
                          "${textlar[currentIndex]["next"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23
                          ),
                        )
                    ),
                  ],
                ),
              ),

              // loginga
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      )
                  );
                },
                child: Text(
                  "${textlar[currentIndex]["loginga"]}",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



class Register4 extends StatefulWidget {
  const Register4({
    super.key,
  });

  @override
  State<Register4> createState() => _Register4State();
}

class _Register4State extends State<Register4> {

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // gmail
                    Text(
                      "${textlar[currentIndex]["name_question"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),

                    SizedBox(height: 10,),

                    // tushuntirish
                    Text(
                      "${textlar[currentIndex]["name_explain"]}",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey.shade800
                      ),
                    ),

                    SizedBox(height: 25,),

                    // input
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                          hintText: textlar[currentIndex]["name_hint"],
                          labelText: textlar[currentIndex]["name_label"],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 25,),

                    // SMS tushuntirish
                    Text(
                      "${textlar[currentIndex]["name_reminder"]}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600
                      ),
                    ),

                    SizedBox(height: 15,),

                    // Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            fixedSize: Size(400, 50)
                        ),
                        onPressed: (){
                          if(_nameController.text.isNotEmpty){
                            setState(() {
                              fullName = _nameController.text;
                            });

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register5()
                                )
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      "${textlar[currentIndex]["name_error"]}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                )
                            );
                          }
                        },
                        child: Text(
                          "${textlar[currentIndex]["next"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23
                          ),
                        )
                    ),
                  ],
                ),
              ),

              // loginga
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      )
                  );
                },
                child: Text(
                  "${textlar[currentIndex]["loginga"]}",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class Register5 extends StatefulWidget {
  const Register5({
    super.key,
  });

  @override
  State<Register5> createState() => _Register5State();
}

class _Register5State extends State<Register5> {

  final _usernameController = TextEditingController();


  void register() async {
    try{
      // firebase'ga saqlash
      FireBaseService service = FireBaseService();
      final result = await service.register(gmail, password, dob, fullName, username);

      // sharedpref'ga ulash
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool("isAuthenticated", true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => FeedPage()
        )
      );
    } on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "${textlar[currentIndex]["errorcha"]}"
          )
        )
      );
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  "${textlar[currentIndex]["errorcha"]}"
              )
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    // gmail
                    Text(
                      "${textlar[currentIndex]["username_question"]}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),
                    ),

                    SizedBox(height: 10,),

                    // tushuntirish
                    Text(
                      "${textlar[currentIndex]["username_explain"]}",
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.grey.shade800
                      ),
                    ),

                    SizedBox(height: 25,),

                    // input
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          hintText: textlar[currentIndex]["username_hint"],
                          labelText: textlar[currentIndex]["username_label"],
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)
                          )
                      ),
                    ),

                    SizedBox(height: 25,),

                    // SMS tushuntirish
                    Text(
                      "${textlar[currentIndex]["username_reminder"]}",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600
                      ),
                    ),

                    SizedBox(height: 15,),

                    // Button
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            fixedSize: Size(400, 50)
                        ),
                        onPressed: () async {
                          if(_usernameController.text.isNotEmpty){
                            if(_usernameController.text.length >= 4){
                              setState(() {
                                username = _usernameController.text;
                              });

                              register();

                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        "${textlar[currentIndex]["username_error"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                  )
                              );
                            }
                          }
                        },
                        child: Text(
                          "${textlar[currentIndex]["next"]}",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 23
                          ),
                        )
                    ),
                  ],
                ),
              ),

              // loginga
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginPage()
                      )
                  );
                },
                child: Text(
                  "${textlar[currentIndex]["loginga"]}",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
