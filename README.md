# PLEASE NOTE, THIS PROJECT IS NO LONGER BEING MAINTAINED
# Ekey

A ruby wrapper for API of the ekey.ru

<a href="https://evrone.com/?utm_source=github.com">
  <img src="https://evrone.com/logo/evrone-sponsored-logo.png"
       alt="Sponsored by Evrone" width="231">
</a>

## Getting Started
### Installation

Add this line to your application's Gemfile:

    gem 'ekey'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ekey
    
### Usage

##### api_key setup

First of all, setup `api_key`. To do this, put a file `ekey.rb` into rails config/initializers directory.

    Ekey::Config.api_key = <your_api_key>

If you aren't using rails, just make shure, api_key fills in before any API methods calls.

##### Sending certificate request

To send certificate request (csr) to the certificate authority CA, use the `CSR.issue` method

    Ekey::Certificate.issue(csr)

Where the `csr` parameter is the signed certificate request in the `pem` format.
Here is shortened example of the csr in pem format:

    -----BEGIN CERTIFICATE REQUEST-----\nMIICTzCCAfwCAQAwggFEMT0wOwYDVQQDHjQEEAQ7BDUEOgRBBDAEPQQ0BEAAIAQfBDAEMgQ7BD4EMgQ4BEcAIAQSBDAEMgQ4BDsEPgQyMRUwEwYYVQUHHgwGHPQ\n-----END CERTIFICATE REQUEST-----

Result: a ruby Hash, in format: `{"created_request_id" => <number>}` or `{"error" => <message>}`.

##### Getting issued certificates by request ids

In order to get issued certificates use

    Ekey::Certificate.get_certificates(request_ids)

Where request_ids is a collection of all request ids of the pending certificates in your application. It can be a String, Array or just one Fixnum.

Response: a JSON in format `[{"id" => <request_id>, "certificate" => <certificate_body>}]`, or if the certificate is'n issued yet - `[{"id" => <request_id>, "error" => "certificate is not ready yet"}]`. Response can contain both of this as well.

Note, that certificate is the only base64 string without BEGIN CERTIFICATE/END CERTIFICATE splitted by 64 characters.
Here is the shortened sample of the certificate value:

    MIIDZjCCAxOgAwIBAgIKXaz9BwAAAADF1jAKBgYqhQMCAgMFADCBkjEeMBwGCSqG\nSIb3DQEJARYPY29udGFjdEBla2V5LnJ1MQswCQYDVQQGEwJSVTEVMBMGA1UEBwwM\n0JzQvtGB0LrQstCwMTcwNQYDVQQKn8HsQFSfy9BDG+A==\n

## Contributing

Please read [Code of Conduct](CODE-OF-CONDUCT.md) and [Contributing Guidelines](CONTRIBUTING.md) for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. 
For the versions available, see the [tags on this repository](https://github.com/evrone/ekey/tags). 

## Authors

* [Dmitry Koprov](https://github.com/dkoprov)

See also the list of [contributors](https://github.com/evrone/ekey/contributors) who participated in this project.

## License

This project is licensed under the [MIT License](LICENSE).
