module Web.View.Static.Work where
import Web.View.Prelude
data WorkView = WorkView

instance View WorkView where
    html WorkView = [hsx|
        <div class="flex gap-5 fixed top-4 left-4 mt-4">
            <a href={WelcomeAction}>
                <span class={captionShadowClasses}></span>
                <span class={captionBorderClasses}>Return Home</span>
            </a>
        </div> 
        <div class="min-h-screen flex flex-col items-center">

            <h1 class="text-4xl font-bold mb-5 mt-40 text-center">
                <span class="text-highlight">Work</span>
            </h1>
            <p class="text-1xl mb-5 text-left px-20 font-signika">
            Coming soon...
            </p>

        </div>
        |]

-- https://tailwindflex.com/@leon-bachmann/elevated-button
buttonShadowClasses :: Text
buttonShadowClasses = "absolute top-0 left-0 mt-1 ml-1 h-full w-full rounded bg-black"

buttonBorderClasses :: Text
buttonBorderClasses = "fold-bold relative inline-block h-full w-full rounded border-2 border-black bg-white px-3 py-1 text-base font-bold text-black transition duration-100 hover:bg-yellow-400 hover:text-gray-900"

captionShadowClasses :: Text
captionShadowClasses = "absolute top-0 left-0 mt-1 ml-1 h-full w-full rounded bg-black"

captionBorderClasses :: Text
captionBorderClasses = "fold-bold relative inline-block h-full w-full rounded border-2 border-black bg-white px-3 py-1 text-xs font-bold text-black transition duration-100 hover:bg-yellow-400 hover:text-gray-900"
