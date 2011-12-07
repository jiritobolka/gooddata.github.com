---
title: Let's get started with Mandatory User Filters
excerpt: Step by step tutorial, how to set up a Mandatory User Filter
layout: post
---

# {{ page.title }}

Hey, GoodData release #64 will be live pretty soon and you’ll definitely be interested in what we have in store for you. Mandatory User Filters...Not sure what to expect? Let's imagine the following situation: Your company has multiple departments, for example: Engineering, Accounting, HR etc.

Let’s say, you'd like to create a report, but want to set a filter for a specific user. Imagine, we would like to allow one user to see only numbers for a specific department (i.e. Human Resources), because there is no need to let him check the other department's numbers. How can we do that? 

Go through the following example and after reading it, the new user filter will be created. In practice, we will filter the report by a specific attribute element (attribute value). 

`Attribute = Department`  
`Attribute element = Human Resources`

First of all, lets check the report without the Mandatory User Filter defined. The user will see the following:

<p>
<center><img src="{{ site.root }}/images/posts/Report-without-muf.png" alt="Report Without MUF"></center>
</p>

*Note:* This time you can filter by attribute elements. It is not possible to filter report i.e. by metric.

## The Basics

As always, we prepare a simple API, so you can play around and start integrating into your Apps!

So, let's start. The Mandatory User Filter is a standard object in our platform. As any other object, it has a URI and you can set it up using API or find it using the gray pages at `md/query/` context. The steps will be the following:

1) Create a new user filter object  
2) Assign the user filter object to the user/users  
3) Check the functionality  

## Creating new Mandatory Filter Object

To create a new Mandatory Filter Object, you must be logged as an Admin. Creating a new Mandatory Filter Object is very similar to our other API calls. You need to define json, and POST it to the specific resource. See the screenshot from our popular REST Client for Firefox.

<p>
<center><img src="{{ site.root }}/images/posts/REST-Client-payload.png" alt="REST Client Payload"></center>
</p>

The resource for creating new Mandatory User Filters is the following:

`https://secure.gooddata.com/gdc/md/<project-id>/obj`

Here is the specific json payload:

{% highlight ruby %}
{
    "userFilter": {
        "content": {
            "expression": "[/gdc/md/<project-id>/obj/<object-id>]=[/gdc/md/<project-id>/obj/<object-id>/elements?id=<element-id>]"
        },
        "meta": {
            "category": "userFilter",
            "title": "User filter - HR Department"
        }
    }
}
{% endhighlight %}

They key part is in the expression statement, where you define an expression for the given user filter. You can not only use `=`, but also `<>`, `IN` or `NOT IN` inside an expression.

The only “tricky part” is that you need to know an attribute ID and attribute element ID. The easiest way how to get these identifiers is to use our “so called” gray pages. Go to following page:

`https://secure.gooddata.com/gdc/md/<project-id>/query/attributes`

Now, select your attribute and find the URI down in meta section. Then, you'll need to specify the attribute element that corresponds to the Human Resources Department. This can be done by using the elements link that will give you a list of all attribute elements. You can find it and use it's identifier in the json payload that is shown above.

The API response is 200 HTTP header and URI of newly created User Filter Object. As a next step, check the user filter existence by calling GET to the following resource:

`https://secure.gooddata.com/gdc/md/<project-id>/obj/<created-object-id>`

## Assign the MUF to the User object

Once we have the new filter defined, it's time to assign it to a user. Similar to the previous step, you'll need to specify user ID, you can find it on `/gdc/projects/<project-id>/users`, where you can find all users in the project and select the corresponding identifier.

The following resource and payload will connect the user with the user filter. 

Note: You can, for sure, specify multiple filters for one user.

`https://secure.gooddata.com/gdc/md/<project-id>/userfilters`

{% highlight ruby %}
{ 
	"userFilters": {
        "items": [
            {
                "user": "/gdc/account/profile/<user-id>",
                "userFilters": [
                    "/gdc/md/<project-id>/obj/<user-filter-object-id>"
                ]
            }
        ]
    }
}
{% endhighlight %}

As a response, you'll get json with the information that tells you whether the user filter was assigned to the user. Have a look at this example:

{% highlight ruby %}
{
  "userFiltersUpdateResult": {
      "failed": [],
      "successful": [
           "/gdc/account/profile/<profile-id>"
        ]
    }
}
{% endhighlight %}

Everything went smooth, right? So let's check the report numbers visibility for a defined user. See the report:

<p>
<center><img src="{{ site.root }}/images/posts/Filtered-Report.png" alt="Filtered Report"></center>
</p>

Well, that's all for today. Let us know your opinion, ideas and feedback. We can't wait to hear (and also see) how you, developers, are using the features that we are bringing to you. We are driven by your passion in using our tools and API's. Stay tuned for next time!!!
