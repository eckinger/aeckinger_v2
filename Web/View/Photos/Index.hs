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
                {forEach photos renderPhoto}
            </div>
        </div>
    |]

renderPhoto :: Photo -> Html
renderPhoto photo = [hsx|
    <div class="overflow-hidden h-min w-full">
        <a href={photo.photoUrl} data-fancybox="gallery" data-caption={photo.caption}>
            <img src={photo.photoUrl}
                 alt={photo.caption}
                 class="block object-cover object-center animate-fade-in transition duration-500 transform scale-100 hover:scale-110">
        </a>
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
