---
title: Export selected Report using Grey Pages
excerpt: How to export selected report to pdf, png or csv
layout: post
---

# {{ page.title }}

_by Jiri Tobolka ([@jirtob](http://twitter.com/jirtob))_

Hi Devs!

Our friends from [Keboola](http://www.keboola.com) recently wrote a nice article about how they integrated the OpenBrand app with some magic in the GoodData Platform and how to get the raw data file from it. Today, I would like to show you a similar use case. We are going to export a selected report into a PDF file using our so called grey pages. Let's follow this workflow:

- Find the Report Definition
- Compute the Report using the xTab Report executor and Report URI
- Get the new Report Result
- Export the created Report Result
- Download the Exported file

Remember that you can use this workflow to integrate this feature to your custom App. The sample API calls are shown in our API Documentation.
 
Well, what is the case...I really like one of my report and I would like to export it and send it via email as an attachment. See the example below.

<p>
<center><img src="{{ site.root }}/images/posts/export-to-pdf/reportGD.png" alt="GoodData Report"></center>
</p>

I would like to show you how you can use this flow to get the report in PDF/CSV/PNG. First of all, you’ll need to identify your selected report. Then find it (using grey pages) and get the Report Definition URI. Let's open up your browser and type in following address:

`https://secure.gooddata.com/gdc/md/PROJECT_ID/query/reports/`

<p>
<center><img src="{{ site.root }}/images/posts/export-to-pdf/Query-Report.png" alt="List of all Reports"></center>
</p>

In the url above, you can find a full list of your reports, choose the right one and you will get the Report description (in JSON format), where you can find the Report Result URI. 

<p>
<center><img src="{{ site.root }}/images/posts/export-to-pdf/Report-Res.png" alt="Report Resource"></center>
</p>

The report description is what we need. In the picture above, you can see the green and red arrow. The green arrow is Report Result URI and the red arrow is Report URI. One Report could have a multiple Report Results. Latest Report Results is in the end of this part of JSON.
What we need to tell the xTab report executor to compute the report is the Report URL. Let's copy it to a clipboard. We'll paste it into the corresponding input field on following resource:

`https://secure.gooddata.com/gdc/xtab2/executor3/`

<p>
<center><img src="{{ site.root }}/images/posts/export-to-pdf/Executor.png" alt="Report Executor"></center>
</p>

This is the Report executor. Here you can paste the previously copied Report URI and let the Executor to compute the latest Report Result. Again, you will get the Report Result JSON, but now with the updated results. This may take a while depending on report data size. During the report computation, API will return the 202 HTTP status. When computation is finished, copy the Report Result URI highlighted in the screenshot below.

<p>
<center><img src="{{ site.root }}/images/posts/export-to-pdf/New-Report-Result.png" alt="New Report Result"></center>
</p>

Now, with the latest Report Results URI in your clipboard, go to the Report Exporter that is located in following address

`https://secure.gooddata.com/gdc/exporter/executor`

<p>
<center><img src="{{ site.root }}/images/posts/export-to-pdf/Exporter.png" alt="Report Exporter"></center>
</p>
 
This resource represents the Report Exporter. It's the place where you can insert the Report Result URI and choose your preferred format. The Exporter will do its job and will give you the result URI, and also it is the place where you can download your exported report. Again, the report exporting will take a while. During the exporting process API will, as in previous step, give you the 202 HTTP status.

Finally, the report in PDF is downloaded in your computer! Got it? Let's use it!