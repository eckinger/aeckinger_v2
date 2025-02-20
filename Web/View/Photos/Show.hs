module Web.View.Photos.Show where
import Web.View.Prelude
import Web.View.Layout

data ShowView = ShowView { photo :: Photo }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>Show Photo</h1>
        <p>{photo}</p>
        <img src={photo.photoUrl}>

    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Photos" PhotosAction
                            , breadcrumbText "Show Photo"
                            ]
