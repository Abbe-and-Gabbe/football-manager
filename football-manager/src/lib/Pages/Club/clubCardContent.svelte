<script>
  let news;
  export let id;
  const n = fetch(`http://localhost:8080/club/${id}/news`);
  n.then((res) => {
    return res.json();
  }).then((data) => {
    data.forEach((item) => {
      item.published = item.published.slice(0, 10);
    });
    news = data;
  });
</script>

<section class="animate-fade-in flex-col mt-10">
  {#if news}
    {#each news as item}
      <div
        class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in mb-2"
      >
        <div
          class="prose dark:prose-invert p-12 border border-slate-600 rounded-xl bg-slate-300 dark:bg-slate-800 flex-row w-full text-center lg:text-left"
        >
          <h2>
            {item.title}
          </h2>
          <p class="prose dark:prose-invert truncate">
            {item.content}
          </p>
          <p class="prose dark:prose-invert truncate">
            {item.firstName}
            {item.lastName} - {item.published}
          </p>
        </div>
      </div>
    {/each}
  {/if}
</section>
