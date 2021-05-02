
# App Requirements Task

A flutter project to add and retrieve covid resources with state and type filtering. The backend is in express and mongodb. 

## Setup

- First, clone the repository with the 'clone' command, or just download the zip.

```
$ git clone https://github.com/InfiniteVerma/app_rec_task
```


### Backend

 - Install backend dependencies by running ```npm i``` while in the ```backend/``` folder.
 -  Add ```DB_URL``` in a ```.env``` file and copy paste the mongodb url after setting it up on mongodb atlas. 
 - Run ```npm run dev``` and verify everything is working.
 - Deploy on heroku. Use this [link](https://devcenter.heroku.com/articles/getting-started-with-nodejs) for details.

### App

- Install dependencies from pubspec.yaml by running `flutter packages get` after navigating into the ```app/``` directory.
## Run

Run you app

```
flutter run 
```

To hot restart (and rebuild state), press "R".
