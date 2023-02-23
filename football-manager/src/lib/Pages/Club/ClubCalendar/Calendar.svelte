<script>
    import ClubNavBar from "../clubNavBar.svelte";
    export let id;
</script>

<ClubNavBar id = "{id}"/>

<section class="animate-fade-in flex-col mt-10">
    <div class="bg-slate-500 dark:bg-slate-800 static justify-evenly flex-col p-4 md:p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in">
      <h1 class="text-left mb-10 text-3xl">Club Calendar</h1>

    </div>
</section>