<script>
  import { link } from "svelte-routing";
  import Person from "./Person.svelte";
  import TeamNavbar from "./TeamNavbar.svelte";

  export let id;
  let players;
  let staff;

  const fetchPlayers = fetch(`http://localhost:8080/team/${id}/players`);
  const fetchStaff = fetch(`http://localhost:8080/team/${id}/staff`);

  fetchPlayers
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      players = data;
    });

  fetchStaff
    .then((res) => {
      return res.json();
    })
    .then((data) => {
      staff = data;
    });
</script>

<TeamNavbar {id} />

<div
  class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col rounded-xl animate-fade-in p-6 mt-10 lg:mx-44"
>
  <section class="animate-fade-in flex-col mt-10">
    <!-- Add player button -->
    <a href="/team/{id}/add-player" use:link>
      <button
        class="bg-slate-500 hover:bg-slate-700 text-white font-bold py-2 px-4 rounded-full"
      >
        Add Player
      </button>
    </a>
    <div class="prose dark:prose-invert m-2">
      <h1>Players</h1>
    </div>
    {#if players}
      {#each players as person (person.id)}
        <a href={"/person/" + person.id} use:link>
          <Person {person} />
        </a>
      {/each}
    {/if}
  </section>
  <section class="animate-fade-in flex-col mt-10">
    <div class="prose dark:prose-invert m-2">
      <h1>Staff</h1>
    </div>
    {#if staff}
      {#each staff as person (person.id)}
        <Person {person} />
      {/each}
    {/if}
  </section>
</div>
