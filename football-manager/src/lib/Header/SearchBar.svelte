<script>
  import teams from "../../assets/data";
  import SearchResultsContainer from "./searchResultsContainer.svelte";

  // Change this in the future to fetch from the backend
  let res = teams;
  let searchResults = []; // Players might also be something that can be searched for?

  function search(e) {
    if (e.target.value === "") {
      searchResults = [];
      return;
    }
    searchResults = res.filter((item) => {
      return item.name.toLowerCase().includes(e.target.value.toLowerCase());
    });
  }
</script>

<div
  class="grid gap-12 grid-flow-row p-8 bg-slate-300 dark:bg-slate-800 m-2 rounded-xl"
>
  <form class="w-full px-12">
    <label
      for="default-search"
      class="mb-2 text-sm font-medium text-gray-900 sr-only dark:text-white"
      >Search</label
    >
    <div class="relative">
      <div
        class="absolute inset-y-0 left-0 flex items-center pl-3 pointer-events-none"
      >
        <svg
          aria-hidden="true"
          class="w-5 h-5 text-gray-500 dark:text-gray-400"
          fill="none"
          stroke="currentColor"
          viewBox="0 0 24 24"
          xmlns="http://www.w3.org/2000/svg"
          ><path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
          /></svg
        >
      </div>
      <input
        type="search"
        id="default-search"
        class="block w-full p-4 pl-10 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
        placeholder="Search for teams, players, etc."
        required
        on:input={search}
      />
    </div>
  </form>
  <SearchResultsContainer {searchResults}/>
</div>
