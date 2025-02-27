module Config where

import IHP.Prelude
import IHP.Environment
import IHP.FrameworkConfig
import Web.View.CustomCSSFramework
import IHP.FileStorage.Config

config :: ConfigBuilder
config = do
    -- See https://ihp.digitallyinduced.com/Guide/config.html
    -- for what you can do here
    option Development
    option (AppHostname "localhost")

    initStaticDirStorage
    -- Tailwind
    option customTailwind
    pure ()
