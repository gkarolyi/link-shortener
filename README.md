# Simple URL shortener

This is a URL shortening service written using `Ruby on Rails` as part of a technical challenge.
This was a fun and interesting challenge to work on, and I will probably continue playing around
with and improving on it as I keep learning.

## Demo

This project is deployed live [here](https://gkarolyi-link-shortener.herokuapp.com/).

## Running Tests

To run tests, run the following command

```bash
  rake test test:system
```

## Run Locally

Clone the project

```bash
  gh repo clone gkarolyi/link-shortener
```

Go to the project directory

```bash
  cd link-shortener
```

Install dependencies

```bash
  bundle && yarn
```

Start the server

```bash
  rails server
```

In the development environment all TailwindCSS styles
are included, which leads to enormous payloads -
unused styles are purged in production.
