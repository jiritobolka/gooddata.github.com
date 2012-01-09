---
title: Determining the Attribute Value ID
excerpt: How to identify the ID of attribute value.
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Hello everybody,

Today we have a basic and useful tip. I would like to describe some common principles in GoodData. I would show you how and where you can find the attribute element IDs. The following workflow will help you use the GoodData REST API, especially when you create the Mandatory User Filter. 

For those who are new to GoodData, every object in our platform has its own unique ID. That means that you can easily call 

`https://secure.gooddata.com/gdc/md/PROJECT_ID/obj/OBJECT_ID`

and you will get the object definition. So every report, attribute etc. has its unique ID and you can quite easily get it by calling the API. This is the first type of ID in GoodData. You probably already know how to use it. 

Today I would like to show you how you can identify the ID of given attribute value. Each attribute value is represented by unique ID and this ID is different to the metadata object ID.

Imagine that you would like to create new [Mandatory User Filter](http://developer.gooddata.com/blog/2011/12/07/Mandatory-User-Filters/). The question is - What is the easiest way to determine the attribute value ID? 

You want to filter reports by a specific department (which is a project attribute) for a specific user. You know the department's name, but you are not sure about the given department (= attribute element) ID. Let's use our grey pages.

The first step is well known, login to the GoodData platform using your credentials and grey pages. Go to

`https://secure.gooddata.com/gdc/account/login`

Enter the username and password. After submitting, you will receive two links, don't forget to click on one of them! This will set your Temporary Token cookie needed for authentication.

Secondly, go to `https://secure.gooddata.com/gdc/md/` where you can see all your existing projects. Select your project, click on the link, and you are in the project metadata resource. Now, go to the `https://secure.gooddata.com/gdc/md/PROJECT_ID/query/attributes` , see the screenshot below

<p>
<center><img src="{{ site.root }}/images/posts/determine-id/Attribute-List.png" alt="Attribute List"></center>
</p>

As you can see, all project attributes are listed here. Select the attribute that you want to use and click on the link again. It will bring you to the attribute description. 

In the picture below, the attribute object ID and URI are highlighted by red arrows and the object element's URI is highlighted by green arrows. Remember that attribute elements belong to a specific attribute display form. Keep in mind that you can set multiple display forms for one attribute. 

<p>
<center><img src="{{ site.root }}/images/posts/determine-id/Attribute-Definition.png" alt="Attribute Definition"></center>
</p>

Now the final part. Every attribute has some values and values may differ from various display Forms. These values are called elements and every element has its unique ID. See the element description for the Department attribute in the screenshot below

<p>
<center><img src="{{ site.root }}/images/posts/determine-id/Element-List.png" alt="Element List"></center>
</p>

As you can see in the screenshot above, you can easily determine the given element ID. In our example, the ID of the Human Resources Department is 4.

Just before finishing I would like to show you the Mandatory User Filter expression based on what we have from the example above:

`[/gdc/md/<project-id>/obj/<object-id>]=[/gdc/md/<project-id>/obj/<object-id>/elements?id=<element-id>]`

Remember that attribute element ID is totally different ID than object ID (report, attribute, metric)!

As you can see, it is necessary to know the attribute element ID to create new Mandatory User Filter. Read the article that will describe you the whole [Mandatory User Filter creation process](http://developer.gooddata.com/blog/2011/12/07/Mandatory-User-Filters/).

Have a nice day!