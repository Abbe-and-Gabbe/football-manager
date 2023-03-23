<script>
  import SearchResultsContainer from "./searchResultsContainer.svelte";

  let searchResults = [];

  // This should later be handled by the SDK

  async function search(e) {
    const searchQuery = e.target.value;

    if (searchQuery.length < 3) {
      searchResults = [];
      return;
    }

    const f = await fetch("http://localhost:8080/club");
    const data = await f.json();

    searchResults = data.filter((item) => {
      return item.clubName.toLowerCase().includes(e.target.value.toLowerCase());
    });
  }

  function debounce(func, wait) {
    let timeout;

    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout);
        func(...args);
      };

      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  }
</script>

<div
  class="grid gap-6 grid-flow-row p-4 bg-slate-300 dark:bg-slate-800  rounded-xl"
>
  <form class="w-full px-6">
    <label
      for="default-search"
      class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-white"
      >Search</label
    >
    <div class="relative">
      <input
        type="search"
        id="default-search"
        class="block lg:w-1/2 w-full m-auto p-4 pl-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        placeholder="Search for teams, players, etc."
        required
        on:input={// Wait 500ms before searching
        debounce(search, 500)}
      />
    </div>
  </form>
  <SearchResultsContainer {searchResults} />
</div>
