# windows_nodejs
Chef cookbook for installing Node.js from binary on Windows.

## Usage
Simply run or include the `windows_nodejs::install` recipe to install.

You can specify any version with `['windows_nodejs']['version']`. If you'd
like to make use of checksums, update `['windows_nodejs']['checksums']` with
the checksum for your version and architecture.

You can also specify a custom URI with `['windows_nodejs']['source']`. Ensure
you still provide the version, because it's checked against the registry entry
to determine whether it's already installed. In this case, specify your custom
checksum with `['windows_nodejs']['checksum']`.

## FAQ

> What about NPM?

It's included with Node!

> Why isn't this part of the official Chef Node.js cookbook?

See the conversation [here](https://github.com/redguide/nodejs/pull/129).

