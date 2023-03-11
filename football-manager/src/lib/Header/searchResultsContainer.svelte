<script>
  export let searchResults = []
  
  const fetchTeamsPromise = fetch("http://localhost:8080/team/:id", {
    method: "GET"
  }).then(response => response.json().then(data => searchResults = data))
</script>

<div
  id="searchResults"
  class:animate-slide-menu={searchResults.length > 0}
  class="flex-col border border-slate-400 rounded-xl animate-expand-in border-collapse w-full lg:w-1/2 m-auto"
>
  <!-- The api will only return 5-10 results, so we can just show them all -->
  {#await fetchTeamsPromise}
    <p>Wait, I'm loading...</p>
  {:then}
    {#each searchResults as team (team.id)}
      <div class="flex-row justify-center items-center p-6 animate-fade-in rounded border border-collapse border-slate-400 w-full hover:bg-slate-400 m-auto">
        <div class="flex justify-evenly items-center sm:px-12">
          <div class="w-1/2">
            <img src={team.logo || "https://via.placeholder.com/150"} alt="team logo" class="w-10 h-10 rounded-full m-2"/>
          </div>
          <div class="flex justify-between w-1/2 ">
            <span/>
            <p class="text-black dark:text-white">{team.teamName}</p>
          </div>
        </div>
      </div>
    {/each}
  {:catch error}
    <p>Something went wrong, try again later.</p>
  {/await}
</div>
