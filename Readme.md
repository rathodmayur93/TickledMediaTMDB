
# Tickled Media Assignment

## Project Detail

This is an assignment, in which I have created an app which fetches the MovieList using TMDB API's and showing the detail of the movie. The features are described in the following sections. App support dark mode too.

- MovieListScreen

- Movie Detail Screen

- Add Contact Screen

## Why MVP Architecure
Here in this project i have tried to implement the MVP architecture reason are as below 

- Distribution - since i wanted to maintain the distribution of the code and we have the most of responsibilities  in the Presenter, with the pretty dumb View .
- Testability — testablity of this architecure is good, we can test most of the business logic.
- Easy of use - Its easy to understand and simple to maintain

## Requirments

- Xcode 11.1

- Swift 5

- iOS 13.1

## Features

### Movie List Screen

This screen lists all available movies from the TMDB api along with their photos. To implement this screen I have tried to use MVP architecture. Whenever each photo is loaded will store it in cache so next time we dont have to load it from server this will reduce the netwok calls and enhance the user experience. All the business logic and api calls are written in the FetchMoviePresenter file. It also have pull to refersh.

### Movie Detail Screen

Tapping on a movie in the movie list screen leads you to the Movie Detail screen. This screen shows the details of the movie  such as Movie title, tagline, run time, average vote, release date and movie overview. To implement this screen I have tried to use MVP architecture. All the business logic and api calls are written in the MovieDetailViewPresenter file.

## Unit Test Cases

I have divided the unit test cases into the three major part which are as below

- SereviceTest

- Presenter

- Data Source


### ServiceTest
The unit test case under this group will test all the API service we have created in this project

### ViewModelAndPresenter
The unit test case under this group will test the business logic which we have created for all the screens in this project.

### DataSource
The unit test case under this group will test all the data source i.e TableViewDataSource & TableviewDelegate methods we have created in this project


## What if i had more time ?
 
- If i had more time definately i would have implemented the Search Feature where user can search movie
- We can show an genere list and on selecting the genere will show the respective genere movie list
- We can also have vote feature 
- Showing more detail of the movie on the movie detail screen
- More Enhacne UI
- Better Image caching technique
- Handling the internet case more efficiently 
- More Unit test cases

 

