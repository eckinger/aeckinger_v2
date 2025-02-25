module Web.View.Photos.New where
import Web.View.Prelude
import Text.Blaze.Html4.FrameSet (input)
import           System.Process
import           Data.Text
import           Data.Time

data NewView = NewView { photo :: Photo }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}
        <h1>New Photo</h1>
        {renderForm photo}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Photos" PhotosAction
                , breadcrumbText "New Photo"
                ]

renderForm :: Photo -> Html
renderForm photo = formFor photo [hsx|
    {(textField #caption)}

    <div class="file-upload-wrapper">
        {(fileField #photoUrl)
            { additionalAttributes = [
                ("accept", "image/*"), ("data-preview", "#photoUrlPreview")
            ]}
        }

        <img id="photoUrlPreview"/>
    </div>
    {
        (dateField #photoDate) { placeholder = ""}
    }

    {submitButton}

|]

getDateFromPhoto :: String -> IO Text
getDateFromPhoto photoUrl = do
    date <- readProcess exiftoolCmd [] photoUrl
    pure $ pack date
        where
            exiftoolCmd = "exiftool -DateTimeOriginal -d %Y-%m-%d -p '$DateTimeOriginal'"
