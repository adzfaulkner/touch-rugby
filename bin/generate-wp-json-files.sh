#!/bin/bash

pwd=${PWD}

curl http://localhost/wp/wp-json/wp/v2/posts -o $pwd/web/src/repositories/json/posts.json
curl http://localhost/wp/wp-json/wp/v2/categories -o $pwd/web/src/repositories/json/categories.json
curl http://localhost/wp/feed/rdf/ -o $pwd/web/src/repositories/json/rss.xml
