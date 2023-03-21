<script>
  export let contactPersons;
</script>

<section class="animate-fade-in flex-col mt-10">
  <div class="prose dark:prose-invert m-2">
    <h1>Staff</h1>
  </div>
  {#if Array.isArray(contactPersons)}
    {#each contactPersons as person }
      <div class="bg-slate-200 dark:bg-slate-800 flex justify-between lg:flex-row gap-2 rounded-xl items-center animate-fade-in mb-2 hover:bg-slate-300 dark:hover:bg-slate-700 border border-slate-600 pl-12 ">
          <div class="flex flex-col prose dark:prose-invert">
            <h2>{person.firstName} {person.lastName}</h2>
            <p>Email: {person.email}</p>
            <p>Phone: {person.phoneNumber}</p>
            <p>Team: {person.teamName}</p>
          </div>
        <img src={person.image || "https://via.placeholder.com/100"} alt="" class="rounded" />
      </div>
    {/each}
  {/if}
</section>

