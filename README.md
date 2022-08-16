# photo-journal-capstone

## Description
Photo Journal is an iOS mobile app. It can help organize your days/activities that you take a lot of pictures and/or want to write about. You can choose up to 3 photos for each entry, so it makes you focus on which photos you like most, or which ones represent your day best. You can also enter in as much text as you would like. You can lookup past entries by a list view or by a map. If you travel a lot and include the location, this is a great way to see where in the world you have been and what you did those days!

## Feature Details
The main features are creating an entry and looking up past entries by list view or by map view. The home page has no functionality other than being the view that the app opens up to. 

The Create New Entry page allows a user to enter a title, location, date, journal text, and select three photos. All fields are optional, however, default values are provided.

| Field | Default Value |
| ----------- | ----------- |
| title | Title |
| location | Unknown |
| date | Current date |
| entryText | ""|
| image | random image of animal | 

The Lookup section displays past entries by most recent date. The user can see the location, date, and title. To delete an entry, swipe left. To view the specfic entry, tap on it. 

The Map section is an alternate way to view all entries. latitude and longitude are properties stored with an entry depending on user input for location. If location is empty or not a valid location with LocationIQ API, the default coordinates will be 0, 0. An entry is represented by a blue dot. You can tap on the dot to view the specific entry. There is currently no way to select an entry if the location is the same as another entry. Those must be selected in the list Lookup setction.

The single entry view can only be reached by the list view or map view. It displays all fields of an entry: title, location, date, image1 - image3, and entryText. There are currently no edit features.

## Set Up
Because this is not set up in Apple's App Store, please follow the steps below to install. All libraries are supported by Swift/SwiftUI so it should be quick and easy.

1. Download Xcode
2. Clone repo and open in Xcode
3. Connect your phone to Xcode simulator and run it. This should load the app on your phone. (As of Aug2022 this tutorial works: https://www.youtube.com/watch?v=Fo1A36RsoCI)
Done!

