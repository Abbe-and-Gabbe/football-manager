<script>
  export let teams;
  let showTeams = false;

  function toggleTeams() {
    showTeams = !showTeams;
  }
</script>

<section class="animate-fade-in flex-col mt-10">
  <div class="bg-black dark:bg-slate-800 static justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in">
    <h1 class="text-left mb-10 text-3xl">Teams</h1>
      
      <div class="w-full bg-zinc-800 dark:bg-zinc-800 p-4">
        <h4 class="font-bold rounded-2xl border-8 border-black p-4 bg-slate-600 flex justify-center cursor-pointer" on:click={toggleTeams}>
          Teams
        </h4> 
        {#if showTeams && Array.isArray(teams)}
          {#each teams as team}
            <div class="bg-black dark:bg-slate-800 static justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in">
              <p>{team.teamName}</p>
            </div>
          {/each}

        {/if}
      </div>
  </div>
</section>
