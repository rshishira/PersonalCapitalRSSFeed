# PersonalCapitalRSSFeed

#Prerequisites to run this application:
- Xcode 9 and supports Objective C Programming language.
- No dependencies or third party library used.

#The objective of this mobile application is to read RSS feed articles into a CollectionView in a specific layout and on selecting each cell would display details of the selected article. This application supports all orientations, and has been implemented without using Interface Builder and adding Auto Layout constraints programatically. 
This application adapts Model View Controller(MVC) design pattern.
Note: When loading the UIWebView on details screen, it take few minutes longer to load the content only the first time.

#Detailed functionality of the application:
#The RSS feed https://blog.personalcapital.com/feed/?cat=3,891,890,68,284 is parsed using NSXMLParser and asynchronously l     loads the contents of the feed onto a UICollectionView. 

#Displays a loading indicator while the feed is being fetched. Have implemented a factory method which instantiates             UIActivityIndicatorView and its attributes and makes it accessible accross application.

#Added Navigation controller in AppDelegate and set its common appearance attributes there, which reflects accross the          application.

#Each article is represented as an item in the RSS feed xml. Each article has an html encoded title represented in the title   node, an image represented in the media:content node, a quick html encoded summary represented in the description node, a     publish date represented in the pubDate node, and a link to the article actual article represented in the link node.
#All HTML encoded content are managed using NSAttributedString.

#The main screen displays the title of the feed represented in the feed’s html encoded title node and display each article in   a scrolling list that correctly utilizes the space of the device screen.  

#The first article takes prominence at the top and displays the image, title on one line with the rest ellipsed, and the       first two lines of the summary with the rest ellipsed if necessary.  
#Each article after is displayed underneath the main article and represented by the image and title underneath            (rendering at most 2 lines of the title with the rest ellipsed if necessary). 

#Have used size classes to support the below requirements.
#If handset, the articles are displayed in rows of 2.  
#If tablet, the articles are displayed in rows of 3.

#The "Reresh" is implemented using pull to refresh, a property now available on UITableView's or UICollectionViews, and added target @selector which will query the RSS feed again and refresh the screen.

#Selecting an article renders the article’s link in an embedded UIWebview on a second screen with the title of the article     displayed in the navigation bar.
“?displayMobileNavigation=0” is appended to each article’s link, this is handled in RSSFeedDataManager when parsing the article's link node.

Further implementation and feature enhancement that will improve the user experience:
#We can use custom autolayout to support layout of collection view cells.
#Could not complete adding activity indicator to each cell to signify the content being loaded on individual cells.
#We can use Core Data to save locally and optimally use memory if the RSS Feed has large amounts of data to be handled.
#Make NavBar hidden while scrolling down on the UIWebview.
#Create Unit Tests 

