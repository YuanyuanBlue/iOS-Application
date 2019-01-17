# Homework One  
For this homework, I completed the tasks specified in the instruction.  
Then I added some additional features. And here is what I did.  
* I tried to write compact and well-struct code.   
* I added implement the description in DukePerson to provide overall information   
  about a person. 
* I added detailed comment before each class or function to let the reader   
  understand my code well.  
* My code includes array, dictionary, set, class, function, closure expression,   
  enum for the 1st category string, character, int, bool, float for the 2nd    
  category for/in, while, if/else, switch/case for the 3rd category assignment,    
  arithmatic, comparison, nil coalescing, range, logical for the 4th category
* Users can pass "\*" to whoIs function to get several results. I created a     
  DukePerson array -- "personArray" contains 4 people. And I added a testcase    
  "//print(whoIs("*"))" to test the function. Testcases are just before the end  
  of the homework.   
* I added an additional function -- "findByDegree(_ degree: String) -> String ",   
  so that you can pass "MS", "BS" or "Phd" to find specific people. There is    
  testcase to find who has a Master Degree.   
* I created a generic Stack data structure. And Stack works well in my calculate   
  function.
* I created a toolBox class, which contains two static method. The "sortByHeight    
  " function helps to sort DukePerson in a collection by height. The testcase   
  sorts four people by height and then prints their heights. You can reference   
  the comment before toolBox to get more detials.   
* There is a calculate function in toolBox and can be used as a basic           
  calculator. You can reference the comment before toolBox to get more detials.    
  Also I provided some testcases in my code.
* I tried to use exceptions in my code. The error types are in the MyError enum.   
  For example, DukePerson constructor can throw exception if                    
  bestProgrammingLanguages array contains more than 3 members. I also have a    
  testcase for this -- give Yuanyuan 4 best programming languages, the          
  constructor will throw exception.  

# Homework Two    
For this homework, I completed the tasks specified in the instruction.   
I provided 3 default case to test. I have "Ric Telford", "Peiyi Chen" -- my roomate,  
and "Yuanyuan Yu" -- myself in this app by default. You can find them first to  
have a look of this app.  

![clone](/egImg/eg1.jpeg)  

Then I added some additional features. And here is what I did.  
* I managed to hide the keyboard when the user hit enter.   
* I added clear buttons in each box, so that you can clear the text when editting.  
* I used a pickerView to let users select their gender.  
  pickerView reference: https://stackoverflow.com/questions/44223862/how-do-i-change-the-font-size-in-a-uipickerview-in-swift-3/44223906    
* I added extensive error checking. When input is not valid, the user will be  
  alerted. You can try to put whitespaces into firstname or lastname, then you  
  will get a invalid name alert. Also if you put invalid string into degree or  
  put more then 3 hobbies or langs, you will get an alert.   
* I handled the leading and trailing whitespace for input firstname, lastname,    
  degree... So that users don't need to bother whitespace problem.  
* I provided a nice layout    
* I used a lot of color, font and style.   
* I tried to add extensions to UILabel and UITextField to create a bottom border.   
  To create this kind of border I refered antdwash's youtube video.   
  https://www.youtube.com/watch?v=ca057x6Ux3s   
* I added an imageView to display photos. I only provide images for 3 people for   
  test. You can try to find "Ric Telford", "Yuanyuan Yu" or "Peiyi Chen" to see  
  their photos.  
* I provided a "add/update" button. If the person is existed, it will update the   
  the person's information. To be specific, if you leave a box blank, it will    
  not update the information in that box, to prevent losing information. I   
  used a dictionaty to record each person to get a O(1) update time complexity.  
* I saved more than 100 rows of code by implementing my own TextBlock class which   
  extended the UIView class. Each TextBlock represents a box from UI. They are   
  similar, therefore, I only need to new a TextBlock instead of writing same   
  attribute every time.  
   

# Homework Three  
For this homework, I completed the tasks specified in the instruction.   
I provided 3 default cases to test. I have "Ric Telford", "Peiyi Chen" -- my    
roomate, and "Yuanyuan Yu" -- myself in this app by default. You can add any case   
you want.

![clone](/egImg/eg2.jpeg)  

![clone](/egImg/eg3.jpeg)  

Then I added some additional features. And here is what I did.  
* Add a “Team” field to the Person information screen and to my data model. Team    
  only applies to Students (not TAs or Professor). You can search teams using my    
  search bar. When you type in the search bar, it will show teams whose names    
  contains substring you type in.
* Add Picture support. That is, when you add or edit a new Person, you can click   
  the take pic button to take their picture. I saved the picture and displayed   
  on both the Table View and the Information View.   
* Creativeness in the design of my Table View and Cells. I researched on how to     
  add gif. And I added gif as default image for people.   
  Reference:   
  The gif tool is provided by https://github.com/kiritmodi2702/GIF-Swift   
  The gif image is from https://www.google.com/imgres?imgurl=https%3A%2F%2Fww1.sinaimg.cn%2Flarge%2F47481d23jw1eutt4u19cxj207i09wt9e.jpg&imgrefurl=http%3A%2F%2Ftw.weibo.com%2Fryuetsuya%2F3873142386963201&docid=qDLpnHqqkseowM&tbnid=0zcWYMvRGpwVGM%3A&vet=10ahUKEwjlx9ms8M3dAhUE71MKHZT5AiIQMwh7KEkwSQ..i&w=270&h=356&bih=751&biw=1439&q=火影忍者%20向日葵&ved=0ahUKEwjlx9ms8M3dAhUE71MKHZT5AiIQMwh7KEkwSQ&iact=mrc&uact=8#h=356&imgdii=85FnE3VqsFFQuM:&vet=10ahUKEwjlx9ms8M3dAhUE71MKHZT5AiIQMwh7KEkwSQ..i&w=270     
* Additional functions of my own creation:   
  1. search bar
  2. delete button. Please swipe left on each person cell and then click delete   
     button to delete that person.
* Clever code – a unique approach or algorithm    
  I handled the add/edit function uniquely. I only use one scene for add and edit.   
  I chenged add/edit mode by checking their segues. And I created a isNewPerson    
  Bool and a SaveBtn enum to handle the add/edit mode.   
* I researched on how to make a nice look UI and give my UI a good styling.   
    

# Homework Four  
For this homework, I completed the tasks specified in the instruction.    
You can click on the cell with my name "Yuanyuan" on it. Then you can turn the    
information page, because I used a pageViewController. When you want to get back,   
just turn the page back. When you are in the Drawing page, you can click the white   
plate at the bottom to fly the ball or star. Baseball can fly in daytime and star   
can fly at night. Click the plate about 15 times to change night to day or day to night.   
Then I added some extra features.   
And here is what I did.    
* Use a PageView Controller to transition from the Information View to the Drawing View.
* Add background music to the Drawing View.   
* Creativity / Complexity in the drawings inside the graphic context.   
-- I think my design is kind of creative.  
-- In my ballParkView, I used layers to build my ballpark. I provide two graidient   
   layers to build the sky. Then I build grass using vector graph. After that, I    
   use a textlayer to build a "STRIKE!" on the grass. Finally, I draw on the layer   
   to build the base path.   
-- I learned how to build SKScene on Youtube. And I built a BallScene to let the   
   user play with animation. You can click the white plate at the bottom, and baseballs   
   will fly on the sky when it's daytime, starts will fly at night. After clicking    
   the circle around 15 times, the sky will change its color to daytime or night.   
-- I used UIView animation to animate two cloud images and a baseball bat image.   
   

![clone](/egImg/eg4.jpeg)  

![clone](/egImg/eg5.jpeg)  

 
Image Reference:   
baseball image:  https://www.kisspng.com/png-baseball-bat-batting-small-ball-clip-art-animated-111220/download-png.html    
cloud image:  https://www.kisspng.com/png-white-cloud-cartoon-drawing-cartoon-clouds-clouds-325868/   
baseball bat:  https://www.carstickers.com/products/stickers/sports-and-recreation-stickers/baseball-stickers/details/crossed-baseball-softball-bats/

# Homework Five    
For this homework, I completed the tasks specified in the instruction.   
And then, here is what I did in addition.
* I have a search bar to search people by their name.   
* I have stored information to tell whether a Dukeperson has work experience.   
* I managed to store and load photos for Dukeperson.   
* I researched on how to use UISegmentedControl and I used it in my info view.   
* I supported gif image in my DukePersonViewController so that you can see gif in    
  each person cell by default. Last time I lost some images, so it didn't show    
  the gif. And now, I fixed it.
   
# Homework Six
For this homework, we completed the tasks specified in the instruction.  
We have a GET button in the nav bar, please click it to get people from   
the server. Then for each tableview cell, we have a POST button to add   
or update the person to the server. To take a picture please position your   
phone to horizontal and let the left side of the phone to be the bottom side   
of the horizontal phone. 
For basic functions such as add, edit ... please see README before Homework Six.   
