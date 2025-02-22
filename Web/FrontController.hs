module Web.FrontController where

import           IHP.RouterPrelude
import           Web.Controller.Prelude
import           Web.View.Layout        (frontLayout)

-- Controller Imports
import           Web.Controller.Photos
import           Web.Controller.Static

instance FrontController WebApplication where
    controllers =
        [ startPage WelcomeAction
        , parseRoute @StaticController
        -- Generator Marker
        , parseRoute @PhotosController
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout frontLayout
        initAutoRefresh
