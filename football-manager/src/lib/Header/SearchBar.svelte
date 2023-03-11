<script>
  import SearchResultsContainer from "./searchResultsContainer.svelte";

  let searchResults = [];

  function search(event) {
    if (event.target.value === "") {
      searchResults = [];
      return;
    }
    fetch("http://localhost:8080/team/:id")
      .then(response => response.json())
      .then(data => {
        searchResults = data;
      })
      .catch(error => {
        console.error(error);
        searchResults = [];
      });
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
        on:input={search}
      />
    </div>
  </form>
  <SearchResultsContainer {searchResults}/>
</div>
