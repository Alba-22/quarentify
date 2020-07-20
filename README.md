# Quarentify

![](assets/images/quarentify.png)

https://quarentify.agst.dev

Use a neat interface to check your Spotify stats while you stayed at home.
This project was created and deployed while the COVID-19 pandemic was still at large in Brazil.
It uses the Spotify API and the Flutter web framework to display stats such as the tracks and artists you listened to the most.
It also uses the just mentioned data to learn a little about the user's preferred genres and to create them a recommended playlist.

#### Some app main features:
* Your top 10 heard musics.
* Your top 10 heard artists.
* Most heard music genres.
* Create a personalized playlist based on the musics you heard.
* Share your quarentify to Twitter.

#### Some application images:
![Login Screen](assets/images/login-screen.png)
![Initial Screen](assets/images/main-app.png)

## Local Testing
If you wish to test the application locally without creating a new Spotify application, you must set up a local web server with the appropriate path for the login page and the application itself.
If you wish to test the source code with your own Spotify application, you must use the [implicit grant flow](https://developer.spotify.com/documentation/general/guides/authorization-guide/#implicit-grant-flow) and request "user-top-read" and "playlist-modify-private" scopes.
The login page must be hosted at `localhost:8000` on the root path and the Flutter web application must be located at `localhost:8000/ok`.

### Guided setup
For this tutorial, we'll use Python 3's http server module and a bash shell.
Clone the directory to the desired path:
```bash
$ cd ~/Downloads
$ git clone https://github.com/Alba-22/quarentify
```
Copy the `login` directory to the location in which you wish to test the application and create a new directory named "ok" in it.
```bash
$ cp -r ~/Downloads/quarentify/login ~/quarentify/
$ cd ~/quarentify
$ mkdir ok
```
Build the web application (for more info on how to build a Flutter web app, [click here](https://flutter.dev/docs/get-started/web)) and copy all of its contents to the previously created ``ok`` directory
```bash
$ cp -r ~/Downloads/quarentify/build/web/* ~/quarentify/ok
```
cd into the quarentify directory and start a web server
```bash
$ cd ~/quarentify
$ python -m http.server
```
Open your web browser at localhost:8000.