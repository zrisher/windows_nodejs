# windows_nodejs
Chef cookbook for installing Node.js from binary on Windows.

## Usage

### Setup
Simply run or include the `windows_nodejs::install` recipe to install Node.

You can specify the version with `['windows_nodejs']['version']`. If you'd
like to make use of checksums, update `['windows_nodejs']['checksums']` with
the checksum for your version and architecture. PRs updating the provided
checksum list are welcome.

You can also specify a custom URI with `['windows_nodejs']['source']`. Ensure
you still provide the version, because it's checked against the registry entry
to determine whether it's already installed. When using a custom source,
specify your custom checksum with `['windows_nodejs']['checksum']`.

### Deploy
To run `npm install`...

## FAQ

> What about NPM?

It's included with Node!

> Why isn't this part of the official Chef Node.js cookbook?

See the conversation [here](https://github.com/redguide/nodejs/pull/129).

