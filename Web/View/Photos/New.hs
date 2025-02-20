module Web.View.Photos.New where
import Web.View.Prelude
import Text.Blaze.Html4.FrameSet (input)

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
    {(dateField #date)}
    {(textField #caption)}

    <div class="file-upload-wrapper">
        {(fileField #photoUrl)
            { additionalAttributes = [
                ("accept", "image/*"), ("data-preview", "#photoUrlPreview")
            ]}
        }

        <img id="photoUrlPreview"/>
    </div>

    {submitButton}

|]
