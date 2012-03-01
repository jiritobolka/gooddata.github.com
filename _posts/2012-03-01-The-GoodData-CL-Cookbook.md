---
title: The GoodData CL Cookbook
excerpt: See how Acumen Solutions created application based on our CL tool.
layout: post
---

# {{ page.title }}

_by Jarrett Goldfedder (Global Services Manager @ [Acumen Solutions](http://www.acumensolutions.com/))_

In the year that Acumen Solutions has been partnering with GoodData, clients have come to us with requests to set up their projects and reports. By using GoodData as the solution, they have walked away pleased with the results because of the slick interface and ease-of-use.

Because the product is in high-demand, we have multiple requests - almost daily - to do the basic tasks necessary to administer GoodData:  

•	Create a project  
•	Edit the XML and MAQL files  
•	Add users  
•	Copy objects  
•	Configure the data loads  

Although the product documentation covers these activities at great length, getting our development team up to speed on these tasks using the provided CL Tool was a bit difficult at first. It often involved a steep learning curve and error-free copying-and-pasting of the commands.

After performing the setup activities a few times on our projects, we began to notice a particular deployment pattern emerge:

1.	Create an empty project
2.	Gather the data
3.	Run the XML against the data
4.	Configure the MAQL
5.	Load the data
6.	Clone the project for backup

We realized that each of these steps could be scripted with changes against the options, the names of the files being processed, the project ID, and the user initiating the CL script. We also recognized that this script could be reusable and designed for people who did not have the advanced coding background or prerequisite CL tool experience.

For this reason, we developed the GoodData CL Cookbook, written in Microsoft Excel and using Visual Basic for Applications (VBA) as a backend.  We chose Microsoft Excel both for its simplicity as well as its GUI interface with which most users are accustomed.

<p>
<center><img src="{{ site.root }}/images/posts/clCookBook.png" alt="CL Tool Cookbook" width="700" height="500"></center>
</p>

In the Cookbook, we provide multiple tabs designed to accomplish each of the CL tasks.  Users enter the specific parameters they have for their projects into labeled cells, and then at the push of a button can launch both a script generator as well as the GoodData CL command that actually executes the script. It’s easy enough to use, in fact users can even create entire project instances in less than 5 minutes without ever having to leave the application.

We found this tool highly useful in training our new staff and in creating both test bed and backup projects on-the-fly.  Of course, there is no substitution for learning the feature-rich CL tool itself, but the GoodData CL Cookbook is a great start for those who want to throw themselves right into accelerated project creation and report-building.
