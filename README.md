# Ekey

A ruby wrapper for API of the ekey.ru

## Installation

Add this line to your application's Gemfile:

    gem 'ekey'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ekey

## Usage

### api_key setup

First of all, setup `api_key`. To do this, put a file `ekey.rb` into rails config/initializers directory.

    Ekey::Config.api_key = <your_api_key>

If you aren't using rails, just make shure, api_key fills in before any API methods calls.

### Sending certificate request

To send certificate request (csr) to the certificate authority CA, use the `CSR.issue` method

    Ekey::Certificate.issue(csr)

Where the `csr` parameter is the signed certificate request in the `pem` format.
Here is shortened example of the csr in pem format:

    -----BEGIN CERTIFICATE REQUEST-----\nMIICTzCCAfwCAQAwggFEMT0wOwYDVQQDHjQEEAQ7BDUEOgRBBDAEPQQ0BEAAIAQfBDAEMgQ7BD4EMgQ4BEcAIAQSBDAEMgQ4BDsEPgQyMRUwEwYYVQUHHgwGHPQ\n-----END CERTIFICATE REQUEST-----

Result: a ruby Hash, in format: `{"created_request_id" => <number>}` or `{"error" => <message>}`.

### Getting issued certificates by request ids

In order to get issued certificates use

    Ekey::Certificate.get_certificates(request_ids)

Where request_ids is a collection of all request ids of the pending certificates in your application. It can be a String, Array or just one Fixnum.

Response: a JSON in format `[{"id" => <request_id>, "certificate" => <certificate_body>}]`, or if the certificate is'n issued yet - `[{"id" => <request_id>, "error" => "certificate is not ready yet"}]`. Response can contain both of this as well.

Note, that certificate is the only base64 string without BEGIN CERTIFICATE/END CERTIFICATE splitted by 64 characters.
Here is the shortened sample of the certificate value:

    MIIDZjCCAxOgAwIBAgIKXaz9BwAAAADF1jAKBgYqhQMCAgMFADCBkjEeMBwGCSqG\nSIb3DQEJARYPY29udGFjdEBla2V5LnJ1MQswCQYDVQQGEwJSVTEVMBMGA1UEBwwM\n0JzQvtGB0LrQstCwMTcwNQYDVQQKn8HsQFSfy9BDG+A==\n


## Contributing

1. Fork.
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


Copyright (c) 2012 by Dmitry Koprov (dkoprov), evrone.com

This project uses MIT LICENSE
