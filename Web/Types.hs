module Web.Types where

import           Generated.Types
import           IHP.ModelSupport
import           IHP.Prelude

data WebApplication = WebApplication deriving (Eq, Show)


data StaticController
    = WorkAction
    | WelcomeAction
    deriving (Eq, Show, Data)

data PhotosController
    = PhotosAction
    | NewPhotoAction
    | ShowPhotoAction { photoId :: !(Id Photo) }
    | CreatePhotoAction
    | EditPhotoAction { photoId :: !(Id Photo) }
    | UpdatePhotoAction { photoId :: !(Id Photo) }
    | DeletePhotoAction { photoId :: !(Id Photo) }
    deriving (Eq, Show, Data)
