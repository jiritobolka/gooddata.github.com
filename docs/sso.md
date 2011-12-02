---
title: GoodData SSO
layout: documentation
stub: docs-sso
---

# {{ page.title }}


## Overview

GoodData SSO is currently available on a per-request basis with individual partners. Both-sided cooperation is required in setting up the SSO. The process usually takes around 2 weeks. SSO is currently available for IFRAME embeds of individual reports or whole dashboards. The SSO allows 3rd-party partners to generate a unique URL asking GoodData to authorize viewer of that IFRAME as a specific user. User is then automatically logged into GoodData and able to view a specific dashboard/report without further interaction.

## Motivation / Example

Acme Corp. runs an online application for their users. They would like to expose GoodData dashboards to their customers. They have already setup a data synchronization with GoodData using [GoodData CL]({{ site.root }}/gooddata-cl/) and embedded dashboard IFRAME code into their website. However, their users would see a GoodData login screen (even after login into Acme application). Acme would like to enable their customers to view GoodData dashboard transparently, without the need for a second login, using the login information of the Acme application.

## Implementation Timeline

1. Partner generates an public-private PGP keypair. (You can use these setup instructions for [UNIX](http://www.gnupg.org/gph/en/manual.html#AEN26) or [Windows](http://www.coresecure.com/v5/gnupg.html))
2. Partner sends the public part of the keypair to support@gooddata.com 
3. Partner sends a list of email addresses of accounts to be enabled for SSO authentication.  
*Note:* these must be new account email addresses, pre-existing accounts currently cannot be converted to SSO.
6. GoodData deploys the new SSO keys and accounts to production environment
7. GoodData sends partner production public key (you can also <a href="gooddata-sso.pub">download it here</a>) 
8. Partner sets up the keys and his environment

## Implementation Details

1. Obtain IFRAME embed code from GoodData website (by clicking on the `Embed` link)
2. Save the original URL on the side and replace it with this URL:

        <iframe src="https://<server-host>/gdc/account/customerlogin?
         sessionId=<token>&amp;serverURL=<your-company>
         &amp;targetURL=<url-encoded-original-relative-URL"/>

   • the `server-host` parameter is a a hostname of the server where you want to use the SSO (for example secure.gooddata.com, or alternatively some testing server)  
   • the `your-company` parameter is a the http address to the domain name of your company (for example http://example.com)  
   • the `targetURL` is a relative URL to a dashboard  
   • the `token` parameter needs to be dynamically generated based on user you want to authenticate via the following steps
 
4. Start by constructing the following string in JSON:

        {"email": "user@domain.com","validity": 123456789}

   • the `email` corresponds to a user account set up in GoodData with SSO permissions (done by GoodData, see Implementation Timeline, step 5)  
   • the `validity` is a date in UTC timezone (in [UNIX timestamp](http://en.wikipedia.org/wiki/Unix_time) format) when this authentication should expire. It should always be > now (perhaps by at least 10 minutes to allow for network delays and server clock variations)

5. Sign this string using PGP with Partner private key, make sure **not** to use the `--clearsign` option:
<pre><code>gpg --armor -u user@domain.com --output signed.txt --sign json.txt</code></pre>
6. Encrypt the result from step 4 with GoodData public key
<pre><code>gpg --armor --output enc.txt --encrypt --recipient test@gooddata.com signed.txt</code></pre>

7. [URL-encode](http://meyerweb.com/eric/tools/dencoder/) the result from step 5

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

Supported encryption algorythms:

Pubkey: RSA, RSA-E, RSA-S, ELG-E, DSA  
Cipher: 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH
