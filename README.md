# Flutter App with BLoC and Architecture

A Flutter app that displays a list of posts fetched from an API with a timer for each post. The timer starts when the post appears, pauses when the item is scrolled away, and resumes when it reappears. The app also includes a splash screen.

## Features 

- **Mark as Read**: When a user clicks on a list item then set the tileColor to white if the post is marked as read.
- **Timer Functionality**: Each post has a timer that starts when visible and pauses when it's scrolled out of view or the user navigates away.
- **Timer Icon**: Each post has a timer icon with random int value in seconds.
## Libraries Used

- **flutter_bloc**: For state management.
- **provider**: To manage timer state.
- **visibility_detector**: To track visibility of posts for timer control.
- **http**: To fetch data from the API.

### Steps to clone this project

1. Clone this repository to your local machine:
   ```bash
   git clone https://github.com/chauhan057/Post_List.git
   cd Post_List
