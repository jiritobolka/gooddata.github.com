---
title: Setting up the Notifications using API
excerpt: The article describes how to set up notification using GoodData Notifications API
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Hi everyone! Today we'll take a look at a new feature that helps you being up-to-date with your data. Cory has already mentioned it in the end of his [Building an Analytics App](http://www.gooddata.com/blog/building-an-app-part-2) post. If you want to know what's going on in your Analytics App but don't want to login to GoodData every time you want to check your KPIs, then the Notifications feature is a must have.

How do GoodData Notifications work? You set the condition for a metric (i.e. number of Chatter posts per Opportunity < 16 ). Every time the condition is fulfilled, the application sends the notification to the specified channel. The specified channel can be for example the SalesForce Chatter or Twilio, for example.

## Using the GoodData API via REST Client

Before we start setting up new notifications, we will show you how to easily work with our API. For this purpose you can use the [Rest Client](https://addons.mozilla.org/en-US/firefox/addon/restclient/) for Firefox that is extension for managing API requests. 

<p>
<center><img src="{{ site.root }}/images/posts/rest-client-addon.png" alt="REST Client"></center>
</p>

Remember that you have to be logged into GoodData to use API. It is possible to log in via the UI or on 

`https://<hostname>/gdc/account/login`

which is the authentication page of the API. See the screenshot below. The REST Client picks up the authentication (both from `/gdc/account/login` and from the UI) so you can log in just once. Follow the process that is shown below to set up new notification.

<p>
<center><img src="{{ site.root }}/images/posts/login-page-api.png" alt="Grey Pages Login"></center>
</p>

## Introducing the Notification API

So, you want to start using the Notifications. That means you will need to set it up correctly. The Notifications API consists of two REST resources - Channel Configuration and Subscription Configuration. The Channel defines where the notifications will be sent to and the Subscription Configuration contains details about what and how often will the notifications be sent.

The Channel Configuration is located on following URL 

`https://<hostname>/gdc/account/profile/<profile>/channelConfigurations`

**Note:** You have to use your profile ID in the request URL. This doesn't work with profile Email.

and is used to configure delivery channels. GoodData currently supports two Notifications Channels - SalesForce Chatter and Twilio. To configure the notification that will appear on your SalesForce Chatter, you need to POST the payload that is similar to what is shown below.

{% highlight ruby %}{
   "channelConfiguration":{
      "configuration":{
         "sfdcChatterConfiguration":{
            "username":"your@email",
            "password":"passwordSecurityToken"
         }
      },
      "meta":{
         "title":"SFDC Channel"
      }
   }
}
{% endhighlight %}

As you can see you have to specify your SFDC username and password. The password is a combination of your SFDC password and generated security token.

Let's see the picture below and learn how it works with the REST Client for Firefox. You have to define request type, request url, set the header content type to `application/json`, and paste the request body with json file as we defined it above. Then you can send the request. If everything is correct, you will receive `201 Created` HTTP status.

<p>
<center><img src="{{ site.root }}/images/posts/rest-client.png" alt="REST Client"></center>
</p>

Otherwise, if you want to set up Twilio as a channel, your POST should look something like this:

{% highlight ruby %}{
   "channelConfiguration":{
      "configuration":{
         "twilioSmsConfiguration":{
            "username":"username",
            "password":"AUTH TOKEN",
            "from":"+14086457515",
            "to":"+420724000000"
         }
      },
      "meta":{
         "title":"Twilio Title"
      }
   }
}
{% endhighlight %}

To use Twilio for the notifications, you need to define your Twilio username, password, source phone number and finally phone number the notification will be sent to.

## Setting up the Subscription

So, we've set up the channel and now it's time to move on to the second step of configuration. We'll need to specify the notification condition, message and some other details. The Subscription Configuration resource is located on

`https://<hostname>/gdc/projects/<project>/users/<user>/subscriptions`

and we will set it up once again by POSTing following payload (sure not exactly this one):

{% highlight ruby %}
{
   "subscription":{
      "triggers":[
         {
            "timerEvent":{
               "cronExpression":"0 0/5 * * * *"
            }
         }
      ],
      "condition":{
         "condition":{
            "expression":"f:executeMetric('/gdc/md/ChatterDemo/obj/130001729 < 16)"
         }
      },
      "message":{
         "template":{
            "expression":"Average Chatter posts per Opportunity has fallen to ${f:executeMetric('/gdc/md/ChatterDemo/obj/130001729')} ..."
         }
      },
      "channels":[
         "/gdc/account/profile/1/channelConfigurations/4e313f3d300406ad568d3bec"
      ],
      "meta":{
         "title":"Avg Posts per Oppty < 16"
      }
   }
}
{% endhighlight %}

Now let's describe the file above. First part of config file describes the triggers. It's possible to set up multiple triggers, but in this moment only the timerEvent is supported. The timerEvent needs to have a [CRON expression](http://static.springsource.org/spring/docs/3.0.x/javadoc-api/org/springframework/scheduling/support/CronSequenceGenerator.html) defined. The granularity of notification is driven by platform configuration. In other words, even if a user specifies that he or she wants to receive a notification every minute, the user will probably receive notifications every 15 minutes (depends on configuration). It's also possible to specify a timezone by adding "timezone":"yourtimezone" to the `timerEvent` element. Timezone format is described [here](http://download.oracle.com/javase/6/docs/api/java/util/TimeZone.html).

As we mentioned earlier, the notification is sent only if the `condition` is fulfilled. The condition is based on a [JEXL](http://commons.apache.org/jexl/) expression that has to result in a true/false value. In our example `/gdc/md/ChatterDemo/obj/130001729 < 16` means that condition is true if the metric (which is identified by unique ID) is smaller than 16. 

The `template` describes the notification message, that contains the JEXL template with the metric value. The `channels` element describes which channel the notification will be sent to, based on the configuration. Finally, the `meta` element contains the title of the notification.

**NOTE:** You can also apply GET, PUT or DELETE to the configuration resource to retrieve, update or delete the configuration. Also, all requests has to contain Content-type: application/json request header. 

## The Result

We've set everything up, so now it's time to see the result. Every time the `Average Posts / Opportunity` falls below 16 the notification will be sent to our SFDC Chatter. Check out the screenshot below!

<p>
<center><img src="{{ site.root }}/images/posts/notification.jpg" alt="Metric falls below 16"></center>
</p>

The notification is sent:

<p>
<center><img src="{{ site.root }}/images/posts/notification2.jpg" alt="The Notification is sent"></center>
</p>

Yes, That's it. I hope you will be up-to-date with your data after reading the blogpost!


