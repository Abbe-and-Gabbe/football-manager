<script>
  import { Link } from "svelte-routing";

  export let searchResults;
</script>

<div id="searchResults" class:animate-slide-menu={searchResults.length > 0} class="flex-col border border-slate-400 rounded-xl animate-expand-in border-collapse w-full lg:w-1/2 m-auto">
  {#if searchResults.length > 0}
    {#each searchResults as club (club.id)}
      <div class="flex-row justify-center items-center p-6 animate-fade-in rounded border border-collapse border-slate-400 w-full hover:bg-slate-400 m-auto">
        <Link to = "/club/{club.id}" on:click = {() => searchResults = []} class="text-black dark:text-white">
        <div class="flex justify-evenly items-center sm:px-12">
          <div class="w-1/2">
            <img src={club.logo || "https://via.placeholder.com/150"} alt="team logo" class="w-10 h-10 rounded-full m-2" />
          </div>
          <div class="flex justify-between w-1/2 ">
            <ul>
              <li>
                  {club.clubName}
              </li>
            </ul>
          </div>
        </div>
      </Link>
      </div>
    {/each}
  {:else}
    <p class="text-center text-gray-500 dark:text-gray-400 mt-4">
      No results found.
    </p>
  {/if}
</div>