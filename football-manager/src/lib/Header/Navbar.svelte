<script>
  import SearchBar from "./SearchBar.svelte";
  import UserNav from "./UserNav.svelte";
  import { Link } from "svelte-routing";
  export let location = "/";
</script>

<header
  class="w-auto bg-slate-400 dark:bg-slate-900 text-black dark:text-white p-2 shadow-2xl flex-row justify-evenly"
>
  <div class="flex justify-between items-center w-full">
    <h1 class="text-2xl font-bold prose dark:prose-invert">Football Manager</h1>
    <button class="text-2xl font-bold prose" location="Login">Login</button>
  </div>
  <SearchBar />
</header>
