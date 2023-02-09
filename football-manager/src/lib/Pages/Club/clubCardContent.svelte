<script>
    import newsCards from "../../../assets/newsData";

    let currentPage = 0;
    function prevPage() {
    currentPage--;
  }

  function nextPage() {
    currentPage++;
  }

</script>

<section class="animate-fade-in flex-col mt-10">
    <div
      class="bg-slate-200 dark:bg-slate-800 flex justify-evenly flex-col p-12 lg:flex-row gap-2 rounded-xl items-center lg:mx-44 animate-fade-in"
    >
    <div class="container mx-auto p-4">
        <div class="flex items-center justify-center">
        <div class="p-4 bg-black rounded-lg shadow-md" 
            style="display: {currentPage >= 0 && currentPage < newsCards.length ? 'block' : 'none'}">
            <h2>{newsCards[currentPage].title}</h2>
            <p>{newsCards[currentPage].content}</p>
        </div>
        </div>
        <div class="mt-4 flex justify-between">
            <button on:click={prevPage} class="px-4 py-2 bg-black text-white rounded-full hover:bg-gray-900" disabled={currentPage === 0}>Previous</button>
            <span class="px-4 py-2 bg-black text-white rounded-full mr-5">{currentPage + 1} / {newsCards.length}</span>
            <button on:click={nextPage} class="px-4 py-2 bg-black text-white rounded-full hover:bg-gray-900" disabled={currentPage === newsCards.length - 1}>Next</button>
        </div>
    </div>
    </div>
</section>
