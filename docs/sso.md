---
title: GoodData SSO
layout: documentation
stub: docs-sso
---

# {{ page.title }}

<br />
## Why SSO
 
If you would like to see GoodData dashboard inside your intranet or web application. The key benefits are:

- you don't need to login to GoodData to see embedded report/dashboard
- you can maintain your domain users

<p>
<center><img src="{{ site.root }}/images/docs/sso.png" alt="SSO visualization" class="no-border"></center>
</p>

## High Level Overview and Key Principles

**Domains**

Domain is user space that you can manage. In GoodData, domain is not part of GoodData project. As a GoodData customer, you can have your own domain, that means, you are able to add and maintain your users.  

**SSO Provider**

A user with the SSO provider can have access to GoodData project without using a password. User can be using his own SSO provider or other (i.e. SALESFORCE).

**User Provisioning**

Once you have your own domain, you can add or delete users inside your Domain. You can provision these users into GoodData Project, change their role etc. Only domain administrator user can provision other users to projects. 

<p>
<center><img src="{{ site.root }}/images/docs/user-management.png" alt="User Management" class="no-border"></center>
</p>

**Security**

Security is provided by asymmetric electronic signature. Partner's private key is encrypted by GoodData public key. More information below.

**Embedded Dashboard/Report**

The Report/Dashboard can be embedded to your application using following code:

	<iframe src="https://secure.gooddata.com/gdc/account/customerlogin?sessionId=TOKEN&amp;serverURL=YOUR-COMPANY&amp;targetURL=DASHBOARD-URL"/> 

where

`your-company` parameter is the http address to the domain name of your company (for 	example http://example.com)  

`targetURL` is a relative URL to a dashboard  

`token` parameter needs to be dynamically generated based on user you want to authenticate via the following steps

## What is needed to set up SSO

Following is necessary to send to enable the SSO for GoodData:
 
1) **admin user mail** - your domain admin email, technical user that you use for maintaining users

2) **url** (relative report or dashboard url) - necessary for implementation, to recognize which dashboard/report you want to embed

3) **pgp key** (signed and encrypted token) - See the process below, how the token should be signed and encrypted

4) **domain** (name of your domain) - GoodData will create domain for you

The main process must be done by engineering and the SSO is being released on in maintenance window or during the nearest release. 

## Implementation Process

1) End User/Partner sends SSO request with all necessary parts (described above) to **support@gooddata.com**  

2) GoodData deploy the new SSO keys and accounts to production environment

3) Partner sets up his environment

## How to create signed and encrypted SSO token
 
1) Start by constructing the following string in JSON:

	{"email": "user@domain.com","validity": 123456789}

the `email` corresponds to a user account set up in GoodData with SSO permissions (done by GoodData)  

the `validity` is a date in UTC timezone (in UNIX timestamp format, must be **INTEGER** data type) when this authentication should expire. It should always be > now (perhaps by at least 10 minutes to allow for network delays and server clock variations). 

2) Sign this string using PGP with Partner private key, make sure **not** to use the  
`--clearsign` option:

<pre><code>gpg --armor -u user@domain.com --output signed.txt --sign json.txt</code></pre>

3) Encrypt the result from step 3 with GoodData public key (you can download it [here](http://developer.gooddata.com/docs/gooddata-sso.pub))

<pre><code>gpg --armor --output enc.txt --encrypt --recipient test@gooddata.com signed.txt</code></pre>

4) [URL-encode](http://meyerweb.com/eric/tools/dencoder/) the result from step 5

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
	 	 	 		
			

## FAQ

`Has the domain admin automatically access to GoodData project?`

No. The domain user may not have an access to the project automatically.

`What are supported encryption algorythms?`

Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA  
Cipher: 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH
