# UrlShortener

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

## NPM Installation

In case you're having troubles to install npm, make sure to follow the instructions to use the correct
version of npm. In the `.tools-version` file it uses version `12.9.0`, but you are free to use the one of
your preference.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Create a Short URL

The root page already opens a form to create your short URL, but you can also go to
`localhost:4000/links/new` instead.

## Show short URL created

After the URL is created, you will be redirected to `localhost:4000/links` where you can
see the most recent URLs created being on the top the most recent one.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
