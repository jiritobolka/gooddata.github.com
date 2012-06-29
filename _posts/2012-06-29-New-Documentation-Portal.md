---
title: Introducing the new API Documentation Portal
excerpt: Check out the new Documentation Portal and learn GoodData API
layout: post
---

# {{ page.title }}

Developers - good news! We are very happy to announce the launch of our new API documentation portal.

**Note:** Please use only developer credentials for testing your custom application with Apiary.io! 

Several weeks ago we started thinking about how to improve our API documentation here on Developer Portal. Our goal is to create easy to read documentation that is also engaging and really helps developers solve their problems. We were fortunate to have found a great partner - Apiary.io - that shares the same vision and helps us deliver this. The documentation style is shown in the picture below:

<p>
<center><img src="{{ site.root }}/images/posts/apiary-overview.png" alt="Apiary.io Overview" width="600"></center>
</p>

As you can see, the GoodData API is clearly documented, you can see all necessary resources, data payloads, code examples (in multiple languages) and responses that are being sent by the API. Follow the link to the [API documentation portal](http://docs.gooddata.apiary.io/).

<p>
<center><img src="{{ site.root }}/images/posts/example.png" alt="Example API" width="600"></center>
</p>

However the visual documentation and examples are just part of the Apiary functionality. As you can see on the screenshots, Apiary automatically prepares the code examples for each API resource so you can simply copy and paste it and start developing, exploring and debugging.

<p>
<center><img src="{{ site.root }}/images/posts/code.png" alt="Code examples" width="600"></center>
</p>

On top of that, you can send your API request through a debugging proxy (hosted by Apiary.io), which will compare your request with the API documentation and will highlight differences in your API call. This is very effective way to debug your code if you are developing a new app on top of the GoodData API.

<p>
<center><img src="{{ site.root }}/images/posts/inspector.png" alt="API calls inspector" width="600"></center>
</p>

## Using it with the CL Tool

Here’s a quick example to get you started if you are using the GoodData CL tool. It's extremely easy. First, go to the GoodData API documentation page at docs.gooddata.apiary.io. In the right column, use your Twitter or Github account to sign in and create a personal debugging proxy for you.

<p>
<center><img src="{{ site.root }}/images/posts/private-proxy.png" alt="Private proxy" width="600"></center>
</p>

Copy the proxy address and tell the CL tool to use that server instead of default GoodData server. Now you will send all requests to the proxy API server. Run your GoodData CL batch. Now back in your browser, select the Inspector section and see all your  API requests in detail.

**Note:** Please use only developer credentials for testing your custom application with Apiary.io! 

This way you can easily debug your custom tool or application that uses GoodData API. Try it now and let us know how it works for you!