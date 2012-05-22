---
title: GoodData SSO
layout: documentation
stub: docs-sso
---

# {{ page.title }}

<br />
## Why SSO
 
To see GoodData dashboard inside your intranet or web application. The key benefit is that you can embed GoodData reports and dashboards inside your application without logging.

<p>
<center><img src="{{ site.root }}/images/docs/sso.png" alt="SSO visualization" class="no-border"></center>
</p>

## High Level Overview and Key Principles

**SSO Provider**

A user with the SSO provider can have access to GoodData project without using a password. User can be using his own SSO provider or other (i.e. SALESFORCE).

**SSO Security**

The SSO Security is provided by asymmetric electronic signature. Partner's public key is sent to GoodData to allow security token decryption.

<p>
<center><img src="{{ site.root }}/images/docs/keys.png" alt="Public-Private Keys" class="no-border"></center>
</p>

**Embedded Dashboard/Report**

The Report/Dashboard can be embedded to your application using following code:

	<iframe src="https://secure.gooddata.com/gdc/account/customerlogin?sessionId=TOKEN&amp;serverURL=SSO-IDENTIFIER&amp;targetURL=DASHBOARD-URL"/> 

the **/gdc/account/customerlogin** API resource is used to retrieve a dashboard/report from GoodData using SSO. Parameters are:

`sessionId` - Parameter needs to be dynamically generated based on user you want to authenticate via the following steps

`serverURL` - This is your SSO Identifier (name)

`targetURL` - Relative URL to dashboard or report (depends on what you want to embed)  

See the illustration that shows the whole process:

<p>
<center><img src="{{ site.root }}/images/docs/process.png" alt="SSO-Process" class="no-border"></center>
</p>

## Implementation Process

The whole process usually takes around 3 weeks.

1) End User/Partner sends SSO request with all necessary parts (described below) to **support@gooddata.com**  

2) GoodData deploy the new SSO keys and accounts to production environment

3) Partner sets up his environment

## What is needed to set up SSO

Following is necessary to send to enable the SSO for GoodData:

1) **admin user mail** - your domain admin email, technical user that you use for maintaining users (usually gooddata@your-company.com)

2) **public key** - your pgp public key (Please don't delete the PGP header and footer BEGIN/END)

3) **domain** (name of your domain) - GoodData will create domain for you

The main process must be done by engineering and the SSO is being released on in maintenance window or during the nearest release. 

## How to generate pgp keypair

There is several options to generate new public/private key pair. You can use pgp command line utility or download desktop app, that will help you with generating the public/private key pair. You can also [use this app](http://macgpg.sourceforge.net/).

## Implementation on client/partner side
 
Following steps will give you an explanation of how you create token that will be used for SSO login. This token is send as a parameter to customerLogin API resource (as a part of embedded dashboard/report):
 
1) Start by constructing the following string in JSON:

	{"email": "user@domain.com","validity": 123456789}

the `email` corresponds to a user account set up in GoodData with SSO permissions (email that you've previously sent to support@gooddata.com). This email will be used for logging through SSO Login resource.

the `validity` is a date in UTC timezone (in UNIX timestamp format, must be **INTEGER** data type) when generated token expire. It should always be > now (perhaps by at least 10 minutes to allow for network delays and server clock variations) and also < 36 hours. 

2) Sign this string using PGP with Partner private key, make sure **not** to use the  
`--clearsign` option:

<pre><code>gpg --armor -u user@domain.com --output signed.txt --sign json.txt</code></pre>

3) Encrypt the result from step 2 with GoodData public key (you can download the public key [here](http://developer.gooddata.com/docs/gooddata-sso.pub))

<pre><code>gpg --armor --output enc.txt --encrypt --recipient security@gooddata.com signed.txt</code></pre>

4) URL-encode the result from step 3

The above steps are summarized in this pseudo-code:

{% highlight js %}

token = pgp_encrypt(
pgp_sign(
    '{"email":' + userEmailString + ',"validity":' + (now+86400) + '}',
    my_private_key
  ),
  gooddata_public_key
);
{% endhighlight %}
	 	 	 		

If you want to use prepared classes and code examples, see the next [section]({{ site.root }}/docs/sso-code-examples.html).

## FAQ

`Has the domain admin automatically access to GoodData project?`

No. The domain user may not have an access to the project automatically.

`What are supported encryption algorithms?`

Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA  
Cipher: 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH
