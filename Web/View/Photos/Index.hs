module Web.View.Photos.Index where
import Web.View.Prelude

data IndexView = IndexView { photos :: [Photo] }

instance View IndexView where
    beforeRender view = do
        setLayout indexPhotosLayout

    html IndexView { .. } = [hsx|
        <div class="flex flex-wrap w-full">
            <!-- https://play.tailwindcss.com/D46qDJ4mxn -->
            <div class="columns-1 md:columns-2 lg:columns-3 gap-2 space-y-2">
                {
                  forEach

                    -- Turn [Photo] into [[Photo]] where each list is Photos of the same photoDate
                    (groupBy (\pic1 pic2 -> pic1.photoDate == pic2.photoDate) $
                      -- But first order all the photos by photoDate (descending)
                      sortBy (comparing $ Down . photoDate) photos)

                    -- So we get batches of same-date photos
                    renderPhotos
                }
            </div>
        </div>
    |]

renderPhotos :: [Photo] -> Html
renderPhotos photos = [hsx|
    {forEach photos renderPhoto}
|]
-- this case is impossible since there can be no photo without a corresponding date

renderPhoto :: Photo -> Html
renderPhoto photo = [hsx|
    <div class="overflow-hidden h-min w-full">
<!--
        <a href={photo.photoUrl}
            data-fancybox="gallery"
            data-caption={photo.caption}>
-->
            <img src={photo.photoUrl}
                 alt={photo.caption}
                 class="block object-cover object-center <!--opacity-0--> animate-fade-in transition duration-500 transform scale-100 hover:scale-110">
<!--
        </a>
-->
    </div>
<!--
    <tr>
        <td>{photo}</td>
        <td><a href={ShowPhotoAction photo.id}>Show</a></td>
        <td><a href={EditPhotoAction photo.id} class="text-muted">Edit</a></td>
        <td><a href={DeletePhotoAction photo.id} class="js-delete text-muted">Delete</a></td>
    </tr>
-->
|]
