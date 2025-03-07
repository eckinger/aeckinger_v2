module Web.View.Layout (defaultLayout,
                        indexPhotosLayout,
                        frontLayout,
                        Html) where

import IHP.ViewPrelude
import IHP.Environment
import Generated.Types
import IHP.Controller.RequestContext
import Web.Types
import Web.Routes
import Application.Helper.View

defaultLayout :: Html -> Html
defaultLayout inner = [hsx|
<!DOCTYPE html>
<html lang="en">
    <head>
        {metaTags}

        {stylesheets}
        {scripts}

        <title>{pageTitleOrDefault "App"}</title>
    </head>
    <body>
        <div class="container mt-4">
            {renderFlashMessages}
            {inner}
        </div>
    </body>
</html>
|]

indexPhotosLayout :: Html -> Html
indexPhotosLayout inner = [hsx|
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
    <head>
    {indexPhotosMetaTags}
    {stylesheets}
    {fonts}
    {scripts}
    {indexPhotosScripts}
    </head>

    <body class="dark:bg-black bg-white h-screen text-black dark:text-white px-5 md:px-20 <!--opacity-0--> animate-fade-in transition duration-500">
        {renderFlashMessages}
        {inner}
        <script src={assetPath "/photos.js"}></script>
    </body>

</html>
|]

frontLayout :: Html -> Html
frontLayout inner = [hsx|
<!DOCTYPE html>
<html lang="en">
    <head>
        {metaTags}
        {stylesheets}
        {scripts}
        {fonts}
    </head>

    <body class="bg-[url(/photo_background.webp)] bg-cover bg-center bg-black">
        {renderFlashMessages}
        {inner}
        
        <!-- photo_background Caption -->
        <div class="flex gap-5 fixed bottom-4 left-4">
            <a href="https://www.alltrails.com/trail/us/arizona/scholz-lake">
                <span class={captionShadowClasses}></span>
                <span class={captionBorderClasses}>Scholz Lake, Flagstaff</span>
            </a>
        </div> 
    </body>
</html>
|]

-- https://tailwindflex.com/@leon-bachmann/elevated-button
captionShadowClasses :: Text
captionShadowClasses = "absolute top-0 left-0 mt-1 ml-1 h-full w-full rounded bg-black"

captionBorderClasses :: Text
captionBorderClasses = "fold-bold relative inline-block h-full w-full rounded border-2 border-black bg-white px-3 py-1 text-xs font-bold text-black transition duration-100 hover:bg-yellow-400 hover:text-gray-900"

-- The 'assetPath' function used below appends a `?v=SOME_VERSION` to the static assets in production
-- This is useful to avoid users having old CSS and JS files in their browser cache once a new version is deployed
-- See https://ihp.digitallyinduced.com/Guide/assets.html for more details

stylesheets :: Html
stylesheets = [hsx|
        <link rel="stylesheet" href={assetPath "/vendor/flatpickr.min.css"}/>
        <link rel="stylesheet" href={assetPath "/app.css"}/>
    |]
fonts :: Html
fonts = [hsx|
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin="">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Signika:wght@400;700&amp;display=swap" rel="stylesheet">
|]

scripts :: Html
scripts = [hsx|
        {when isDevelopment devScripts}
        <script src={assetPath "/vendor/jquery-3.6.0.slim.min.js"}></script>
        <script src={assetPath "/vendor/timeago.js"}></script>
        <script src={assetPath "/vendor/flatpickr.js"}></script>
        <script src={assetPath "/vendor/morphdom-umd.min.js"}></script>
        <script src={assetPath "/vendor/turbolinks.js"}></script>
        <script src={assetPath "/vendor/turbolinksInstantClick.js"}></script>
        <script src={assetPath "/vendor/turbolinksMorphdom.js"}></script>
        <script src={assetPath "/helpers.js"}></script>
        <script src={assetPath "/ihp-auto-refresh.js"}></script>
        <script src={assetPath "/app.js"}></script>
|]


devScripts :: Html
devScripts = [hsx|
        <script id="livereload-script" src={assetPath "/livereload.js"} data-ws={liveReloadWebsocketUrl}></script>
|]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="robots" content="noindex, nofollow"/>
    <meta property="og:title" content="App"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="TODO"/>
    <meta property="og:description" content="TODO"/>
    {autoRefreshMeta}
|]

indexPhotosScripts :: Html
indexPhotosScripts = [hsx|
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>
    <!-- Start - Fancybox Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.umd.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fancyapps/ui@5.0/dist/fancybox/fancybox.css" />
    <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
    <!-- End - Fancybox Scripts -->
|]

indexPhotosMetaTags :: Html
indexPhotosMetaTags = [hsx|
    {metaTags}
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    {autoRefreshMeta}
|]
