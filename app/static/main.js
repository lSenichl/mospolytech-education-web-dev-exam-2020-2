$('#delete-movie-modal').on('show.bs.modal', function (event) {
    let url = event.relatedTarget.dataset.url;
    let form = this.querySelector('form');
    form.action = url;
    let movieName = event.relatedTarget.dataset.movie;
    this.querySelector('#movie-name').textContent = movieName;
})

function imagePreviewHandler(event) {
    if (event.target.files && event.target.files[0]) {
        let reader = new FileReader();
        reader.onload = function (e) {
            let img = document.querySelector('.background-preview > img');
            img.src = e.target.result;
            if (img.classList.contains('d-none')) {
                let label = document.querySelector('.background-preview > label');
                label.classList.add('d-none');
                img.classList.remove('d-none');
            }
        }
        reader.readAsDataURL(event.target.files[0]);
    }
}

const TOOLBAR_ITEMS = [
    "bold", "italic", "heading", "|", 
    "quote", "ordered-list", "unordered-list", "|",
    "link", "|",  
    "preview", "side-by-side", "fullscreen", "|",
    "guide"
]

window.onload = function() {
    let background_img_field = document.getElementById('background_img');
    if (background_img_field) {
        background_img_field.onchange = imagePreviewHandler;
    }
    if (document.getElementById('text-content')) {
        let easyMDE = new EasyMDE({
            element: document.getElementById('text-content'),
            toolbar: TOOLBAR_ITEMS,
        });
    }
}