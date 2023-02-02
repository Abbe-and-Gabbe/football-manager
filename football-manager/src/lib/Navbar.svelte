<script>
  import SearchBar from "./SearchBar.svelte";
  import UserNav from "./UserNav.svelte";

</script>
<header
  class="w-auto h-12 flex justify-between items-center bg-slate-200 dark:bg-slate-900 text-black dark:text-white p-10"
>
  <div class="items-center">
    <h1 class="text-2xl font-bold">Football Manager</h1>
  </div>
  <UserNav/>
</header>
<SearchBar/>
