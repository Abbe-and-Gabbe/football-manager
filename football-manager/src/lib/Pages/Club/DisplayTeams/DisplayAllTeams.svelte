<script>
  import teamsData from "../../../../assets/TeamsData";
  let selectedTeamId = null;

  function toggleSelectedTeam(teamId) {
    selectedTeamId = selectedTeamId === teamId ? null : teamId;
  }
</script>

<section class="animate-fade-in flex-col mt-10">
  <div class="bg-black dark:bg-slate-800 static justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in">
    <h1 class="text-left mb-10 text-3xl">Teams</h1>
    {#each teamsData as team}
      <div class="w-full bg-zinc-800 dark:bg-zinc-800 p-4">
        <h4 class="font-bold rounded-2xl border-8 border-black p-4 bg-slate-600 flex justify-center cursor-pointer" on:click={() => toggleSelectedTeam(team.id)}>
          {team.titleName}
        </h4>
        {#if selectedTeamId === team.id}
          <div class="flex flex-col ml-10 mr-10">
            <ul>
              {#each team.teamNameForText as teamName}
                <li class="border-2 border-black p-2 rounded-xl bg-slate-800">
                  <a href="/team/{team.id}">{teamName}</a>
                </li>
              {/each}
            </ul>
          </div>
        {/if}
      </div>
    {/each}
  </div>
</section>
