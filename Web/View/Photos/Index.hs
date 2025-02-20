module Web.View.Photos.Index where
import Web.View.Prelude

data IndexView = IndexView { photos :: [Photo] }

instance View IndexView where
    beforeRender view = do
        setLayout indexPhotosLayout

    html IndexView { .. } = [hsx|
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
            <tbody>{forEach photos renderPhoto}</tbody>
        </div>
    |]

renderPhoto :: Photo -> Html
renderPhoto photo = [hsx|
    <div class="overflow-hidden h-full w-full">
    <a href={photo.photoUrl} data-fancybox="gallery">
        <img src={photo.photoUrl}
             alt={photo.caption}
             class="block h-full w-full object-cover object-center opacity-0 animate-fade-in transition duration-500 transform scale-100 hover:scale-110">
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
