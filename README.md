wintersmith-csv
===============

A [Wintersmith](https://github.com/jnordberg/wintersmith) plugin for processing CSV files.

CSV files will be served as normal, but the data they contain will be available in the content tree. It's added as `data` on the file's object.

Install using `npm install -g wintersmith-csv` and add to your `config.json` in the usual way.

It's assumed that the first line of the CSV file contains headers.