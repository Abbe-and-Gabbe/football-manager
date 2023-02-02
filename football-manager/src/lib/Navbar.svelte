<script>
  import SearchBar from "./SearchBar.svelte";
  import UserNav from "./UserNav.svelte";
</script>

<header
  class="w-auto h-1/2 bg-slate-400 dark:bg-slate-900 text-black dark:text-white p-6 m-2 rounded-lg shadow-2xl"
>
  <div class="flex justify-between items-center w-full">
    <h1 class="text-2xl font-bold prose-h1">Football Manager</h1>
    <UserNav />
  </div>
  <SearchBar />
</header>
