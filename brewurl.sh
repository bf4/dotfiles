#!/usr/bin/env bash

awk '{
       if ($1 == "BREWPATH")
         app = $2
       else {
         where = match(`brew info` app, regex)
         if (where)
           print "Match of", regex, "found at", where, "in", $0
       }
}'

BREWPATH tomcat
