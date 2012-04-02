---
title: Keboola Academy - Dashboard Macros
excerpt: The article shows the new feature - dashboard macros - and the way how Keboola used it.
layout: post
---

# {{ page.title }}

_by [Keboola](http://www.keboola.com)_

Hi, welcome to another Keboola Academy session!

GoodData is award winning and fastest growing SaaS BI platform. We at Keboola have the pleasure to work with GoodData and we enjoy pushing the BI experience to the limits. GoodData Release 68 allowed us bring some extra shine to our reports. Let us show you what our teammate Jakub Matejka has done with its brand new features.

Dashboard Macros were not described in the official release notes. But if you are one of the GoodData certified Solution Providers, like we are, you get notices about all the nice under-the-hood features. Dashboard Macros allow you to embed personalized content to your dashboards.

The personalization can be specified according to:

- a project,  
- a dashboard,  
- a dashboard tab,  
- a user  
- or any combination thereof.  

This means that you can display custom Web Content for any user in any dashboard tab. While this may sound nice, what exactly can you achieve with this? Let’s see a real world example. Our [Keboola Connection](http://www.keboola.com/connection) tool gathers clients’ data from various cloud sources (social networks, cloud based CRM and ERP systems, web traffic monitoring tools etc.), checks their integrity, enriches them and facilitates the automatic upload into the BI engine. We always want to display the latest possible and most accurate data. But what if it is not always possible?  For example, Facebook’s Graph API sometimes returns incomplete data that may break up reports that depend on them. And as a “bonus”, complete statistics for a Facebook page are available no sooner than 4 hours after midnight at the earliest... How to ensure that the customer can trust what they see in the reports?

<p>
<center>
<img src="{{ site.root }}/images/posts/keboola-dash-macros.png" alt="Facebook Analytics Dashboard">
</center>
</p>

This calls for some special treatment. Jakub developed a Keboola Object (that’s how we call the elements that [Keboola Connection](http://www.keboola.com/connection) offers for dashboard enhancements) that checks the integrity and completeness of the Facebook data and shows the result to the user. In GoodData terminology it’s a Web Content component - an iframe, that points to our server, where the Facebook data is stored. How do we identify the user, whose data is to be checked? As we deploy new users’ dashboards automatically from a template we cannot manually change some User ID in the Keboola Object’s URL. This is where the Dashboard macros come handy:

`%CURRENT_PROJECT_HASH%` - is extracted to the current project hash,  
`%CURRENT_DASHBOARD_URI%` - is extracted to the current dashboard URI,  
`%CURRENT_DASHBOARD_TAB_URI%` - is extracted to the current dashboard tab URI,  
`%CURRENT_USER_EMAIL_MD5%` - is extracted to the current user e-mail hash.  

We use this URL in the Web Content dialog:

`https://bi-facebook.keboola.com/object/status?pid=%CURRENT_PROJECT_HASH%`

The Dashboard macro in URL is replaced by the current project hash (Project ID / pid). Our server resolves the Project ID, checks the data and shows a green tick if everything is OK. The user can also click for a popup with detailed information. We wanted to keep this as unobtrusive as possible (did you even notice it in the screenshot?), but when an orange exclamation point or a red “X” kicks in the user is alerted.

Now let’s push this a little bit further … Imagine that you have multiple dashboards and tabs, each of which utilizes only a segment of the data. It is important to show warnings only if really necessary.  Using Dashboard macros we can limit the scope of the data being checked and thus display only relevant warnings. It can even go all the way down to a report level and give the confidence that a particular report has all the data required to show correct results.

By now you can probably imagine other use cases. And if not, Keboola Objects are growing in both numbers and their capabilities.

GoodData is great to analyze and display your data. Don’t be afraid of keeping your data in the cloud. [Keboola Connection tool](http://www.keboola.com/connection) and Keboola Objects give you powerful handle in the GoodData ecosystem. 

Good Luck!
[@Keboola](https://twitter.com/#!/keboola)  
<p>
<img src="{{ site.root }}/images/posts/KB_keboolaAcademy.png" alt="Keboola Academy" style="border: none; position: absolute; top: 50px; right: 50px;">
</p>