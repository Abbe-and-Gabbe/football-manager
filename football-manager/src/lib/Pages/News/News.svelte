<script>
    export let id;
    let news;

    const fetchNews = fetch(`http://localhost:8080/news/${id}`);
    fetchNews
        .then((res) => {
            return res.json();
        })
        .then((data) => {
            news = data;
            console.log(news);
        })
        .catch((error) => {
            console.error(error);
        });
</script>

<section class="animate-fade-in mt-10 flex items-center justify-center w-full">
    <div
        class="bg-slate-200 dark:bg-slate-800 p-12 rounded-xl lg:mx-44 mb-2 prose dark:prose-invert"
    >
        <h1>{news.title}</h1>

        <p>
            {news.content}
        </p>

        <p>{news.firstName} {news.lastName}</p>
    </div>
</section>
