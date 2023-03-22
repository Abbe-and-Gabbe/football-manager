<script>
  export let club
  import Calendar from "../../Components/Calendar.svelte";
</script>

<section class="animate-fade-in flex-col mt-10">
    <div
      class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in"
    >
    {#if club}
        

      <div
        class="prose dark:prose-invert p-12 border border-slate-600 rounded-xl bg-slate-300 dark:bg-slate-800 flex-row w-full text-center"
      >
        <h1>Welcome to <strong>{club.clubName}</strong></h1>
        <p>Underneath you can find some news about this club</p>
      </div>
    {/if}
    </div>
</section>


