<script>
  import { Link } from 'svelte-routing'

  let news;
  export let id
  const n = fetch(`http://localhost:8080/team/${id}/news`)
    n.then((res) => {
        return res.json()
    }).then((data) => {
        data.forEach((item) => {
            item.published = item.published.slice(0, 10)
        })
        news = data
    })
</script>

<div class="flex justify-center mt-10">
  <a href="/create-news" class="bg-blue-500 w-3/5 text-center	 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded-full">
    Create News
  </a>
</div>

<section class="animate-fade-in flex-col mt-10">
  {#if news}
  {#each news as item (item.id)}
  <div
    class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in mb-2"
  >
    <div
      class="prose dark:prose-invert p-12 border border-slate-600 rounded-xl bg-slate-300 dark:bg-slate-800 flex-row w-full text-center lg:text-left"
    >
    <Link to = "/news/{news.id}">{item.title}</Link>
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
