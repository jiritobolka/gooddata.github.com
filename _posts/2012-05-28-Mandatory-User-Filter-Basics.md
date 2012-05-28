---
title: Mandatory User Filters for Beginners
excerpt: Step-by-Step guide How to create and assign Mandatory User Filter
layout: post
---

# {{ page.title }}

_by Eric Albanese & Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

This is a basic example showing the specifics to create and assign Mandatory User Filters. Below are two documentation links. This guide is meant to serve those who have not used the grey pages regularly before.

You can even read the [API documentation](http://developer.gooddata.com/api/mandatory-user-filter.html
) or related [previous blogpost](http://developer.gooddata.com/blog/2011/12/07/Mandatory-User-Filters/).

Mandatory User Filters (MUF) generally are used at the highest table of a data model. For this example, I want to filter my data model by an attribute named "Client Name" A MUF needs to be created for each instance. If I have 2 companies, Business A and Business B, then each needs it's own item.

## Creating the User Filter

First step is to find out the ID for the Attribute you want

`https://secure.gooddata.com/gdc/md/<project-id>/query/attributes`

Do a search on here for the title of your attribute you want. Click on the name to get more information. The last digits of the web address is the object ID for the attribute. Take note of this.

Example: 

`https://secure.gooddata.com/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/49857` 

This is the attribute I want to filter on. The object ID for this project is 49857. Next, around the 4th grouping of code there should be a link for "elements":

`https://secure.gooddata.com/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/49858/elements` 

- this is the link to the elements page looks like

On the elements page, you can scroll down and find the field you want to filter. In my example, I want to filter only "Company" data. Take note of the ID for the data element value.

Example:  
title: Company Corporation  
uri: `/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/49857/elements?id=1207166` 

- the ID for this data value is 1207166.

Next step is to run code to create the filter. Go to this address:

`https://secure.gooddata.com/gdc/md/<project-id>/obj`

Below is the code to run. Select JSON as Content Type

<pre>
{
    "userFilter": {
        "content": {
            "expression": "[/gdc/md/PROJECT_ID/obj/OBJECT_ID]=[/gdc/md/PROJECT_ID/obj/OBJECT_ID/elements?id=ELEMENT_ID]"
        },
        "meta": {
            "category": "userFilter",
            "title": "Example"
        }
    }
}
</pre>

Following along with our example, here is the code I used. Object-ID is for the attribute you want to filter on, and Element-ID is the data value you want filtered. Below is the code I ran for my example.

<pre>
{
    "userFilter": {
        "content": {
            "expression": "[/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/49857]=[/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/49857/elements?id=1207166]"
        },
        "meta": {
            "category": "userFilter",
            "title": "My Filter"
        }
    }
}
</pre>

After hitting submit a single line with a link to a URI should pop up. Click that to confirm the filter has been created. Here you should see information about the filter. Similar to above, the ID of the filter is the last digits of the address.

Example: 

`https://secure.gooddata.com/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/91074` 

- the ID for this user filter is 91074

Be sure to load up an instance of the project dashboard in the UI and hit refresh. This is needed to make sure the filter exists in the whole project.

## Assigning Filter to User

Next we need to assign the filter to a user. Go to this address

`https://secure.gooddata.com/gdc/md/PROJECT_ID/userfilters`

For my example, I went to:

`https://secure.gooddata.com/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/userfilters`

This brings me to the user filter submission page. Now I need to look up the ID for the user I want to filter on. To find this, go to the user list grey pages:

`https://secure.gooddata.com/gdc/projects/PROJECT_ID/users`

In my example, this was my address

`https://secure.gooddata.com/gdc/projects/zv8jkbo050hq9qeqwgzbsor550mf8mxy/users` 

This brought me to the user list for my project. Here you can search for the user you want. With each user, you want to copy and paste the corresponding text that goes with the "self" link. Keep this link on hand:

`/gdc/account/profile/70a966022bce7b4822a9a310a1919c03` 

- this is the link required to filter the data for user = myself

Finally, I need to send the filter request to GoodData. Go to this link:

`https://secure.gooddata.com/gdc/md/PROJECT_ID/userfilters`

For the box "User", copy and paste the link from 2 code breaks above. Example:

`/gdc/account/profile/70a966022bce7b4822a9a310a1919c03`

This is the text I used for the user field. Here's the code for the UserFilters section

<pre>
{
    "userFilters": {
        "items": [
            {
                "user": "/gdc/account/profile/USER-ID",
                "userFilters": [
                    "/gdc/md/PROJECT_ID/obj/USER-FILTER-ID"
                ]
            }
        ]
    }
}
</pre>

For my instance, here's the code selection:

<pre>
{
    "userFilters": {
        "items": [
            {
                "user": "/gdc/account/profile/70a966022bce7b4822a9a310a1919c03",
                "userFilters": [
                    "/gdc/md/zv8jkbo050hq9qeqwgzbsor550mf8mxy/obj/91074"
                ]
            }
        ]
    }
}
</pre>

This code assigns user 70a...c03 (myself) to the filter 91074. Multiple filters can be assigned per user at once. Hitting submit should get back this success result, or an error

<pre>
{
    "userFiltersUpdateResult": {
        "failed": [],
        "successful": [
            "/gdc/account/profile/PROFILE-ID"
        ]
    }
}
</pre>

What do you think about this? Are you already using Mandatory User Filters?

