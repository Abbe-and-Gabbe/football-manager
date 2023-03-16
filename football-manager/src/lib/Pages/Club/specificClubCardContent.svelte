<script>
  export let id
  export let newsId
  let specificNews

  const sn = fetch(`http://localhost:8080/club/${id}/news/${newsId}`);
  sn.then((res) => {
    return res.json();
  }).then((data) => {
    data.forEach((item) => {
      item.published = item.published.slice(0, 10);
    });
    specificNews = data;
    console.log(specificNews)
  });




</script>


<section class="animate-fade-in flex-col mt-10">
  {#if specificNews}
  
  {#each specificNews as item (item.newsId) }
  <div
    class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in mb-2"
  >
    <div
      class="prose dark:prose-invert p-12 border border-slate-600 rounded-xl bg-slate-300 dark:bg-slate-800 flex-row w-full text-center lg:text-left"
    >
    <h1>{item.title}</h1>
    <p class="prose dark:prose-invert truncate">
      {item.content}
    </p>
      <p class="prose dark:prose-invert truncate">
          {item.firstName} {item.lastName} - {item.published}
      </p>
    </div>
  </div>
  {/each}
  {/if}
</section>

<div class="flex justify-center mt-10">
  <a href="/update-news" class="bg-blue-500 w-1/4 text-center hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full  mr-80">
    Edit New
  </a>
  
  <button class="bg-blue-500 w-1/4 text-center hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full">
    Delete News
  </button>
</div>








