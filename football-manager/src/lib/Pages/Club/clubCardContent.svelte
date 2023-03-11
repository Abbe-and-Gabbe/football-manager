<script>
  import {Link} from "svelte-routing"
  const fetchNewsPromise = fetch("http://localhost:8080/team/:id/news")
</script>

<section class="animate-fade-in flex-col mt-10">
  <div class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in">
      <div class="container mx-auto p-4">
          <div class="flex items-center justify-center">
              <div class="p-4 bg-black rounded-lg shadow-md">
                  {#await fetchNewsPromise}
                      <p>Wait, I'm loading...</p>
                  {:then response}
                      {#await response.json() then allNews}
                          {#each allNews as news (news.id)}
                              <h2>{news.title}</h2>
                          {/each}
                      {/await}
                  {:catch error}
                      <p>Something went wrong, try again later.</p>
                  {/await}
              </div>
          </div>          
      </div>
  </div>
</section>
