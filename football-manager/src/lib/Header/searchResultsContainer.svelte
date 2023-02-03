<script>
    export let searchResults
</script>
  <div
    id="searchResults"
    class:animate-slide-menu={searchResults.length > 0}
    class="flex-col border border-slate-400 rounded-xl w-1/2 animate-expand-in border-collapse m-auto"
  >
  <!-- The api will only return 5-10 results, so we can just show them all -->
    {#each searchResults as result}
      <div
        class="flex-row justify-center items-center p-6 animate-fade-in rounded border border-collapse border-slate-400 w-full hover:bg-slate-400 m-auto"
      >
        <div class="flex justify-evenly items-center sm:px-12">
          <div class="w-1/2">
            <img
              src={result.logo || "https://via.placeholder.com/150"}
              alt="team logo"
              class="w-10 h-10 rounded-full m-2"
            />
          </div>
          <div class="flex justify-between w-1/2 ">
            <span/>
            <p class="text-black dark:text-white">{result.name}</p>
          </div>
        </div>
      </div>
    {/each}
  </div>