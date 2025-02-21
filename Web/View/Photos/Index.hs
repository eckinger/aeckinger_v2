module Web.View.Photos.Index where
import Web.View.Prelude

data IndexView = IndexView { photos :: [Photo] }

instance View IndexView where
    beforeRender view = do
        setLayout indexPhotosLayout

    html IndexView { .. } = [hsx|
        <div class="columns-1 md:columns-2 lg:columns-3 gap-4 space-y-4 p-8">
            {forEach photos renderPhoto}
        </div>
    |]

renderPhoto :: Photo -> Html
renderPhoto photo = [hsx|
    <div class="overflow-hidden h-min w-full">
        <a href={photo.photoUrl} data-fancybox="gallery">
            <img src={photo.photoUrl}
                 alt={photo.caption}
                 class="block object-cover object-center opacity-0 animate-fade-in transition duration-500 transform scale-100 hover:scale-110">
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
