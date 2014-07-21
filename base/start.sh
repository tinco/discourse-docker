#!/bin/bash
cd /app && passenger start -p 80 --environment production --no-friendly-error-pages
