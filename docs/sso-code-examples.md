---
title: Java SSO example
layout: documentation
stub: docs-sso-java
---

# {{ page.title }}

<br />
## How to use it

Use our prepared Java class to integrate your application with GoodData using the SSO. The class will help you with Generating the SSO token that you will be sending as a parameter to the 

**/gdc/account/customerLogin**

## How to get it

1. [Download]({{ site.root }}/docs/gdc-sso-sample-1.0.0.jar) .jar library

2. [Fork](https://github.com/gooddata/sso-example) it from Github repository

## Example usage

_PgpEncryptor_ class can be used for making signatures of documents and encrypting them.

### Initialization of com.gooddata.security.pgp.PgpEncryptor  

At first, instance of _PgpEncryptor_ must be created for further usage. It takes

<pre>
PgpEncryptor pgpEncryptor = new PgpEncryptor.Builder()
     .setPublicKeyForEncryption(new FileInputStream(path_to_gooddata_public_key))
     .setSecretKeyForSigning(new FileInputStream(path_to_sso_provider_private_key))
     .setSecretKeyPassword("mySecretPassword".toCharArray()) // for testing purposes this will be empty in most cases
     .createPgpEncryptor();
</pre>


## Signing

Let's have a simple json as an input message. We can sign this json message using
_com.gooddata.security.pgp.PgpEncryptor#encryptMessage(java.io.OutputStream, java.io.InputStream, boolean)_ method.
<pre>
final String message = "{\"email\": \"user@domain.com\",\"validity\": 123456789}";
final String privateKeyFile = "/path/to/private_key;
final ByteArrayOutputStream signedMessage = new ByteArrayOutputStream();
pgpEncryptor.signMessage(
              IOUtils.toInputStream(message),
              signedMessage,
              true);
System.out.println("My signed message: " + new String(signedMessage.toByteArray()));
</pre>

Signed message can be similar to following:

<pre>
-----BEGIN PGP MESSAGE-----
Version: BCPG v1.45

owJ4nJvAy8zAJNjvMNNTYe+LG4ajsklfPT8+LNLcxMDAwNDc0sDUzNzIwtjMyN
9UpyC/xr0uKrlVJzEzNzlKwUlEqLU4scUvKB3Dy95PxcJR2lssSczJTMkkqgrKGR
sYmpmbmFZW3HVhYGQSaGUlYmkP48GefEAvfU3My8TIWQ1OISBQ0EvwTIz8xLV8hO
rdRTcE/NSy1KLElNUUiqVMjKLMrUq0rMyS9NSc1W0FVIyy9SKM3LLAFrUcjPy6lU
1FSwAXEckhML0sHGgdxkx8DFKQDz3+RrDPNsXfPmWj5lKwmQnmv6zH8q1+Om8/0M
892/F5svEQt9GOVz7d+Jf54ix1JVlAB27GRF
=smgj
-----END PGP MESSAGE-----
</pre>

## Encryption

Signed message from previous example can be directly used for "encryption" as an input message.

<pre>
final String publicKeyFile = "/path/to/public_key_for_encryption";
final ByteArrayOutputStream encryptedMessage = new ByteArrayOutputStream();
pgpEncryptor.encryptMessage(encryptedMessage, IOUtils.toInputStream(signedMessage), true);
System.out.println("Encrypted message. " + new String(encryptedMessage.toByteArray()));
</pre>

Encrypted message can be similar to following:

<pre>
-----BEGIN PGP MESSAGE-----
Version: BCPG v1.45
hQIOA3sav0dr/91SEAf9H6KU1TxqtrZwRYcmj7Nbz2F3+yHYx6UGLtRcQS5PFb0L
oekrYgLY/dPDz0FL0FvK/6Dsc3PGW9bqH0Y6xjgvQcDSRv9T6W7X2l7vtjYEK+3I
jl4JLFtHb6iK2bK/kAnkU+X+rxecqKnGqA/eamdso87Rog79efYwigMlV6Hh/QS0
RB9KK4ZbvHdWXaJMoVFsrA3BC22PBvww/QJcUOb84etUZBbqek1eNuGHebZW1z8d
1Mn+QkqvnbIfclhljmpjk3Q6UUhFiCAqigKCOkhh+dWQv8bxQtHK9qm+OfYWWO/9
4IzJxvVByz4t8sX9bebAp6z8mU/HJQXGKISUAHhywQf9ERtUaJnZsIPPL7dLUDs9
6VTlSOiasCCZCAufaXU0K/Fwk0siOSPgIAQAotl19tPmvNrgmnZn05yIqOaBAN21
2/NPNGZnpZoipD6vQD6+y2/CaEt8vpmlyCJ1ziDoRJMR8RMF8xml/+ZdHM4glkBN
Rn/khxf1qavsl1QE5t2JnGpbZPki/izBwxkANFjCUuuLK/4emql2sgt3ynP4O4n8
FQIgdksClSNOaseRYXoCoGofsIv1Kf89dp4UCi0Qua3P6mu4/q3Q4CpzuE+UlafO
p43ex7k1TN1bY03CkG8imWHoIwSsV1H/ij4jhi0VcmX7GnSCfCmD/lsJycbACE/h
RcnAwhV+P9Cr6dOWz6TgujVCu23NIsZDMfGXCfUMc4iLz5I5CL2MeMbn5QjGVqhK
I0IKa7Q+obhapeTRJKgOZlhiNj33DOfi2/zY/Ooz6xJgT7VuUwWtJSZEztguHh9X
DfHXdfvVsW7sqEh77pgKftzFNH/rAiHEF5dpBZJRjDwqzLTzx6rQyPJML58oLOTN
0Mx8cj8KsJN3FVk8926yiG3POQoXz4gWEvpyDtP1F0ylt+3TS5bPlLmfjyGGpX+p
UsFnNvLy7DEXj3xNrRTWRfOQZracXS7bDEzXM/pExhN1V6/L0BiutPuqscESq5hN
kyGdmG+N2pXdISjVMxqzJkCeOLqRWpU3Ga/3xu24UfFh7OzV12Iacb/a843NHX+Q
Mvk9YKpUkCEcV1p4a5JjtASkNz47CPBZqbqP9H2g++5zYWzIkhZ9F+pqZ6oAfKfQ
QqceSlpSJqEHz3EDvgicgRyG5GVhW8aWRfG1vYhDDQsuqAz/nN9mwM+/uLWcpCHt
x/JHf6Iv
=0K7c
-----END PGP MESSAGE-----
</pre>

