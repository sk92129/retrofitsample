# retrofitsample


There are two branches:
main - initial work but has a runtime error
fixes - is based on main and contains the fixes for the runtime error of fetching the data


## Getting Started


Old style API call looks like this.

```
Future<User> getUser(int id) async {
  final response = await http.get(
    Uri.parse('https://api.example.com/users/$id'),
    headers: {'Content-Type': 'application/json'},
  );
  
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}

```

With retrofit, it looks like

```
@GET('/users/{id}')
Future<User> getUser(@Path('id') int id);
```



##
To build

flutter pub get

dart run build_runner build --delete-conflicting-outputs 
