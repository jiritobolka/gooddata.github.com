---
title: GoodData SSO
layout: documentation
stub: docs-sso
---

# {{ page.title }}

<br />
## Why SSO
 
To see a GoodData dashboard inside your intranet or web application. The key benefit is that you can embed GoodData reports and dashboards inside your application without logging.

<p>
<center><img src="{{ site.root }}/images/docs/sso.png" alt="SSO visualization" class="no-border"></center>
</p>

## High Level Overview and Key Principles

**SSO Provider**

A user with the SSO provider can have access to GoodData project without using a password. User can be using his own SSO provider or other (i.e. SALESFORCE).

**SSO Security**

The SSO Security is provided by an asymmetric electronic signature. Partner's public key is sent to GoodData to allow security token decryption.

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

The main process must be done by engineering and the SSO is being released in maintenance window or during the nearest release. 

## How to generate pgp keypair

There are several options to generate new public/private key pair. You can use gpg command line utility or download desktop app, that will help you with generating the public/private key pair. If are using the gpg command line utility, generate the new keypair using following command

<pre><code>gpg --gen-key</code></pre>

Once you have your new key generated, import the GoodData Public Key to your keystore:

<pre><code>gpg --import gooddata-sso.pub</code></pre>

If you would like to use desktop client - try to use [Mac GPG](http://macgpg.sourceforge.net/) for Mac OS, or [GPG4Win](http://files.gpg4win.org/gpg4win-2.1.0.exe) for Windows platform.

## Implementation on client/partner side
 
Following steps will give you an explanation of how you create token that will be used for SSO login. This token is sent as a parameter to customerLogin API resource (as a part of embedded dashboard/report):
 
1) Start by constructing the following string in JSON:

**Note:** The email is case sensitive. So User@domain.com is not the same as user@domain.com.

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

## Debbuging

**Error message:** "Message signature verification failed. Message has not been signed by SSO provider corresponding to serverURL=http://domain.com"

**Possible Solutions:**

- The serverURL parameter should start with "http://". Actually, it should be "http:%2F%2F" after URL encoding

- Check the sessionId parameter. It should not include whitespaces or '+' characters. If this is the case, the parameter is not URL encoded properly. If you use Ruby, use CGI.escape for URL encoding. 

- Check the sessionId parameter again. URL decode it (e.g. using this [tool](http://meyerweb.com/eric/tools/dencoder/)). The URL decoded sessionId should look like this:

<pre>

-----BEGIN PGP MESSAGE-----  
Version: GnuPG v1.4.12 (Darwin)  

hQEMA11tX1FLU9c7AQgAoiuE4aWhEqfTGNktBllpJEF6K33JV2k/MKBh5HnA9qyd  
ljW/R3Wi1a3G7MLM2um9MMp3Zb+S1iv3+kXVtMisYb2HuXCFSXNhXwvI2g20S9rs  
M4nZr7uiyJPH7Az+nromPz2tn5FlkhQBeEKIzmV22a1PXPnGrNn9ALzOOkC5CM9Y  
Nqw0tCadMI8qzXzz/jPjjbF/eP5F+CKVluiRQKtrl1S17I20RyxVbD14AbW6qhOL  
H4H2MSgCR8aF8zaFT7BMKceWQKBUKda98PcnFLjeY6jFVjofrjpvQFlTx+1Kiepf  
zFyk/2tY2GUs1ltfU02DmBsumXL7dP/S/sDdLeLqR9LpAV3F+wAft/40Jr1KEwjr  
kgHd/sxq2g4lzWvFC6qJlbdTqBnEYQyCigUAwogg2Dpe4v5hvjbt95CnNPTEviYM  
tvzs5MbrhG14g9AIObSozbB9S18kCTd+XUrZeYf5coRvVRTS2CXHDdp5SB+a3Ti/  
8ez7bblS6XVfAURn6iTKtEJt3/N2rqJymCSAaU+F3Y8nyzanB5b/XWt1rbJSzIZV  
xjsOorfLFdFZplnSRWR3mhW6YOZKlQmdGZbPfTdEgr8AzEF/YKpQ7RBZxtG9gM3M  
yHUu5sijkRNo1sZP8Cdj5W+owmoR+ft2/FOKiztUlpjxENZef0nYcCVPn6fAMlsR  
hQmbtsjl6UoqFcbJmkJ69eh43VDXnzpLwsQN/4e8n3WYI0LzTQ++dkdLuPuphhgK  
zeyEjqqdbzraSvL8ssp4g1y4mu2Sa70wsHABbIid8UTvIeFEMjmospZypKL6vmcY  
XK0cuyrRTXPn6F+mCZmRWKMF0tg4XQv8kuELsbumHE5t0coE9ziKfGLMtnsSgo3S  
VdKFgMEVqfV9zt4zWyg0S4J/I04Uo8In2AuQ3kXbOTmwGkaxIgCvQ1SySukBO9Fi  
KZbiuMtuJ4DPLY4S8oHzBscihczMz4/tAMVdkDgGhR4vB9OxjZ6P9vG16MiLRwsK  
5mbr+1v8EHVOh3qpCDwD4u40uMjxK6Q5qOgyoZNp9lBOTRlWtc7o6ty5ybtzRABv  
5ClJZbuolQF8/9PeHjWE23UjmS6xXA==
=TgFF
-----END PGP MESSAGE-----
</pre>

It should be enclosed with the BEGIN/END lines as above. The encoded string should not include whitespaces. All lines of the body should be of the same length except for the last two lines.

**Error:** Dashboard not found (may occur only in Safari while it works in Chrome and Firefox)

**Solution:** The targetURL parameter should be URL encoded (it should not include the '#' character)

