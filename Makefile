CSS_FILES += ${IHP}/static/vendor/flatpickr.min.css
# CSS_FILES += static/app.css

JS_FILES += ${IHP}/static/vendor/jquery-3.6.0.slim.min.js
JS_FILES += ${IHP}/static/vendor/timeago.js
JS_FILES += ${IHP}/static/vendor/flatpickr.js
JS_FILES += ${IHP}/static/helpers.js
JS_FILES += ${IHP}/static/vendor/morphdom-umd.min.js
JS_FILES += ${IHP}/static/vendor/turbolinks.js
JS_FILES += ${IHP}/static/vendor/turbolinksInstantClick.js
JS_FILES += ${IHP}/static/vendor/turbolinksMorphdom.js

include ${IHP}/Makefile.dist

