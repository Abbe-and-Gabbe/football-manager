<script>
  import { link } from "svelte-routing";
  export let id;
  export let buttonText = "Click Me";
  export let location = "/";
</script>

<a
  href={location}
  use:link
  class="bg-slate-400 dark:bg-slate-500 p-3 rounded-xl dark:text-white hover:bg-slate-500 hover:dark:bg-slate-600"
>
  {buttonText}
</a>
