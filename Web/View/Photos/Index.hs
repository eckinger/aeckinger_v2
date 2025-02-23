module Web.View.Photos.Index where
import Web.View.Prelude

data IndexView = IndexView { photos :: [Photo] }

instance View IndexView where
    beforeRender view = do
        setLayout indexPhotosLayout

    html IndexView { .. } = [hsx|
        <header class="flex w-full overflow-hidden pt-10 pb-1">
            <div class="container mx-auto flex flex-wrap items-center md:flex-no-wrap">
                <div class="mr-4 md:mr-8">
                    <a class="text-2xl font-signika font-bold" href="/">ALEXANDER ECKINGER</a>
                </div>
            </div>
        </header>

        <div class="container mx-auto">
            <h1 class="pt-10 pb-8">
                <section class="text-neutral-700">
                    <div class="container w-full">

                {
                groupAndRenderPhotos photos
                }

                    </div>
                </section>
            </h1>
       </div>
    |]

groupAndRenderPhotos :: [Photo] -> Html
groupAndRenderPhotos photos =
    forEach groupedPhotos renderPhotos
        where
            -- Turn [Photo] into [[Photo]] where each list is Photos of the same photoDate
            groupedPhotos = groupBy groupPhotos sortedPhotos
            groupPhotos = (\pic1 pic2 -> pic1.photoDate == pic2.photoDate)
            -- But first order all the photos by photoDate (descending)
            sortedPhotos = sortBy (comparing $ Down . photoDate) photos

renderPhotos :: [Photo] -> Html
renderPhotos photos = [hsx|
    <div class="flex flex-wrap w-full">
        <h1 class="text-white font-signika"> {(photos !! 0).photoDate} </h1>
        <div class="columns-1 md:columns-2 lg:columns-3 gap-2 space-y-2 place-content-center">
            {forEach photos renderPhoto}
        </div>
    </div>
|]

renderPhoto :: Photo -> Html
renderPhoto photo = [hsx|
    <div class="overflow-hidden h-min w-full">
            <img src={photo.photoUrl}
                 alt={photo.caption}
                 class="block object-cover object-center <!--opacity-0--> animate-fade-in transition duration-500 transform scale-100 hover:scale-110">
    </div>
|]
