---
title: Add user to project with REST API
excerpt: This article provides a tutorial how to add user to project with GoodData User Provisioning API.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Dear Developers,

We are quite often asked about how to add users to a project using GoodData REST API. We already have description on how to use the [CL Tool to add users programmatically](http://developer.gooddata.com/blog/2011/07/14/add-user-to-project/). We are very aware of the fact that some of you are not really well versed using our CL Tool and would prefer the REST API way. If the REST API's are your cup of tea, this blogpost is for you.

Let's go through a simple example on how to use our User Provisioning API. First, you’ll need to create the project where you want to add the user. Basically, we will go through following three steps:

- create a project
- add user to a domain
- add user to a project

Just one more thing before we really start applying our API calls. You’ll need to set the Content-type header parameter to application/json and most of time you will send a json in the REST API calls.
 
## Project Creation

No project - No place to add users. As mentioned before, this should be the first step because if there is no project, then we won’t have a place to add the users. 

Firstly, you can call the API to get a list of your projects. This can be a bit tricky because the resource for getting all of your projects is not located on `/gdc/projects` but on `gdc/md`. That means by calling GET to 

`https://secure.gooddata.com/gdc/md` 

If everything is OK, you’ll get HTTP 200 parameter as a response.

Now, let's create a new project. Send POST http request to following resource

`https://secure.gooddata.com/gdc/projects`
 

{% highlight ruby %}
{ "project" : { 
     "meta": { 
         "title": "New Project", 
         "summary": "A new project"
      }, 
     "content": {
         "state" : "ENABLED" 
} } }
{% endhighlight %}
 
You should get a 201 Created header as a response with created project information in a body:

{% highlight ruby %}
{"uri":"/gdc/projects/<project-id>"}
{% endhighlight %}
 
## User Creation

We’ve got the project created, so now, we have a destination for the users we want to add. What we need to do now is to create a new user. There are several things to keep in mind here:

- You need to have a domain set up
- Only owner of the domain can use POST AccountSetting on this resource
- Password and verifyPassword must match, otherwise the resource reports validation error

What does this mean? It means if you don't have a domain created, you’ll need to ask our operations team to create it for you. You can ask them via our Support Portal.

The domain has already been created. You are authenticated. So now, It's time to provision users to your domain. Again, this is done via the REST API call. Use POST request to the 

<p>
<center><img src="{{ site.root }}/images/posts/add-user-to-domain.png" alt="Add user to domain"></center>
</p>

{% highlight ruby %}
{
 "accountSetting":{
    "login": "user@login.com",
    "password":"PASSWORD",
    "verifyPassword":" PASSWORD ",
    "firstName":"FirstName",
    "lastName":"LastName",
 }
}
{% endhighlight %}

This should be a response if everything was POSTed accurately:

(201 Created) % an uri of newly created user in format `/account/profile/<user-id>`

<p>
<center><img src="{{ site.root }}/images/posts/user-created.png" alt="Add user to project"></center>
</p>

Nice! We've just created new user in our domain!

## Add user to a project

Let's continue with our story, this is not the end. Remember what we want to do? Sure, we would like to add user to a specific project. How do we do it? Use POST `.json` to following resource:

<p>
<center><img src="{{ site.root }}/images/posts/add-user-to-project.png" alt="Add user to project"></center>
</p>
 
Following example will add new user that is identified by userId to the project in specific role (role and project are also specified by ID). Role ids are the following:

(1: Admin; 2: Editor; 3: Embedded dashboard only)
 
{% highlight ruby %}
{ "user" : {
     "content" : {
           "status":"ENABLED",
           "userRoles":["/gdc/projects/<project-id>/roles/<role-id>"]
                 },
     "links"   : {
           "self":"/gdc/account/profile/<user-id>"
                }
    }
}
{% endhighlight %}

If the API gives you a Header 200 respond, that’s a reason to smile because you have successfully added the user! Now, you are ready to integrate these calls to your custom apps. 

<p>
<center><img src="{{ site.root }}/images/posts/user-provisioned.png" alt="Add user to domain"></center>
</p>

One more thing. If you use `status: DISABLED` in user provisioning `json` file (shown above), you are able to disable the user from the project.

Let me know what you think! Best Regards,

JT