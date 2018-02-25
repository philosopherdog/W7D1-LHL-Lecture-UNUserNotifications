# W7D1 Lighthouse Lecture

##  User/Push Notification

* So we've heard about `NSNotificationCenter`. It uses the `Observer Design Pattern` to broadcast data from the system (or your own code) to your code in a completely decoupled way. The class used for this is called `NSNotificationCenter`. 

* There is also a mechanism on iOS of user notifications.  Don't confuse the 2.

* User notifications enable an app that is no longer running to alert the user about some event. 

* Eg. Let's say the user setup a calendar event inside your app. User notifications can alert the user of this event even if your app is not running.

* User notifications can be used to pass the user a message. For instance, an impending calendar event, timer event, location geofencing event, or some important data change on a remote server.

* There are 2 types of user notifications on iOS: `local` and `remote`.

* User Notifications can display alerts, and play default or custom sounds to the user, as well as badge the app icon with a number. 

* When the app is in the *foreground* alerts/sounds/badging is off by default, but it is easy to override this behaviour.

* Local and remote notifications look and sound the same from the user's point of view.

* User's can tap to launch the app from the notification or ignore them.

* Local notifications are scheduled and sent by the app itself (no internet needed).

* Remote notifications (aka `Push Notifications`) originate on a remote server (an app may call this server with the payload) that sends a payload to `Apple's Push Notification Service` (APNS).

* APNS in turn calls the device(s) and sends the payload securely.

* For remote notifications, your server environment should be capable of receiving data from user devices and sending notification-related data to APNS.

* Most BAAS systems also include push notification support.

![](Images/diagram4.jpg)

* Note there are 2 Notification API's. `UILocalNotifictions`, and the new system called `UNUserNotifications`. 

* `UNUserNotifications` was introduced in iOS 10. So, you might need to use both API's in an app that is backward compatible. :(

* `UNUserNotification`s is way more powerful. (It goes without saying, prefer current API's over legacy ones).

* `UNUserNotification`s supports media attachments with the `UNNotificationAttachment` object. This allows attaching audio, video and images to your notifications. 

These attachments can't be sent remotely. Instead you will use a notification service extension to modify your remote notification before it is delivered which allows you to pull in resources locally or remotely. (see [UNNotificationServiceExtension](https://developer.apple.com/documentation/usernotifications/unnotificationserviceextension) for more details.) 

# Demo LocalNotification<=

#### The steps for configuring a local notification are as follows:

1. Request authorization using `requestAuthorization(options:completionHandler:)` (same for both local and remote notifications)
1. Create and configure a `UNMutableNotificationContent` object with the notification details.
1. Create a `UNCalendarNotificationTrigger`, `UNTimeIntervalNotificationTrigger`, or `UNLocationNotificationTrigger` object to describe the conditions under which the notification is delivered.
1. Create a `UNNotificationRequest` object with the content and trigger information.
1. Call the `addNotificationRequest:withCompletionHandler:` method to schedule the notification.

# Remote Notification Demo



# References

* [Local and Remote Notification Programming Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/)

### REST Requests For Today’s Assignment

# CloudTracker REST Requests
