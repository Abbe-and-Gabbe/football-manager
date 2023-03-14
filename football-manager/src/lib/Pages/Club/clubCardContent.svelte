<script>

 
  export let news


</script>

<section class="animate-fade-in flex-col mt-10">
    <div
      class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in"
    >
    <div class="container mx-auto p-4">
        <div class="flex items-center justify-center">
        <div class="p-4 bg-black rounded-lg shadow-md" >
            <h2>{news.homeTeam}</h2>
            <p>{news.awayTeam}</p>
        </div>
        </div>
      
    </div>
    </div>
</section>
